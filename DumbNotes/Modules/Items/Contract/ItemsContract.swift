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
}

protocol ItemsControllerInput: class {
    var controller: ItemsModelOutput? { get set }
    
    func retrieveItems()
    func addItem(title: String)
    func deleteItem(at index: Int)
    func retrieveItemUUID(for index: Int)
}

protocol ItemsModelOutput: class {
    func onItemsRetrieval(_ items: Results<Item>)
    func onItemAddition(item: Item)
    func onItemDeletion(index: Int)
    func onUUIDRetrieval(uuid: String)
}

protocol ItemsControllerOutput: class {
    var controller: ItemsViewInput? { get set }
    
    func onItemsRetrieval(titles: [String])
    func onItemAddition(title: String)
    func onItemDeletion(index: Int)
}
