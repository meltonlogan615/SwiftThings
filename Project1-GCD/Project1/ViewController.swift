//
//  ViewController.swift
//  Project1
//
//  Created by Logan Melton on 3/9/21.
//

import UIKit

class ViewController: UITableViewController {
  
  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    performSelector(inBackground: #selector(fetchPics), with: nil)
//    tableView.reloadData()
    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
  }
  
  @objc func fetchPics() {
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    for item in items {
      if item.hasPrefix("nssl") {
        // picture to load
        pictures.append(item)
      }
    }
    pictures = pictures.sorted()
//    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
  }

  // sets the number of rows to be created to the number of pictures
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  // adds data to the rows that are created in the numberOfRowsInSection, in this case the name of the images
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  // Pushes the selected row into the DetailViewController
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row]
      vc.totalPics = pictures.count
      vc.picCount = indexPath.row + 1
      navigationController?.pushViewController(vc, animated: true)
    }
  }

}

