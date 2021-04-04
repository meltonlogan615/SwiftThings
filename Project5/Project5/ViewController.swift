//
//  ViewController.swift
//  Project5
//
//  Created by Logan Melton on 21/3/14.
//

import UIKit

class ViewController: UITableViewController {
  
  var allWords = [String]()
  var usedWords = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // right navigation item
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    
    // left navigation item
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
    
    // connecting the start.txt file to the viewController
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
      }
    }
    
    // safety check, will fill allWords array with a default single element
    if allWords.isEmpty {
      allWords = ["silkworm"]
    }
    
    startGame()
  }
  
  @objc func startGame() {
    title = allWords.randomElement() // adds title to navigation and sets as root word
    usedWords.removeAll(keepingCapacity: true) // clears tableView
    tableView.reloadData() // cause all table view methods to be called again
  }
  
  //MARK: - Table Rows
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
  }
  
  // function for the add button being tapped
  @objc func promptForAnswer() {
    // sets the properties of the alert
    let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
    // adds textField to the alert
    ac.addTextField()
    // adds the submit action button to the alert
    let submitAction = UIAlertAction(title: "Submit", style: .default) {
      [weak self, weak ac] action in
      guard let answer = ac?.textFields?[0].text else {return}
      self?.submit(answer)
    }
    
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  // checking if the word submitted fits within the allowed constraints
  func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()
    
    let errorTitle: String
    let errorMsg: String
    
    if isPossible(word: lowerAnswer) {
      if isOriginal(word: lowerAnswer) {
          if isReal(word: lowerAnswer) {
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            return
          } else {
            errorTitle = "Word not recognized"
            errorMsg = "Please try again"
          }
      } else {
        errorTitle = "Word already used"
        errorMsg = "Please try again"
      }
    } else {
      guard let title = title else { return }
      errorTitle = "Word not possible"
      errorMsg = "You can't spell that word from \(title.lowercased())"
    }
    
    let ac = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  // checks that submitted letters are in the main word
  func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }
    for letter in word {
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else {
        return false
      }
    }
    return true
  }
  
  // checks that submitted word has not already been used
  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word) && word.utf16.count > 2
  }
  
  // uses a TextCheck to spell check the word is valid
  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
  }
  


}

