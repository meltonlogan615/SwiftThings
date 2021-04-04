//
//  ViewController.swift
//  Project4pt2
//
//  Created by Logan Melton on 21/3/13.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
  
  var webView: WKWebView!
  
  var selectedWebsite = String()
  var progressView: UIProgressView!
  
  // called before viewDidLoad
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let url = URL(string:"https://" + selectedWebsite) else { return }
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
    
    
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    
    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    toolbarItems = [progressButton, spacer, refresh]
    navigationController?.isToolbarHidden = false
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    
  }
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  


}

