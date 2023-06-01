import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Environment(\.presentationMode) var presentationMode
    
    @Published var textFieldText: String = ""
    @Published var alertTitle: String = ""
    @Published var showAlert: Bool = false
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        loadItems()
    }
    
    func saveButtonPressed() {
        if !textFieldText.isEmpty {
            addItem(title: textFieldText)
            textFieldText = ""
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: itemsKey)
        } catch {
            print("Failed to encode items: \(error)")
        }
    }
    
    func loadItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey) {
            do {
                items = try JSONDecoder().decode([ItemModel].self, from: data)
            } catch {
                print("Failed to decode items: \(error)")
            }
        }
    }
}
