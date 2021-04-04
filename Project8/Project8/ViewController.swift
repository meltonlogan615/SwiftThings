//
//  ViewController.swift
//  Project8
//
//  Created by Logan Melton on 21/3/20.
//

import UIKit

class ViewController: UIViewController {
  
  var cluesLabel: UILabel!
  var answersLabel: UILabel!
  var currentAnswer: UITextField!
  var scoreLabel: UILabel!
  var letterButtons = [UIButton]()
  
  var activatedButtons = [UIButton]()
  var solutions = [String]()
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  var level = 1
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    
    // score label
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
    view.addSubview(scoreLabel)
    
    // clues label
    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.font = UIFont.systemFont(ofSize: 24)
    cluesLabel.text = "CLUES"
    cluesLabel.numberOfLines = 0
    cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    view.addSubview(cluesLabel)
    
    answersLabel = UILabel()
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    answersLabel.font = UIFont.systemFont(ofSize: 24)
    answersLabel.text = "ANSWERS"
    answersLabel.numberOfLines = 0
    answersLabel.textAlignment = .right
    answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    view.addSubview(answersLabel)
    
    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap Letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = UIFont.systemFont(ofSize: 44)
    currentAnswer.isUserInteractionEnabled = false
    view.addSubview(currentAnswer)
    
    let submit = UIButton(type: .system)
    submit.translatesAutoresizingMaskIntoConstraints = false
    submit.setTitle("SUBMIT", for: .normal)
    submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    view.addSubview(submit)
    
    let clear = UIButton(type: .system)
    clear.translatesAutoresizingMaskIntoConstraints = false
    clear.setTitle("CLEAR", for: .normal)
    clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    view.addSubview(clear)
    
    let buttonsView = UIView()
    buttonsView.translatesAutoresizingMaskIntoConstraints = false
    buttonsView.layer.borderWidth = 1
    buttonsView.layer.borderColor = CGColor.init(red: 0.00, green: 0.90, blue: 0.90, alpha: 1)
    view.addSubview(buttonsView)
    
    
    
    // sets an array of constraints to activate all elements
    NSLayoutConstraint.activate([
      // score label positioning
      scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      
      // clues label positioning
      cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
      cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
      
      // answers label positioning
      answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
      answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
      answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
      
      
      // current answers positioning
      currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
      
      // submit button positioning
      submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
      submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
      submit.heightAnchor.constraint(equalToConstant: 44),
      
      // clear button positioning
      clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
      clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
      clear.heightAnchor.constraint(equalToConstant: 44),
      
      // letter button positioning
      buttonsView.widthAnchor.constraint(equalToConstant: 750),
      buttonsView.heightAnchor.constraint(equalToConstant: 320),
      buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
      buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
      
    ])
    
    let width = 150 // set fixed width of buttons
    let height = 80 // set fixed height of buttons
    
    
    for row in 0..<4 { // defines the rows of being 0 indexed with 4 elements
      for column in 0..<5 { // defines the columns of being 0 indexed with 5 elements
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        letterButton.setTitle("WWW", for: .normal)
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        
        // sets the positioning & size of each button within the buttonsView to their relative position within the buttonView (column = 0 * width == 0, row = 0 * height = 0, where column & row are increased each time within the loop).
        let buttonFrame = CGRect(x: column * width, y: row * height, width: width, height: height)
        
        // sets the letterButton's frame = equal the result from previous constant declaration
        letterButton.frame = buttonFrame
        
        buttonsView.addSubview(letterButton)
        letterButtons.append(letterButton)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    loadLevel()
  }
  
  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
  }
  
  @objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }
    
    if let solutionsPosition = solutions.firstIndex(of: answerText) {
      activatedButtons.removeAll()
      
      var splitAnswer = answersLabel.text?.components(separatedBy: "\n")
      
      splitAnswer?[solutionsPosition] = answerText
      answersLabel.text = splitAnswer?.joined(separator: "\n")
      
      currentAnswer.text = ""
      score += 1
      
      
      
      if score % 7 == 0 {
        let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's Go", style: .default, handler: levelUp))
        present(ac, animated: true)
      }
    } else {
      let ac = UIAlertController(title: "Wrong answer", message: "Try again", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Do Over", style: .default))
      present(ac, animated: true)
    }
  }
  
  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""
    
    for button in activatedButtons {
      button.isHidden = false
    }
    activatedButtons.removeAll()
  }

  func loadLevel() {
    var clueString = ""
    var solutionsString = ""
    var letterBits = [String]()
    
    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
      if let levelContents = try? String(contentsOf: levelFileURL) {
        var lines = levelContents.components(separatedBy: "\n")
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
          let parts = line.components(separatedBy: ": ")
          let answer = parts[0]
          let clue = parts[1]
          
          clueString += "\(index + 1). \(clue)\n"
          
          let solutionWord = answer.replacingOccurrences(of: "|", with: "")
          solutionsString += "\(solutionWord.count) letters\n"
          solutions.append(solutionWord)
          
          let bits = answer.components(separatedBy: "|")
          letterBits += bits
          
          
        }
      }
    }
    cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
    answersLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    letterButtons.shuffle()
    if letterButtons.count == letterBits.count {
      for i in 0..<letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
      }
    }
  }
  
  func levelUp(action: UIAlertAction) {
    level += 1
    solutions.removeAll(keepingCapacity: true)
    loadLevel()
    
    for button in letterButtons {
      button.isHidden = false
    }
  }

}

