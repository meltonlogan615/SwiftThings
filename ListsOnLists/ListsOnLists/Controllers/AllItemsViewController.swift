//
//  ViewController.swift
//  ListsOnLists
//
//  Created by Logan Melton on 21/4/17.
//

import UIKit

class AllItemsViewController: UITableViewController {
  
  var items = [String]()

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
  
  // delete with swipe right
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .destructive, title: "Delete") { [self]
      (action, view, completionHandler) in
      let itemToRemove = self.items[indexPath.row]
      guard let indexOfRemovedItem = items.firstIndex(of: itemToRemove) else { return }
      self.items.remove(at: indexOfRemovedItem)
      tableView.reloadData()
    }
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  // edit with swipe left
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: "Edit") { [weak self]
      (action, view, completionHandler) in
      guard let itemToEdit = self?.items[indexPath.row] else { return }
      print("\(itemToEdit)")
    }
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  //MARK: - Add Items to List
  @objc func addItem() {
    let addItemAlert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
    addItemAlert.addTextField()
    let newItem = UIAlertAction(title: "Add", style: .default) { [unowned addItemAlert, weak self] _ in
      let item = addItemAlert.textFields![0]
      guard let itemAdded = item.text else { return }
      if itemAdded == "" {
        return
      } else {
      self?.items.insert(itemAdded, at: 0)
      self?.tableView.reloadData()
      }
    }
    addItemAlert.addAction(newItem)
    addItemAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(addItemAlert, animated: true)
  }
  
  //MARK: - Editing and Removing Items in List
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let editRemoveItem = UIAlertController(title: "Edit or Delete Item", message: nil, preferredStyle: .alert)
    
    //TODO: shows EditItemsViewController
    // editing items in the list
    // editRemoveItem.addAction(UIAlertAction(title: "Edit", style: .default))
    let editItem = UIAlertAction(title: "Edit", style: .default) {
      [weak self] _ in
      let editVC = self?.storyboard?.instantiateViewController(identifier: "EditItem") as! EditItemsViewController
      editVC.modalPresentationStyle = .popover
      self?.present(editVC, animated: true)
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
    
    // cancel. do nothing.
    editRemoveItem.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    // show alert controller
    present(editRemoveItem, animated: true)
  }
    

}

