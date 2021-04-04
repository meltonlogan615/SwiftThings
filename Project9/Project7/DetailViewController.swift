//
//  DetailViewController.swift
//  Project7
//
//  Created by Logan Melton on 21/3/19.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  
  var webView: WKWebView!
  var detailItem: Petition?
  
  override func loadView() {
    super.loadView()
    webView = WKWebView()
    view = webView
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      guard let detailItem = detailItem else { return }
      let html = """
      <html>
      <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style> body { font-size: 150%; } .headline { font-size: 2rem; font-weight: bold; margin-bottom: 0.5rem; } </style>
      </head>
      <body>
      <div class="headline">\(detailItem.title)</div>
      \(detailItem.body)
      </body>
      </html>
      """
      self.title = "Signatures: \(detailItem.signatureCount)"
      webView.loadHTMLString(html, baseURL: nil)
    }
    



}
