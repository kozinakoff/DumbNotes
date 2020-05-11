//
//  ItemDetailContract.swift
//  DumbNotes
//
//  Created by ANDREY VORONTSOV on 11.05.2020.
//  Copyright © 2020 ANDREY VORONTSOV. All rights reserved.
//

import UIKit
import RealmSwift

protocol ItemDetailViewInput: class {
    
    var itemDetailView: ItemDetailControllerOutput? { get set }
    var itemDetailModel: ItemDetailControllerInput? { get set }
    
    func onViewLayout()
}

protocol ItemDetailControllerInput: class {
    
    var controller: ItemDetailModelOutput? { get set }
    
    func retrieveItem()
}

protocol ItemDetailModelOutput: class {
    func onItemRetrieval(item: Item)
}

protocol ItemDetailControllerOutput: class {
    
    var controller: ItemDetailViewInput? { get set }
    
    func onItemRetrieval(title: String)
}
