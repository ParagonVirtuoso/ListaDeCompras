import XCTest
import SwiftData
@testable import ListaDeCompras

final class ListaDeComprasTests: XCTestCase {
    var modelContainer: ModelContainer!
    
    override func setUpWithError() throws {
        let schema = Schema([
            ShoppingList.self,
            ShoppingItem.self,
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
    }
    
    override func tearDownWithError() throws {
        modelContainer = nil
    }
    
    func testCreateShoppingList() throws {
        let context = modelContainer.mainContext
        let list = ShoppingList(name: "Test List")
        
        context.insert(list)
        
        XCTAssertNotNil(list.id)
        XCTAssertEqual(list.name, "Test List")
        XCTAssertTrue(list.items.isEmpty)
    }
    
    func testAddItemToList() throws {
        let context = modelContainer.mainContext
        let list = ShoppingList(name: "Test List")
        let item = ShoppingItem(name: "Test Item")
        
        context.insert(list)
        list.items.append(item)
        
        XCTAssertEqual(list.items.count, 1)
        XCTAssertEqual(list.items.first?.name, "Test Item")
    }
}
