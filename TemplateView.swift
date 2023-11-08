import SwiftUI
import SwiftData

/*struct ItemEditView: View {
    @Environment(\.modelContext) private var modelContext
    @State var item: Item
    @State private var editedName: String
    @State private var editedPrice: Double
    @State private var editedCategory: String
    @State private var editedWarehouseLocation: String
    @State private var isSaved: Bool = false
    @State private var isDeleted: Bool = false

    init(item: Item) {
        self.item = item
        self._editedName = State(initialValue: item.name)
        self._editedPrice = State(initialValue: item.price)
        self._editedCategory = State(initialValue: item.category)
        self._editedWarehouseLocation = State(initialValue: item.warehouseLocation)
    }

    var body: some View {
        Form {
            TextField("Name", text: $editedName)
            TextField("Price", value: $editedPrice, formatter: NumberFormatter())
            TextField("Category", text: $editedCategory)
            TextField("Warehouse Location", text: $editedWarehouseLocation)
            
            Button("Save") {
                          // Code to save the updated properties
                          item.name = editedName
                          item.price = editedPrice
                          item.category = editedCategory
                          item.warehouseLocation = editedWarehouseLocation
                          try? modelContext.save()
                          isSaved = true //  indicate the save is successful
                      }
            .alert(isPresented: $isSaved) {
                Alert(
                    title: Text("Item Saved"),
                    message: Text("Item saved successfully"),
                    dismissButton: .default(Text("OK"), action: {
                        isSaved = false // after confirming the message
                    })
                )
            }
            Button("Delete Item", role: .destructive) {
                // Code to delete the item
                isDeleted = true // confirm the deletion
            }
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert(isPresented: $isDeleted) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this item?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    modelContext.delete(item)
                    try? modelContext.save()
                }),
                secondaryButton: .cancel({
                    isDeleted = false // after canceling the deletion
                })
            )
        }
    }
}

struct StockManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var newItemName: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: ItemEditView(item: item)) {
                        Text(item.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        TextField("New Item Name", text: $newItemName)
                            .textFieldStyle(.roundedBorder)
                        Button(action: addItem) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
        .navigationTitle("Product Management")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(name: newItemName, addedAt: Date(), price: 0.0, category: "", warehouseLocation: "")
            modelContext.insert(newItem)
            modelContext.insert(newItem)
            newItemName = "" // Reset the new item name
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}
#Preview {
    StockManagementView()
        .modelContainer(for: Item.self, inMemory: true)
}
*/
