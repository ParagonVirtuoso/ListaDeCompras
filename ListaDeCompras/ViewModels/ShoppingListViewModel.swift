import SwiftUI
import SwiftData
import Combine

@MainActor
class ShoppingListViewModel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    @Published var errorMessage: String?
    
    private let modelContext: ModelContext
    @ObservedObject var toastVM: ToastViewModel
    
    init(modelContext: ModelContext, toastVM: ToastViewModel) {
        self.modelContext = modelContext
        self.toastVM = toastVM
        fetchLists()
    }
    
    private func fetchLists() {
        let descriptor = FetchDescriptor<ShoppingList>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        
        do {
            lists = try modelContext.fetch(descriptor)
        } catch {
            toastVM.showError("Erro ao carregar listas: \(error.localizedDescription)")
        }
    }
    
    func createList(name: String) {
        let newList = ShoppingList(name: name)
        modelContext.insert(newList)
        
        do {
            try modelContext.save()
            fetchLists()
            toastVM.showSuccess("Lista criada com sucesso!")
        } catch {
            toastVM.showError("Erro ao salvar lista: \(error.localizedDescription)")
        }
    }
    
    func deleteList(_ list: ShoppingList) {
        modelContext.delete(list)
        
        do {
            try modelContext.save()
            fetchLists()
            toastVM.showSuccess("Lista removida com sucesso!")
        } catch {
            toastVM.showError("Erro ao deletar lista: \(error.localizedDescription)")
        }
    }
} 