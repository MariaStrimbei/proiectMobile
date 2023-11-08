import SwiftUI
import SwiftData

struct ItemEditView: View {
    @Environment(\.modelContext) private var modelContext
    @State var item: Item
    @State private var editedName: String
    @State private var editedPrice: String
    @State private var editedCategory: String
    @State private var editedWarehouseLocation: String
    @State private var isSaved: Bool = false
    @State private var isDeleted: Bool = false

    let categories = ["Roofing and Siding", "Sanitary and Plumbing", "Electrical", "Flooring", "Doors and Windows", "Paint and Coatings"]
    let warehouseLocations = ["Warehouse A", "Warehouse B", "Warehouse C", "Warehouse D"]
    let pricePlaceholder = "Enter the price"

    init(item: Item) {
        self.item = item
        self._editedName = State(initialValue: item.name)
        self._editedPrice = State(initialValue: "\(item.price)") // Convert the price to a string
        self._editedCategory = State(initialValue: item.category)
        self._editedWarehouseLocation = State(initialValue: item.warehouseLocation)
    }

    var body: some View {
        Form {
            TextField("Name", text: $editedName)

            // Use a Picker for category selection
            Picker("Category", selection: $editedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }

            // Use a Picker for warehouse location selection
            Picker("Warehouse location", selection: $editedWarehouseLocation) {
                ForEach(warehouseLocations, id: \.self) { location in
                    Text(location)
                }
            }

            TextField(pricePlaceholder, text: $editedPrice)
                .keyboardType(.decimalPad)

            Button("Save") {
               
                item.name = editedName

                
                item.category = editedCategory

                if let priceValue = Double(editedPrice) {
                    
                    item.price = priceValue
                } else {
                    print("Invalid price format")
                }
                item.warehouseLocation = editedWarehouseLocation
                try? modelContext.save()
                isSaved = true
            }
            .alert(isPresented: $isSaved) {
                Alert(
                    title: Text("Item Saved"),
                    message: Text("Item saved successfully"),
                    dismissButton: .default(Text("OK"), action: {
                        isSaved = false
                    })
                )
            }

            Button("Delete Item", role: .destructive) {
               
                isDeleted = true
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
                    isDeleted = false
                })
            )
        }
    }
}



struct StockManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var newItemName: String = ""
    @State private var showCatalog = false

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
                ToolbarItem(placement: .bottomBar) {
                    Button("View Catalog") {
                        showCatalog = true
                    }
                }
            }
        }
        .navigationTitle("Product Management")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showCatalog) {
            NavigationView {
                CatalogView()
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(name: newItemName, addedAt: Date(), price: 0.0, category: " ", warehouseLocation: " ")
            modelContext.insert(newItem)
            newItemName = "" 
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

