import SwiftUI
import SwiftData
import Combine

@MainActor
class ShoppingListViewModel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    @Published var errorMessage: String?
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchLists()
    }
    
    private func fetchLists() {
        let descriptor = FetchDescriptor<ShoppingList>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        
        do {
            lists = try modelContext.fetch(descriptor)
        } catch {
            errorMessage = "Erro ao carregar listas: \(error.localizedDescription)"
        }
    }
    
    func createList(name: String) {
        let newList = ShoppingList(name: name)
        modelContext.insert(newList)
        
        do {
            try modelContext.save()
            fetchLists()
        } catch {
            errorMessage = "Erro ao salvar lista: \(error.localizedDescription)"
        }
    }
    
    func deleteList(_ list: ShoppingList) {
        modelContext.delete(list)
        
        do {
            try modelContext.save()
            fetchLists()
        } catch {
            errorMessage = "Erro ao deletar lista: \(error.localizedDescription)"
        }
    }
} 