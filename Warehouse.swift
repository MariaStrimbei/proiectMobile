import Foundation
import SwiftData

@Model
final class Warehouse {
    var addedAt: Date
    var location: String
    var name: String
    
  
    init(name: String, addedAt: Date) {
        self.name = name
        self.addedAt = addedAt
        self.location = "To add"
        
    }
}
