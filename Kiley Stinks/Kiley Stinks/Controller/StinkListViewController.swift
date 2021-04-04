//
//  StinkListViewController.swift
//  Kiley Stinks
//
//  Created by Logan Melton on 2/28/21.
//

import UIKit
import Firebase

class StinkListViewController: UIViewController {
  
  let db = Firestore.firestore()
  
  @IBOutlet var tableView: UITableView!
  
  var stinkList: [StankModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      title = K.appName
      navigationItem.hidesBackButton = true
      tableView.register(UINib(nibName: "StinkyTableViewCell", bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
      loadStink()
    }
    
  func loadStink() {
    db.collection(K.FStore.collectionName)
      .order(by: K.FStore.dateField).addSnapshotListener {
        (QuerySnapshot, error) in
        self.stinkList = []
        if let e = error {
          print("Problem \(e)")
        } else {
          if let snapshotDocs = QuerySnapshot?.documents {
            for doc in snapshotDocs {
              let data = doc.data()
              if let name = data[K.FStore.nameField] as? String, let details = data[K.FStore.detailField] as? String {
                let newStink = StankModel(name: name, description: details)
                self.stinkList.append(newStink)
                
                DispatchQueue.main.async {
                  self.tableView.reloadData()
                  let indexPath = IndexPath(row: self.stinkList.count - 1, section: 0)
                  self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
              }
            }
          }
        }
      }
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
