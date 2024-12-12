import SwiftUI
import SwiftData

@main
struct ListaDeComprasApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ShoppingList.self,
            ShoppingItem.self,
            Category.self
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
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .overlay(alignment: .topTrailing) {
                    ThemeSwitcher(isDarkMode: $isDarkMode)
                        .padding(.top,38)
                        .padding(.trailing, 16)
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
