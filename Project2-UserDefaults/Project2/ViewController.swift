//
//  ViewController.swift
//  Project2
//
//  Created by Logan Melton on 3/10/21.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  @IBOutlet var questionCountLabel: UILabel!
  
  var countries = [String]()
  var highScore = "0"
  var score = 0
  var correctAnswer = 0
  var questionCount = 0
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor.systemTeal
    super.viewDidLoad()
    // let defaults = UserDefaults.standard
    
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    button1.layer.borderWidth = 1
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderWidth = 1
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderWidth = 1
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    askQuestion()
  }
  
  func askQuestion(action: UIAlertAction! = nil) {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    title = countries[correctAnswer].uppercased()
  }
  
  @IBAction func answerSelected(_ sender: UIButton) {
    var title = String()
    var message = String()
    if sender.tag == correctAnswer && score < 3 {
      score += 1
      title = "Correct"
      message = "Your score is \(score)"
    } else if sender.tag == correctAnswer && score == 3 {
      title = "You Win"
      message = "Tap Continue To Play Again"
    } else {
      score -= 1
      title = "Incorrect"
      message = "You chose \(countries[sender.tag].uppercased()) \n Your score is \(score) "
    }
    
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    
    present(ac, animated: true)
  }
  
//  func save() {
//    let jsonEncoder = JSONEncoder()
//
//    if let saveData = try? jsonEncoder.encode(highScore) {
//      let defaults = UserDefaults.standard
//      defaults.set(saveData, forKey: highScore)
//    }
//  }
  
}

