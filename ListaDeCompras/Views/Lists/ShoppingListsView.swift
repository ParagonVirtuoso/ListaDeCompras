import SwiftUI
import SwiftData

struct ShoppingListsView: View {
    @StateObject private var viewModel: ShoppingListViewModel
    @State private var showingNewListSheet = false
    @State private var newListName = ""
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: ShoppingListViewModel(modelContext: modelContext))
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
                }
                .onDelete(perform: deleteLists)
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
                    newListName = ""
                }
                .disabled(newListName.isEmpty)
            )
        }
    }
    
    private func deleteLists(at offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteList(viewModel.lists[index])
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ShoppingList.self, configurations: config)
    
    return ShoppingListsView(modelContext: container.mainContext)
} 