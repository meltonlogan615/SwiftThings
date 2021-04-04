//
//  RegisterViewController.swift
//  Kiley Stinks
//
//  Created by Logan Melton on 2/24/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
  @IBOutlet weak var registerEmailInput: UITextField!
  @IBOutlet weak var registerPasswordInput: UITextField!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var errorMsgLabel: UILabel!
  @IBOutlet weak var errorMsgLAbel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false
    title = K.appName
    registerButton.layer.cornerRadius = registerButton.frame.size.height / 5
    // Do any additional setup after loading the view.
  }
  
  @IBAction func registerButtonPressed(_ sender: UIButton) {
    if let email = registerEmailInput.text, let password = registerPasswordInput.text {
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let errorReceived = error {
          self.errorMsgLAbel.text = errorReceived.localizedDescription
          print(errorReceived.localizedDescription)
        } else {
          // Nav to ChatVC
          self.performSegue(withIdentifier: K.registerSegue, sender: self)
        }
      }
    }
  }
}
