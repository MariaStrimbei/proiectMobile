import SwiftUI
import SwiftData

struct WarehouseEditView: View {
    @Environment(\.modelContext) private var modelContext
    @State var warehouse: Warehouse
    @State private var editedName: String
    @State private var editedLocation: String
    @State private var isSaved: Bool = false
    @State private var isDeleted: Bool = false

    init(warehouse: Warehouse) {
        self.warehouse = warehouse
        self._editedName = State(initialValue: warehouse.name)
        self._editedLocation = State(initialValue: warehouse.location)
    }

    var body: some View {
        Form {
            TextField("Name", text: $editedName)
            TextField("Location", text: $editedLocation)
            Button("Save") {
                
                warehouse.name = editedName
                warehouse.location = editedLocation
                try? modelContext.save()
                isSaved = true
            }
            .alert(isPresented: $isSaved) {
                Alert(
                    title: Text("Warehouse Saved"),
                    message: Text("Warehouse saved successfully"),
                    dismissButton: .default(Text("OK"), action: {
                        isSaved = false
                    })
                )
            }
            Button("Delete Warehouse", role: .destructive) {
            
                isDeleted = true
            }
        }
        .navigationTitle("Edit Warehouse")
        .navigationBarTitleDisplayMode(.inline)

        .alert(isPresented: $isDeleted) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this warehouse?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    modelContext.delete(warehouse)
                    try? modelContext.save()
                }),
                secondaryButton: .cancel({
                    isDeleted = false
                })
            )
        }
    }
}

struct WarehouseManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var warehouses: [Warehouse]
    @State private var newWarehouseName: String = ""
    
   

    var body: some View {
        NavigationView {
            List {
                ForEach(warehouses) { warehouse in
                    NavigationLink(destination: WarehouseEditView(warehouse: warehouse)) {
                        Text(warehouse.name)
                    }
                }
                .onDelete(perform: deleteWarehouses)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        TextField("New Warehouse Name", text: $newWarehouseName)
                            .textFieldStyle(.roundedBorder)
                        Button(action: addWarehouse) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
        .navigationTitle("Warehouse Management")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addWarehouse() {
        withAnimation {
            let newWarehouse = Warehouse(name: newWarehouseName, addedAt: Date())
            modelContext.insert(newWarehouse)
            newWarehouseName = "" // Reset the new warehouse name
        }
    }

    private func deleteWarehouses(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(warehouses[index])
            }
        }
    }
}

#Preview {
    WarehouseManagementView()
        .modelContainer(for: Warehouse.self, inMemory: true)
}

