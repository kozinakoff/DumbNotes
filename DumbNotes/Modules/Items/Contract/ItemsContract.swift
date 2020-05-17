//
//  ItemsContract.swift
//  DumbNotes
//
//  Created by ANDREY VORONTSOV on 11.05.2020.
//  Copyright © 2020 ANDREY VORONTSOV. All rights reserved.
//

import UIKit
import RealmSwift

protocol ItemsViewInput: class {
    var itemsView: ItemsControllerOutput? { get set }
    var itemsModel: ItemsControllerInput? { get set }
    
    func onViewLayout()
    func onAddTap(alert: UIAlertController)
    func onSaveTap(title: String)
    func onDeleteSelection(index: Int)
    func onCellSelection(index: Int)
    func onSearchItems(query: String)
}

protocol ItemsControllerInput: class {
    var controller: ItemsModelOutput? { get set }
    
    func retrieveItems()
    func searchItems(query: String)
    func addItem(title: String)
    func deleteItem(at index: Int)
    func retrieveItemUUID(for index: Int, _ isFiltering: Bool)
}

protocol ItemsModelOutput: class {
    func onItemsRetrieval(_ items: [Item])
    func onItemAddition(item: Item)
    func onItemDeletion(index: Int)
    func onUUIDRetrieval(uuid: String)
}

protocol ItemsControllerOutput: class {
    var controller: ItemsViewInput? { get set }
    
    func onItemsRetrieval(titles: [String])
    func onItemSearch(query: String)
    func onItemAddition(title: String)
    func onItemDeletion(index: Int)
}
