//
//  ViewController.swift
//  Project12-Testing-UserDefaults
//
//  Created by Logan Melton on 21/3/26.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let defaults = UserDefaults.standard
    
    
    defaults.set(25, forKey: "Age")
    defaults.set(true, forKey: "UseFaceID")
    defaults.set(CGFloat.pi, forKey: "Pi")
    defaults.set("Logan", forKey: "Name")
    defaults.set(Date(), forKey: "LastRun")
    
    let array = ["Hello", "Stinky"]
    defaults.set(array, forKey: "SavedArray")
    
    let dict = ["Name": "Logan", "Country": "None"]
    defaults.set(dict, forKey: "SavedDict")
    
    let savedInt = defaults.integer(forKey: "Age")
    let savedBool = defaults.bool(forKey: "UseFaceID")
    
    let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
    
    let savedDict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
    
   
  }


}

