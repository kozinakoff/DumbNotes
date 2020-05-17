//
//  ItemsViewController.swift
//  DumbNotes
//
//  Created by ANDREY VORONTSOV on 11.05.2020.
//  Copyright © 2020 ANDREY VORONTSOV. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = itemsView as? UIView
        
        searchController.searchResultsUpdater = itemsView as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Notes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Properties
    var itemsView: ItemsControllerOutput?
    var itemsModel: ItemsControllerInput?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
}

// MARK: - View Input
extension ItemsViewController: ItemsViewInput {
    func onViewLayout() {
        itemsModel?.retrieveItems()
    }
    
    func onAddTap(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func onSaveTap(title: String) {
        itemsModel?.addItem(title: title)
    }
    
    func onDeleteSelection(index: Int) {
        itemsModel?.deleteItem(at: index)
    }
    
    func onCellSelection(index: Int) {
        itemsModel?.retrieveItemUUID(for: index, isFiltering)
    }
    
    func onSearchItems(query: String) {
        itemsModel?.searchItems(query: query)
    }
}

// MARK: - Model Output
extension ItemsViewController: ItemsModelOutput {
    func onItemsRetrieval(_ items: [Item]) {
        let notes = items.compactMap { $0.title }
        itemsView?.onItemsRetrieval(titles: notes)
    }
    
    func onItemAddition(item: Item) {
        itemsView?.onItemAddition(title: item.title)
    }

    func onItemDeletion(index: Int) {
        itemsView?.onItemDeletion(index: index)
    }
    
    func onUUIDRetrieval(uuid: String) {
        let controller = ItemDetailController()
        let view = ItemDetailView()
        let model = ItemDetailModel()
        
        controller.itemDetailView = view
        controller.itemDetailView?.controller = controller
        controller.itemDetailModel = model
        controller.itemDetailModel?.controller = controller
        
        model.itemUUID = uuid
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
