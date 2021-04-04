//
//  TableViewController.swift
//  Project4
//
//  Created by Logan Melton on 21/3/13.
//

import UIKit

class TableViewController: UITableViewController {
  
  var webSites = ["apple.com", "hackingwithswift.com", "minecraft.net"]

    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Allowed Sites"

    }

    // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return webSites.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
    cell.textLabel?.text = webSites[indexPath.row]
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "Websites") as? ViewController {
      navigationController?.pushViewController(vc, animated: true)
    }
  }

    


}
