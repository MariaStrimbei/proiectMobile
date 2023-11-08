import SwiftUI
import SwiftData

struct CatalogItemView: View {
    let item: Item
    @State private var quantity: Int = 0

    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Text(String(format: "%.2f", item.price))
            Stepper(value: $quantity, in: 0...Int.max) {
                Text("Quantity: \(quantity)")
            }
        }
    }
}
