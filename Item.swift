import Foundation
import SwiftData

@Model
final class Item {
    var addedAt: Date
    var name: String
    var price: Double
    var category: String
    var warehouseLocation: String
    
    init(name: String, addedAt: Date,price: Double, category: String, warehouseLocation: String) {
        self.name = name
        self.addedAt = addedAt
        self.price = price
        self.category = category
        self.warehouseLocation = warehouseLocation
    }
}

