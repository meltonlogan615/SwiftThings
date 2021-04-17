//
//  ViewController.swift
//  Project25
//
//  Created by Logan Melton on 21/4/16.
//
import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
  
  var images = [UIImage]()
  // gets the name of the current device and assigns to peerID
  var peerID = MCPeerID(displayName: UIDevice.current.name)
  var mcSession: MCSession?
  var mcAdvertiserAssistant: MCAdvertiserAssistant?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    title = "Image Share"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
    
    // peerID is OK to force unwrap if peerID is listed as an optional property, but is good to go if is a computed property
    mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
    mcSession?.delegate = self
  }
  
  func startHosting(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "lgn-project25", discoveryInfo: nil, session: mcSession)
    mcAdvertiserAssistant?.start()
  }
  
  func joinSession(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    let mcBrowser = MCBrowserViewController(serviceType: "lgn-project25", session: mcSession)
    mcBrowser.delegate = self
    present(mcBrowser, animated: true)
  }
  
  // number of cells in collection view
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  // generates data for cells
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
    if let imageView = cell.viewWithTag(1000) as? UIImageView {
      imageView.image = images[indexPath.item]
    }
    return cell
  }
  
  
  // called when camera button is pressed
  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  @objc func showConnectionPrompt() {
    let ac = UIAlertController(title: "Connect", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Host", style: .default, handler: startHosting))
    ac.addAction(UIAlertAction(title: "Join", style: .default, handler: joinSession))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }
  
  // display images
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    dismiss(animated: true)
    images.insert(image, at: 0)
    collectionView.reloadData()
    
    
    guard let mcSession = mcSession else { return }
    
    if mcSession.connectedPeers.count > 0 {
      if let imageData = image.pngData() {
        do {
          try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
        } catch {
          let ac = UIAlertController(title: "Send Error", message: error.localizedDescription, preferredStyle: .alert)
          ac.addAction(UIAlertAction(title: "OK", style: .default))
          present(ac, animated: true)
        }
      }
    }
  }
  
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    // leave empty, has to be here to conform to MCSessionDelegate
  }
  
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    // leave empty, has to be here to conform to MCSessionDelegate
  }
  
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    // leave empty, has to be here to conform to MCSessionDelegate
  }
  
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true)
  }
  
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true)
  }
  
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch state {
      case .connected:
        print("Connected: \(peerID.displayName)")
      case .connecting:
        print("Connecting: \(peerID.displayName)")
      case .notConnected:
        print("Not Connected: \(peerID.displayName)")
      @unknown default:
        print("Unknown State Received: \(peerID.displayName)")
    }
  }
  
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    DispatchQueue.main.async {
      [weak self] in
      if let image = UIImage(data: data) {
        self?.images.insert(image, at: 0)
        self?.collectionView.reloadData()
      }
    }
  }

}

