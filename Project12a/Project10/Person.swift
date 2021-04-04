//
//  Person.swift
//  Project10
//
//  Created by Logan Melton on 21/3/22.
//

import UIKit

class Person: NSObject, NSCoding {

  var name: String
  var image: String
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
  
  // writes to disc
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
  }
  
  // reads from disc
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
  }

}
