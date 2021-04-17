//
//  ViewController.swift
//  ListsOnLists
//
//  Created by Logan Melton on 21/4/17.
//

import UIKit

class AllItemsViewController: UITableViewController {
  
  var items = [String]()
  var newItem: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "All Items"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    cell.textLabel?.text = "\(items[indexPath.row])"
    return cell
  }
  
  //TODO: shows ItemEditViewController
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("\(items[indexPath.row])")
  }
  
  //TODO: build action function to present modal for adding elements to items array
  @objc func addItem() {
    print("Add Item")
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
    // addItemAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: addRow))
    addItemAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(addItemAlert, animated: true)
    
  }
//  func addRow(action: UIAlertAction) {
//    items.append(items.count)
//    tableView.reloadData()
//  }

}

