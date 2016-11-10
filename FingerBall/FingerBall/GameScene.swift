//
//  GameScene.swift
//  FingerBall
//
//  Created by student on 11/9/16.
//  Copyright © 2016 Team Finger. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var leftFlipper : SKSpriteNode?
    private var rightFlipper : SKSpriteNode?
    private var ball: SKSpriteNode?
    
    private var ballHit : Bool?
    private var leftFlipped : Bool?
    private var rightFlipped : Bool?
    
    override func didMove(to view: SKView) {
        leftFlipper = self.childNode(withName: "LeftFlipper") as? SKSpriteNode
        rightFlipper = self.childNode(withName: "RightFlipper") as? SKSpriteNode
        ball = self.childNode(withName: "Ball") as? SKSpriteNode
        
        ballHit = false;
        leftFlipped = false;
        rightFlipped = false;
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.y < UIScreen.main.bounds.height * 0.8{
            if pos.x < UIScreen.main.bounds.width * 0.5 && leftFlipped == false {
                //Left bumper
                let rotateLeftUp = SKAction.rotate(byAngle: 1, duration: 0.06)
                rotateLeftUp.timingMode = SKActionTimingMode.easeOut
                let rotateLeftDown = SKAction.rotate(byAngle: -1, duration: 0.06)
                rotateLeftDown.timingMode = SKActionTimingMode.easeOut
                leftFlipper?.run(rotateLeftUp, completion: {
                    self.leftFlipper?.run(rotateLeftDown, completion:
                        {self.leftFlipped = false})
                })
            }
            else if pos.x > UIScreen.main.bounds.width * 0.5 && rightFlipped == false {
                 //Right bumper
                let rotateRightUp = SKAction.rotate(byAngle: -1, duration: 0.06)
                rotateRightUp.timingMode = SKActionTimingMode.easeOut
                let rotateRightDown = SKAction.rotate(byAngle: 1, duration: 0.06)
                rotateRightDown.timingMode = SKActionTimingMode.easeOut
                rightFlipper?.run(rotateRightUp, completion: {
                    self.rightFlipper?.run(rotateRightDown, completion:
                        {self.rightFlipped = false})
                })
            }
        }
        let touchedNode = self.nodes(at: pos)
        if touchedNode.count > 0{
            for node in touchedNode {
                if node.name == "Bumper"{
                    node.alpha = 1
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.frame.width / 2.2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.affectedByGravity = false
                    node.physicsBody?.allowsRotation = false
                }
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        for node in self.children {
            if node.name == "Bumper"{
                node.alpha = 0.3
                node.physicsBody = nil
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        //CHECK FOR COLLISIONS WITH FLIPPERS WHILE THEY ARE FLIPPED. IF SO, SET BALL HIT TO TRUE
        if ballHit == true{
            self.ball?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
            ballHit = false
        }
    }
}
