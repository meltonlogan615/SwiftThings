//
//  ViewController.swift
//  Project7
//
//  Created by Logan Melton on 21/3/16.
//

import UIKit

class TableViewController: UITableViewController {
  
  var petitions = [Petition]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    performSelector(inBackground: #selector(fetchJSON), with: nil)
  }
  
  @objc func fetchJSON() {
    performSelector(onMainThread: #selector(chooseTab), with: nil, waitUntilDone: false)
    
    // Grand Central Dispatch (GCD)
    // never ok to do UI work on a background thread
    // User Interactive
    // Default
    // User Initiated
    // Utility
    // Background
   
  }
  
  @objc func showError() {
      let ac = UIAlertController(title: "Loading Error", message: "We gots priblems", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
  
  @objc func chooseTab() {
    // points to data source
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
      urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }
    if let url = URL(string: urlString) {
      // converts to data instance
      if let data = try? Data(contentsOf: url) {
        parseJson(json: data)
        return
      }
    }
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
  }
  func parseJson(json: Data) {
    let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    } else {
      performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = petitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
  
}

