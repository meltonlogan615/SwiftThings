//
//  LoginViewController.swift
//  Kiley Stinks
//
//  Created by Logan Melton on 2/24/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
  
  @IBOutlet weak var loginEmailInput: UITextField!
  @IBOutlet weak var loginPasswordInput: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = K.appName
    loginButton.layer.cornerRadius = loginButton.frame.size
      .height / 5
    // Do any additional setup after loading the view.
  }
  
  @IBAction func loginButtonPressed(_ sender: UIButton) {
    if let email = loginEmailInput.text, let password = loginPasswordInput.text {
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let errorReceived = error {
          print(errorReceived)
        } else {
          self.performSegue(withIdentifier: K.loginSegue, sender: self)
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
