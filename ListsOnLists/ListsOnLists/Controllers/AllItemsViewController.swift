//
//  ViewController.swift
//  ListsOnLists
//
//  Created by Logan Melton on 21/4/17.
//

import UIKit

class AllItemsViewController: UITableViewController {
  
  var items = [String]()
  var selectedItem = String()
  var selectedIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "All Items"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
  }
  
  //MARK: - TableView Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    cell.textLabel?.text = "\(items[indexPath.row])"
    return cell
  }
  
  //MARK: - Editing and Removing Items in List
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedItem = items[indexPath.row]
    selectedIndex = indexPath.row
    let editRemoveItem = UIAlertController(title: "Edit or Delete Item", message: nil, preferredStyle: .alert)
    
    // editing items in the list
    let editItem = UIAlertAction(title: "Edit", style: .default) {
      [weak self] _ in
      let editVC = self?.storyboard?.instantiateViewController(identifier: "EditItem") as! EditItemsViewController
      editVC.editingItem = self?.selectedItem ?? ""
      editVC.editedIndex = self?.selectedIndex ?? 0
      editVC.modalPresentationStyle = .popover
      self?.present(UINavigationController(rootViewController: editVC), animated: true)
    }
    editRemoveItem.addAction(editItem)
    
    // removing items from the list - Completed!!!
    let removeItem = UIAlertAction(title: "Remove", style: .default) {
      [weak self] _ in
      let removingItemIndex = indexPath.row
      self?.items.remove(at: removingItemIndex)
      self?.tableView.reloadData()
    }
    editRemoveItem.addAction(removeItem)
    editRemoveItem.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(editRemoveItem, animated: true)
  }
  
  //MARK: - Swipe Actions on Items
  // delete with swipe from right to left
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let trailingSwipe = UIContextualAction(style: .destructive, title: "Delete") { [self]
      (trailingSwipe, view, completionHandler) in
      let itemToRemove = self.items[indexPath.row]
      guard let indexOfRemovedItem = items.firstIndex(of: itemToRemove) else { return }
      self.items.remove(at: indexOfRemovedItem)
      tableView.reloadData()
    }
    return UISwipeActionsConfiguration(actions: [trailingSwipe])
  }
  
  // edit with swipe from left to right
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let leadingSwipe = UIContextualAction(style: .normal, title: "Edit") { [weak self]
      (leadingSwipe, view, completionHandler) in
      guard let itemToEdit = self?.items[indexPath.row] else { return }
      print("\(itemToEdit)")
    }
    return UISwipeActionsConfiguration(actions: [leadingSwipe])
  }
  
  //MARK: - Selectors
  @objc func addItem() {
    let addItemAlert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
    addItemAlert.addTextField()
    let newItem = UIAlertAction(title: "Add", style: .default) { [unowned addItemAlert, weak self] _ in
      let item = addItemAlert.textFields![0]
      guard let itemAdded = item.text else { return }
      if itemAdded == "" {
        return
      } else {
      self?.items.append(itemAdded)
      self?.tableView.reloadData()
      }
    }
    addItemAlert.addAction(newItem)
    addItemAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(addItemAlert, animated: true)
  }
  

    

}

