//
//  ItemDetailModel.swift
//  DumbNotes
//
//  Created by ANDREY VORONTSOV on 11.05.2020.
//  Copyright © 2020 ANDREY VORONTSOV. All rights reserved.
//

import RealmSwift

class ItemDetailModel {
    
    weak var controller: ItemDetailModelOutput?
    
    var itemUUID: String?
    
    private var item: Item?
    private var realm = try! Realm()
}

// MARK: - Controller Input
extension ItemDetailModel: ItemDetailControllerInput {
    
    func retrieveItem() {
        print("Controller tells Model to retrieve an item")
        item = realm.objects(Item.self)
            .filter { $0.id == self.itemUUID }
            .first
        controller?.onItemRetrieval(item: item!)
    }

}
