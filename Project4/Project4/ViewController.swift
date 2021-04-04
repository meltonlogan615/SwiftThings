//
//  ViewController.swift
//  Project4
//
//  Created by Logan Melton on 3/11/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  
  // create variable webView that is of data type WebKit (WK) WebView
  var webView: WKWebView!
  
  var progressView: UIProgressView!
  
  var webSites = ["apple.com", "hackingwithswift.com", "minecraft.net"]
  
  // called before viewDidLoad
  override func loadView() {
    // initializes the webView
    webView = WKWebView()
    // sets the webView navigationDelegate as itself
    webView.navigationDelegate = self
    // sets the viewController (view), as the webView
    view = webView
  }
  
  //MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    // creates a custom bar button item "Open", when tapped, calls the function openTapped()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    
    //MARK: - defining toolBarItems
    // new UIBarButtonItem for empty space
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    // new UIBarButtonItem to refresh the page
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    // new UIBarButtonItem to go back to previous page
    let goBack = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
    // new UIBarButtonItem to return to back to page after tapping back
    let goForward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
    
    //MARK: - defining progressView
    progressView = UIProgressView(progressViewStyle: .default)
    // sets bounds to fill available space
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    // array holding spacer and refresh, will be displayed as a in bottom tool bar
    toolbarItems = [goBack, goForward, progressButton, spacer, refresh]
    // makes toolbar visible
    navigationController?.isToolbarHidden = false
    // setting Key Value Observer - #keyPath checks to sure correct functionality
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    // stores url in a string -> force unwrapped since hard coded
    let url = URL(string:"https://" + webSites[0])!
    // wraps url in URLRequest
    webView.load(URLRequest(url: url))
    // enables swipes to navigate
    webView.allowsBackForwardNavigationGestures = true
  }
  
  //MARK: - openTapped function
  // function to run when Open bar button is tapped
  @objc func openTapped() {
    // defines the UIAlertController - Title = what is displayed, preferred style is how information is displayed. Message = nil
    let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    // uses the addAction subscript, title = what is displayed on the button, style = how it's displayed, handler is the function called when tapped
    for website in webSites {
      ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    }
    // style cancel
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    // anchors to action location on iPad
    ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }
  
  //MARK: - openPage function
  // function to open selected website. Parameter passed is the UIAlertAction listed in the openTapped
  func openPage(action: UIAlertAction) {
    // optional unwrapping of action.title to actionTitle
    guard let actionTitle = action.title else { return }
    // optional unwrapping of completed url to constant url
    guard let url = URL(string: "https://" + actionTitle) else { return }
    // loads the webView with the unwrapped & completed url
    webView.load(URLRequest(url: url))
  }
  
  //MARK: - Add Title to NavigationBar
  // called when webView finishes loading
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    // adds the website url to the navigationBar title
    title = webView.title
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
    let url = navigationAction.request.url
    
    // host = domain
    if let host = url?.host {
      // loops through allowed
      for website in webSites {
        // if host url contains what is in the webSites array, allows access
        if host.contains(website) {
          decisionHandler(.allow)
          return
        }
      }
    }
    // disallows loading
    
    
    // required for code competition
    decisionHandler(.cancel)
  }


}
