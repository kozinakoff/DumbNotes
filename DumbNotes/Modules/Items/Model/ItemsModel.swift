//
//  ItemsModel.swift
//  DumbNotes
//
//  Created by ANDREY VORONTSOV on 11.05.2020.
//  Copyright © 2020 ANDREY VORONTSOV. All rights reserved.
//

import RealmSwift

class ItemsModel {
    
    weak var controller: ItemsModelOutput?
    
    private var items: [Item]?
    private var realm = try! Realm()
    
    private var filteredItems = [Item]()
}

// MARK: - Controller Input
extension ItemsModel: ItemsControllerInput {
    
    func retrieveItems() {
        self.items = realm.objects(Item.self).map { $0 }
        controller?.onItemsRetrieval(self.items ?? [])
    }
    
    func searchItems(query: String) {
        if let items = items, !query.isEmpty {
            filteredItems = items.filter { (item: Item) -> Bool in
                return item.title.lowercased().contains(query.lowercased() )
            }
            controller?.onItemsRetrieval(filteredItems)
        }
    }
    
    func addItem(title: String) {
        let item = Item(title: title)
        do {
            try self.realm.write {
                self.realm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
        controller?.onItemAddition(item: item)
    }
    
    func deleteItem(at index: Int) {
        if let items = items {
            do {
                try self.realm.write {
                    self.realm.delete(items[index])
                }
            } catch {
                print("Couldn't delete")
            }
            controller?.onItemDeletion(index: index)
        }
    }
    
    func retrieveItemUUID(for index: Int, _ isFiltering: Bool) {
        let itemUUID = isFiltering ? self.filteredItems[index].id : self.items![index].id
        controller?.onUUIDRetrieval(uuid: itemUUID)
    }
    
}
