//
//  ActionViewController.swift
//  Extension
//
//  Created by Logan Melton on 21/4/2.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
  @IBOutlet var scriptTextView: UITextView!
  
  var pageTitle = ""
  var pageURL = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
      
      // adjusting visible size of scriptTextView to not allow it to go beneath the keyboard
      let notificationCenter = NotificationCenter.default
      notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
      notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    
      if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
        if let itemProvider = inputItem.attachments?.first {
          itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) {
            // Closure Coming, runs async
            [weak self] (dict, error) in
            // NSDictionary used when don't know key / value types
            guard let itemDictionary = dict as? NSDictionary else { return }
            guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
            // print(javaScriptValues)
            self?.pageTitle = javaScriptValues["title"] as? String ?? ""
            self?.pageURL = javaScriptValues["URL"] as? String ?? ""
            
            // Closure 2 - Sends back to update the UI
            // Uses same capture list so [weak self] is not required
            DispatchQueue.main.async {
              self?.title = self?.pageTitle
            }
          }
        }
      }
    }

    @IBAction func done() {
      let item = NSExtensionItem()
      let argument: NSDictionary = ["customJavaScript": scriptTextView.text ?? ""]
      let webDict: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
      let customJS = NSItemProvider(item: webDict, typeIdentifier: kUTTypePropertyList as String)
      item.attachments = [customJS]
      extensionContext?.completeRequest(returningItems: [item])
    }
  
  // adjusting visible size of scriptTextView to not allow it to go beneath the keyboard
  @objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    if notification.name == UIResponder.keyboardWillHideNotification {
      scriptTextView.contentInset = .zero
    } else {
      scriptTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }
    scriptTextView.scrollIndicatorInsets = scriptTextView.contentInset
    
    let selectedRange = scriptTextView.selectedRange
    scriptTextView.scrollRangeToVisible(selectedRange)
  }

}
