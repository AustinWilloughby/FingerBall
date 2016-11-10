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
    
    override func didMove(to view: SKView) {
        leftFlipper = self.childNode(withName: "LeftFlipper") as? SKSpriteNode
        rightFlipper = self.childNode(withName: "RightFlipper") as? SKSpriteNode
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.y < UIScreen.main.bounds.height * 0.2{
            if pos.x < UIScreen.main.bounds.width * 0.5 {
                //Left bumper
                let rotateLeftUp = SKAction.rotate(byAngle: 1, duration: 0.06)
                rotateLeftUp.timingMode = SKActionTimingMode.easeOut
                let rotateLeftDown = SKAction.rotate(byAngle: -1, duration: 0.06)
                rotateLeftDown.timingMode = SKActionTimingMode.easeOut
                leftFlipper?.run(SKAction.sequence([rotateLeftUp, rotateLeftDown]))
            }
            else{
                 //Right bumper
                let rotateRightUp = SKAction.rotate(byAngle: -1, duration: 0.06)
                rotateRightUp.timingMode = SKActionTimingMode.easeOut
                let rotateRightDown = SKAction.rotate(byAngle: 1, duration: 0.06)
                rotateRightDown.timingMode = SKActionTimingMode.easeOut
                rightFlipper?.run(SKAction.sequence([rotateRightUp, rotateRightDown]))
            }
        }
        var touchedNode = self.nodes(at: pos)
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
    }
}
