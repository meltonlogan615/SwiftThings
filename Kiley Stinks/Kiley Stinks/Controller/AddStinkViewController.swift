//
//  AddStinkViewController.swift
//  Kiley Stinks
//
//  Created by Logan Melton on 2/28/21.
//

import UIKit

class AddStinkViewController: UIViewController {
  @IBOutlet weak var addStinkLabel: UILabel!
  
  @IBOutlet weak var nameInput: UITextField!
  @IBOutlet weak var detailInput: UITextField!
  @IBOutlet weak var noteInput: UITextField!
  @IBOutlet weak var addStinkButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      addStinkButton.layer.cornerRadius = addStinkButton.frame.size.height / 5
        // Do any additional setup after loading the view.
    }
    
// Adds inputted info to FB-DB then dismisses window
  @IBAction func addStinkButtonPressed(_ sender: UIButton) {
    
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
