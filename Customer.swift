import Foundation
import SwiftData

@Model
final class Customer {
    var id: Int
    var name: String
    var phoneNumber: String
    var addedAt: Date
    var businessName: String
    var email: String
    var address:String
    
   /* init(id: Int, name: String, addedAt: Date) {
        self.id = id
        self.name = name
        self.addedAt = addedAt
        self.phoneNumber = "To add"
    }
    */

    // Initialize a new Customer with a generated ID
    init( name: String, phoneNumber: String, addedAt: Date, businessName: String, email: String, address: String) {
         self.id =  UUID().hashValue
         self.name = name
         self.phoneNumber = phoneNumber
         self.addedAt = addedAt
         self.businessName = businessName
         self.email = email
         self.address = address
     }
}
