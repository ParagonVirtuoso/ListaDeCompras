import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ShoppingListsView(modelContext: modelContext)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ShoppingList.self, inMemory: true)
} 