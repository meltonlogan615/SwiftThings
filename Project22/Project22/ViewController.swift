//
//  ViewController.swift
//  Project22
//
//  Created by Logan Melton on 21/4/8.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate{

  @IBOutlet var locationLabel: UILabel!
  var locationManager: CLLocationManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization() // requests location data, will ask user again in a few days to verify
    // locationManager?.requestWhenInUseAuthorization() <- use when app only uses location when app is active
    
    view.backgroundColor = .gray
  }
  
  // depreciated method in iOS14
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
        if CLLocationManager.isRangingAvailable() {
          startScanning()
        }
      }
    }
  }
  
  func startScanning() {
    let uuid = UUID(uuidString: "5a4BCECE-174E-4BAC-A814-092E77F6B7E5")! // default test uuid
    let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeaon")
    
    locationManager?.startMonitoring(for: beaconRegion)
    // locationManager?.startRangingBeacons(in: beaconRegion) // depreciated method in iOS13
    // locationManager?.startRangingBeacons(satisfying: <#T##CLBeaconIdentityConstraint#>)
  }
  
  func update(distance: CLProximity) {
    UIView.animate(withDuration: 1) {
      switch distance {
        case .far:
          self.view.backgroundColor = .blue
          self.locationLabel.text = "FAR"
        case .near:
          self.view.backgroundColor = .orange
          self.locationLabel.text = "NEAR"
        case .immediate:
          self.view.backgroundColor = .red
          self.locationLabel.text = "RIGHT HERE"
        default:
          self.view.backgroundColor = .gray
          self.locationLabel.text = "UNKNOWN"
      }
    }
  }
  
  // depreciated method
  func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if let beacon = beacons.first {
      update(distance: beacon.proximity)
    } else {
      update(distance: .unknown)
    }
  }
  
}

// Major number is a UUID String
// Minor number subdivides Major into smaller categories
