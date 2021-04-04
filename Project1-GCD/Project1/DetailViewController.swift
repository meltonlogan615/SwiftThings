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
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationItem.largeTitleDisplayMode = .never
      
      
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

}
