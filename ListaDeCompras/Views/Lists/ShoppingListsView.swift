import SwiftUI
import SwiftData

struct ShoppingListsView: View {
    @StateObject private var viewModel: ShoppingListViewModel
    @State private var showingNewListSheet = false
    @State private var newListName = ""
    @State private var listToDelete: ShoppingList? = nil
    @State private var showingDeleteAlert = false
    @EnvironmentObject private var toastVM: ToastViewModel
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: ShoppingListViewModel(modelContext: modelContext, toastVM: ToastViewModel()))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.lists) { list in
                    NavigationLink(destination: ShoppingListDetailView(list: list, modelContext: modelContext)) {
                        VStack(alignment: .leading) {
                            Text(list.name)
                                .font(.headline)
                                .foregroundColor(Constants.Colors.text)
                            Text("\(list.items.count) itens")
                                .font(.subheadline)
                                .foregroundColor(Constants.Colors.secondaryText)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            listToDelete = list
                            showingDeleteAlert = true
                        } label: {
                            Label("Deletar", systemImage: "trash")
                        }
                    }
                }
            }
            .alert("Confirmar exclusão", isPresented: $showingDeleteAlert) {
                Button("Cancelar", role: .cancel) {}
                Button("Deletar", role: .destructive) {
                    if let list = listToDelete {
                        viewModel.deleteList(list)
                        toastVM.showSuccess("Lista '\(list.name)' removida com sucesso!")
                    }
                }
            } message: {
                if let list = listToDelete {
                    Text("Tem certeza que deseja excluir a lista '\(list.name)'? Esta ação não pode ser desfeita.")
                }
            }
            .navigationTitle("Minhas Listas")
            .background(Constants.Colors.listBackground)
            .toolbar {
                Button(action: { showingNewListSheet = true }) {
                    Image(systemName: "plus")
                        .foregroundColor(Constants.Colors.primary)
                }
            }
            .sheet(isPresented: $showingNewListSheet) {
                newListForm
            }
        }
    }
    
    private var newListForm: some View {
        NavigationStack {
            Form {
                TextField("Nome da Lista", text: $newListName)
            }
            .navigationTitle("Nova Lista")
            .navigationBarItems(
                leading: Button("Cancelar") { showingNewListSheet = false },
                trailing: Button("Salvar") {
                    viewModel.createList(name: newListName)
                    showingNewListSheet = false
                    toastVM.showSuccess("Lista '\(newListName)' criada com sucesso!")
                    newListName = ""
                }
                .disabled(newListName.isEmpty)
            )
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ShoppingList.self, configurations: config)
    
    return ShoppingListsView(modelContext: container.mainContext)
} 