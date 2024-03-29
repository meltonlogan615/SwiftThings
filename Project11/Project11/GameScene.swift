//
//  GameScene.swift
//  Project11
//
//  Created by Logan Melton on 21/3/23.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var scoreLabel: SKLabelNode!
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  var editLabel: SKLabelNode!
  var editingMode: Bool = false {
    didSet {
      if editingMode {
        editLabel.text = "Done"
      } else {
        editLabel.text = "Edit"
      }
    }
  }
  
  let balls = ["ballBlue", "ballCyan", "ballGreen",
               "ballGrey", "ballPurple", "ballRed", "ballYellow"]
    
  override func didMove(to view: SKView) {
    
    // setting the properties of the background & adding to view
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    
    // setting the properties of the scoreLabel & adding to view
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.position = CGPoint(x: 980, y: 700)
    addChild(scoreLabel)
    
    editLabel = SKLabelNode(fontNamed: "ChalkDuster")
    editLabel.text = "Edit"
    editLabel.position = CGPoint(x: 80, y: 700)
    addChild(editLabel)
    
    // fulfilling SKPhysicsContactDelegate
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    physicsWorld.contactDelegate = self
    
    makeSlotAtPosition(at: CGPoint(x: 128, y: 0), isGood: true)
    makeSlotAtPosition(at: CGPoint(x: 384, y: 0), isGood: false)
    makeSlotAtPosition(at: CGPoint(x: 640, y: 0), isGood: true)
    makeSlotAtPosition(at: CGPoint(x: 896, y: 0), isGood: false)
    
    makeBouncer(at: CGPoint(x: 0, y: 0))
    makeBouncer(at: CGPoint(x: 256, y: 0))
    makeBouncer(at: CGPoint(x: 512, y: 0))
    makeBouncer(at: CGPoint(x: 768, y: 0))
    makeBouncer(at: CGPoint(x: 1024, y: 0))

  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // instance of first touch on the screen
    guard let touch = touches.first else { return }
    // gets the x-y coord of the touch location on the screen
    let location = touch.location(in: self)
    let objects = nodes(at: location)
    
    if objects.contains(editLabel) {
      editingMode.toggle()
    } else {
      if editingMode {
        // create box
        // random box sizes
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        // random colors
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
        
        box.zRotation = CGFloat.random(in: 0...3)
        // place where tapped
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        addChild(box)
      } else {
        let randomIndex = Int.random(in: 0...balls.count - 1) // fulfills challenge 1
        let ball = SKSpriteNode(imageNamed: balls[randomIndex]) // fulfills challenge 1
        let minHeight = CGPoint(x: 0, y: 550)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        // determines bouncy-bounce
        ball.physicsBody?.restitution = 0.4
        // detect collisions
        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
        ball.position = location
        ball.name = "ball" // fulfills challenge 2
        if ball.position.y >= minHeight.y {
          addChild(ball)
        }
      }
    }
  }
  
  func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    // sets as an immovable object that can be interacted with, but does not change itself.
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
  }
  
  func makeSlotAtPosition(at position:CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode
    
    if isGood {
      slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
      slotBase.name = "good"
    } else {
      slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
      slotBase.name = "bad"
    }
    
    slotBase.position = position
    slotGlow.position = position
    
    slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
    slotBase.physicsBody?.isDynamic = false
    
    addChild(slotBase)
    addChild(slotGlow)
    
    let spin = SKAction.rotate(byAngle: .pi, duration: 10)
    let spinForever = SKAction.repeatForever(spin)
    slotGlow.run(spinForever)
  }
  
  func collision(between ball: SKNode, object: SKNode) {
    if object.name == "good" {
      destroy(ball: ball)
      score += 1
    } else if object.name == "bad" {
      destroy(ball: ball)
      score -= 1
    }
  }
  
  func destroy(ball: SKNode) {
    if let fireParticle = SKEmitterNode(fileNamed: "FireParticles") {
      fireParticle.position = ball.position
      addChild(fireParticle)
    }
    ball.removeFromParent()
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }
    if nodeA.name == "ball" {
      collision(between: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
      collision(between: nodeB, object: nodeA)
    }
  }
}
