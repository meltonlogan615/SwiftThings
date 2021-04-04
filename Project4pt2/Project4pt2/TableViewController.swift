//
//  TableViewController.swift
//  Project4pt2
//
//  Created by Logan Melton on 21/3/13.
//

import UIKit

class TableViewController: UITableViewController {
  
  var webSites = ["apple.com", "minecraft.net", "huffpost.com"]

    override func viewDidLoad() {
        super.viewDidLoad()


    }

  // Generates number of rows based on the items in the webSites array
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return webSites.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Websites", for: indexPath)
    cell.textLabel?.text = webSites[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "WebView") as? WebViewController {
      vc.selectedWebsite = webSites[indexPath.row]
      navigationController?.pushViewController(vc, animated: true)
    }
  }

}
