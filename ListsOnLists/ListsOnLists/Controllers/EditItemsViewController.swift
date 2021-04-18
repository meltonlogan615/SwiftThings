//
//  EditItemsViewController.swift
//  ListsOnLists
//
//  Created by Logan Melton on 21/4/17.
//

import UIKit

class EditItemsViewController: UIViewController {
  
  let editingItem = "You Stink!!"
  @IBOutlet var itemLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    itemLabel.text = editingItem
    itemLabel.font = UIFont(name: "Chalkduster", size: 48)
    itemLabel.textColor = .cyan
  }
  
  
}
