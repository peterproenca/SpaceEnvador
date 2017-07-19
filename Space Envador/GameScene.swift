//
//  GameScene.swift
//  SpaceEEEEvader
//
//  Created by iD Student on 7/19/17.
//  Copyright © 2017 ID TECH. All rights reserved.
//

import SpriteKit

import GameplayKit



class GameScene: SKScene {
    
    let heroSpeed: CGFloat = 100.0
    let hero = SKSpriteNode(imageNamed: "Spaceship")
   
    private var label : SKLabelNode?
    
    private var spinnyNode : SKShapeNode?
    
    
    
    override func didMove(to view: SKView) {
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        
        swipeLeft.direction = .left
        
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeRight)

        
        
        
        
        
        // Get label node from scene and store it for use later
        
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        
        if let label = self.label {
            
            label.alpha = 0.0
            
            label.run(SKAction.fadeIn(withDuration: 2.0))
            
            

            
        }
        backgroundColor = SKColor.black

        
        let xCoord = size.width * 0.5
        let yCoord = size.height * 0.5
        
        hero.size.height = 50
        hero.size.width = 50
        
        hero.position = CGPoint(x: xCoord, y: yCoord)
        
        addChild(hero)
        
        
        // Create shape node to use during mouse interaction
        
        
        
        
        }
    func swipedUp(sender:UISwipeGestureRecognizer){
        
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y + heroSpeed), duration: 0.5)
        
        hero.run(actionMove)
    }
    
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y - heroSpeed), duration: 0.5)
        
        hero.run(actionMove)
    }
    
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint(x: hero.position.x - heroSpeed, y: hero.position.y), duration: 0.5)
        
        hero.run(actionMove)
    }
    
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint(x: hero.position.x + heroSpeed, y: hero.position.y), duration: 0.5)
        
        hero.run(actionMove)
    }
    






    func touchDown(atPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            n.position = pos
            
            n.strokeColor = SKColor.green
            
            self.addChild(n)
            
        }
        
    }
    
    
    
    func touchMoved(toPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            n.position = pos
            
            n.strokeColor = SKColor.blue
            
            self.addChild(n)
            
        }
        
    }
    
    
    
    func touchUp(atPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            n.position = pos
            
            n.strokeColor = SKColor.red
            
            self.addChild(n)
            
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        let bullet = SKSpriteNode ()
        bullet.color = UIColor.green
        bullet.size = CGSize(width: 5, height: 5)
        bullet.position = CGPoint (x: hero.position.x, y: hero.position.y)
        addChild(bullet)
        
        guard let touch = touches.first else{return }
        let touchLocation = touch.location(in: self)
        let vector = CGVector(dx: -(hero.position.x - touchLocation.x), dy: -(hero.position.y - touchLocation.y))
        
        let projectileAction = SKAction.sequence([
            SKAction.repeat(
                SKAction.move(by: vector, duration: 0.5), count: 10),
            SKAction.wait(forDuration: 0.5),
            SKAction.removeFromParent()
            ])
        bullet.run(projectileAction)
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
    }
    
    
    
    

    override func update(_ currentTime: TimeInterval) {
        
        // Called before each frame is rendered
        
    }
    

    
}
