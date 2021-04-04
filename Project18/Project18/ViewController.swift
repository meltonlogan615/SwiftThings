//
//  ViewController.swift
//  Project18
//
//  Created by Logan Melton on 21/4/2.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Using print to Debug
    // Print statements remain in the Bundle when sent to the AppStore
    print("viewDidLoad") // generic print statement
    print(1, 2, 3, 4, 5, separator: " - ") // inserts - between each parameter
    print(1, 2, 3, 4, 5, terminator: "!") // places ! at the end of parameters.
    print("")
    
    // Using Assertions - first parameter is the check, second is the message sent to the console.
    // Assertions are not included in the Bundle when sent to AppStore
    assert(1 == 1, "Math fail") // Condition returns true, is not executed
    //assert(1 == 2, "Math win") // Condition returns false, is executed and crashes app
    
    // Using Breakpoints - Bright Blue = Active, Dimmed Blue = Inactive, Right Click to delete
    // F6 steps forward line by line
    for i in 1...100 {
      print("Number \(i).")
    }
  }


}

