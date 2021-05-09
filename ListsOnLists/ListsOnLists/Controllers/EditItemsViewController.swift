//
//  EditItemsViewController.swift
//  ListsOnLists
//
//  Created by Logan Melton on 21/4/17.
//

import UIKit

class EditItemsViewController: UIViewController {
  
  var editingItem = ""
  var editedIndex = 0
  
  @IBOutlet var editingItemTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = editingItem.uppercased()
    editingItemTextField.text = editingItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))

  }
 
  //MARK: - Selectors
  @objc func save() {
    let saveAlert = UIAlertController(title: "Save Changes?", message: nil, preferredStyle: .alert)
    let saveChanges = UIAlertAction(title: "Save", style: .default) { [self] _ in
      let allAC = self.storyboard?.instantiateViewController(identifier: "AllItems") as! AllItemsViewController
      guard let editedItem = editingItemTextField.text else { return }
      allAC.items.append(editedItem)
      self.dismiss(animated: true, completion: allAC.tableView.reloadData)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    saveAlert.addAction(saveChanges)
    saveAlert.addAction(cancel)
    
    present(saveAlert, animated: true, completion: nil)
  }
  
  @objc func cancel() {
    dismiss(animated: true, completion: nil)
  }
  
}
