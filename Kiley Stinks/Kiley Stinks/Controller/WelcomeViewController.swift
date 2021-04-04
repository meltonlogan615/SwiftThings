//
//  ViewController.swift
//  Kiley Stinks
//
//  Created by Logan Melton on 2/24/21.
//

import UIKit
import Firebase
import FirebaseAuth

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.isNavigationBarHidden = false
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleLabel.text = ""
    registerButton.layer.cornerRadius = registerButton.frame.size.height / 5
    loginButton.layer.cornerRadius = loginButton.frame.size.height / 5
    var charIndex = 0.0
    let titleText = "Kiley Stinks"
    for letter in titleText {
      Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
        self.titleLabel.text?.append(letter)
      }
      charIndex += 1
      
    }
  }


}

