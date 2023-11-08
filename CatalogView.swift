import SwiftUI
import SwiftData
struct CatalogView: View {
    @Query private var items: [Item]

    var body: some View {
        List(items) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("Category: \(item.category)")
                    .font(.subheadline)
                Text("Price: $\(String(format: "%.2f", item.price))")
                    .font(.subheadline)
            }
        }
        .navigationTitle("Catalog")
    }
}
