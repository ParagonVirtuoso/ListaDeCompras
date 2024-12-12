import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ShoppingListsView(modelContext: modelContext)
            .overlay(alignment: .topTrailing) {
                ThemeSwitcher(isDarkMode: $isDarkMode)
                    .padding(.top, 38)
                    .padding(.trailing, 16)
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ShoppingList.self, inMemory: true)
} 