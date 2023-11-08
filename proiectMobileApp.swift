
import SwiftUI
import SwiftData

@main
struct proiectMobileApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Customer.self,
            Warehouse.self,
            Invoice.self,
     
          
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LoginView();
           
        }
        .modelContainer(sharedModelContainer)
    }
}
