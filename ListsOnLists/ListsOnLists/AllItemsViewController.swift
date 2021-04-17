//
//  ViewController.swift
//  ListsOnLists
//
//  Created by Logan Melton on 21/4/17.
//

import UIKit

class AllItemsViewController: UITableViewController {
  
  let items = ["Wu-Tang", "Soundgarden"]

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
  }
  

}

