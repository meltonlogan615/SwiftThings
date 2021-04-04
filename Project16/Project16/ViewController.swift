//
//  ViewController.swift
//  Project16
//
//  Created by Logan Melton on 21/3/31.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

  @IBOutlet var mapView: MKMapView!
  
  override func viewWillAppear(_ animated: Bool) {
    let ac = UIAlertController(title: "Map?", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Regular", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>))
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Rains a whole lot.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over 1000yrs ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Head choppers.")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Julius got killed here.")
    let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Criminals want to be here.")
    
    // to add a single annotation use .addAnnotation(_:) with individual parameters
    mapView.addAnnotations([london, oslo, paris, rome, washington])

  }
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is Capital else {
      return nil
    }
    let identifier = "Capital"
    
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
      let button = UIButton(type: .detailDisclosure)
      annotationView?.rightCalloutAccessoryView = button
    } else {
      annotationView?.annotation = annotation
    }
    return annotationView as? MKPinAnnotationView
  
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as?  Capital else { return }
    let placeName = capital.title
    let placeInfo = capital.info
    
    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  @objc func mapChosen() {
    
  }
}

