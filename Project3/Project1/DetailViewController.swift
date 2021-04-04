//
//  DetailViewController.swift
//  Project1
//
//  Created by Logan Melton on 3/9/21.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet var imageView: UIImageView!
  
  var selectedImage: String?
  var picCount: Int?
  var totalPics: Int?
  var sharedItems = [Data]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // NavigationItems
      navigationItem.largeTitleDisplayMode = .never
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
      
      // loading images
      if let imageToLoad = selectedImage, let picX = picCount, let picY = totalPics {
        imageView.image = UIImage(named: imageToLoad)
        title = "Pic \(picX) of \(picY)"
      }
      
        // Do any additional setup after loading the view.
    }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }

  @objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
    else {
      print("No image")
      return
    }
    sharedItems.append(image)
    let vc = UIActivityViewController(activityItems: sharedItems, applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
    present(vc, animated: true)
  }

}
