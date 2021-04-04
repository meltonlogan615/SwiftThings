//
//  Capital.swift
//  Project16
//
//  Created by Logan Melton on 21/3/31.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  var info: String
  
  init(title: String?, coordinate: CLLocationCoordinate2D, info: String) {
    self.title = title
    self.coordinate = coordinate
    self.info = info
  }
}
