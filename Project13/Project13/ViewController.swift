//
//  ViewController.swift
//  Project13
//
//  Created by Logan Melton on 21/3/28.
//
import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var intensitySlider: UISlider!
  @IBOutlet var filterLabel: UIButton!
  var currentImage: UIImage!
  
  var context: CIContext!
  var currentFilter: CIFilter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    title = "Filter"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    
    context = CIContext()
    currentFilter = CIFilter(name: "CISepiaTone")
  }

  @IBAction func changeFilter(_ sender: UIButton) {
    let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    // on iPad, positions AlertController tagged to button location
    if let popOverController = ac.popoverPresentationController {
      popOverController.sourceView = sender
      popOverController.sourceRect = sender.bounds
    }
    present(ac, animated: true)
    
  }
  
  @IBAction func save(_ sender: Any) {
    if let image = imageView.image {
      UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    } else {
      let ac = UIAlertController(title: "No Image to Save", message: "Can't save what you ain't got.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default)) // challenge 1, show error if no picture is selected to save
      present(ac, animated: true)
    }
    
  }
  
  @IBAction func intensityChanged(_ sender: Any) {
    applyProcessing()
  }
  
  //
  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    // picker.delegate = self requires UIImagePickerDelegate & UINavigationControllerDelegate
    present(picker, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    dismiss(animated: true)
    currentImage = image
    
    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) {
      currentFilter.setValue(intensitySlider.value, forKey: kCIInputIntensityKey)
      filterLabel.setTitle(currentFilter.name, for: .normal) // challenge 2, set filterLabel to name of filter
    }
    if inputKeys.contains(kCIInputRadiusKey) {
      currentFilter.setValue(intensitySlider.value * 200, forKey: kCIInputRadiusKey)
      filterLabel.setTitle(currentFilter.name, for: .normal)
    }
    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.setValue(intensitySlider.value * 10, forKey: kCIInputScaleKey)
      filterLabel.setTitle(currentFilter.name, for: .normal)
    }
    if inputKeys.contains(kCIInputCenterKey) {
      currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
      filterLabel.setTitle(currentFilter.name, for: .normal)
    }

    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      let processedImage = UIImage(cgImage: cgImage)
      imageView.image = processedImage
    }
  }
  
  func setFilter(action: UIAlertAction) {
    guard currentImage != nil else { return }
    guard let actionTitle = action.title else { return }
    
    currentFilter = CIFilter(name: actionTitle)
    
    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      let ac = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
    } else {
      let ac = UIAlertController(title: "Saved", message: "Altered Imaged Save to Photo Library", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
  }
  
}

// CoreImage -> CoreGraphic -> UIImage
