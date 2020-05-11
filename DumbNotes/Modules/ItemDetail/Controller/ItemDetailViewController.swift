//
//  ItemDetailViewController.swift
//  DumbNotes
//
//  Created by ANDREY VORONTSOV on 11.05.2020.
//  Copyright © 2020 ANDREY VORONTSOV. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = itemDetailView as? UIView
    }
    
    // MARK: - Properties
    var itemDetailView: ItemDetailControllerOutput?
    var itemDetailModel: ItemDetailControllerInput?
}

// MARK: - View Input
extension ItemDetailController: ItemDetailViewInput {
    func onViewLayout() {
        print("View tells Controller it has been setup")
        itemDetailModel?.retrieveItem()
    }
}

// MARK: - Model Output
extension ItemDetailController: ItemDetailModelOutput {
    func onItemRetrieval(item: Item) {
        print("Controller gets the result from Model, then forwards it in a displayable format to the View")
        itemDetailView?.onItemRetrieval(title: item.title)
    }
}
