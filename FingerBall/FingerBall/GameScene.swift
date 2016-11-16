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
    
    private var maxLeftRotate : CGFloat = 0.7
    private var minLeftRotate : CGFloat = -0.35
    
    private var maxRightRotate : CGFloat = -0.7
    private var minRightRotate : CGFloat = 0.35
    
    override func didMove(to view: SKView) {
        leftFlipper = self.childNode(withName: "LeftFlipper") as? SKSpriteNode
        rightFlipper = self.childNode(withName: "RightFlipper") as? SKSpriteNode
        ball = self.childNode(withName: "Ball") as? SKSpriteNode
        
        ballHit = false;
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        if pos.y < -550{
            if pos.x < -25{
                leftFlipper?.zRotation = minLeftRotate
                leftFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                leftFlipper?.physicsBody?.applyTorque(CGFloat(15000000))
            }
            else {
                rightFlipper?.zRotation = minRightRotate
                rightFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                rightFlipper?.physicsBody?.applyTorque(CGFloat(-15000000))
            }
        }
        let touchedNodes = self.nodes(at: pos)
        if touchedNodes.count > 0{
            for node in touchedNodes {
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
        if pos.y > -550{
        let nodesUnderFinger = self.nodes(at: pos)
        if nodesUnderFinger.count > 0{
            enumerateChildNodes(withName: "Bumper", using:
                { (node, stop) -> Void in
                    if !nodesUnderFinger.contains(node) {
                        node.alpha = 0.3
                        node.physicsBody = nil
                    }
                })
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if pos.y < -550{
            print(pos.x)
            if pos.x < -25{
                leftFlipper?.zRotation = maxLeftRotate
                leftFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                leftFlipper?.physicsBody?.applyTorque(CGFloat(-10000000))
            }
            else{
                rightFlipper?.zRotation = maxRightRotate
                rightFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                rightFlipper?.physicsBody?.applyTorque(CGFloat(10000000))
                
            }
        }
        
        let releasedNodes = self.nodes(at: pos)
        if releasedNodes.count > 0{
            for node in releasedNodes {
                if node.name == "Bumper"{
                    node.alpha = 0.3
                    node.physicsBody = nil
                }
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
        if (leftFlipper?.zRotation)! > CGFloat(maxLeftRotate){
            leftFlipper?.zRotation = maxLeftRotate
            leftFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        if (leftFlipper?.zRotation)! < CGFloat(minLeftRotate){
            leftFlipper?.zRotation = minLeftRotate
            leftFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        
        if (rightFlipper?.zRotation)! < CGFloat(maxRightRotate){
            rightFlipper?.zRotation = maxRightRotate
            rightFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        if (rightFlipper?.zRotation)! > CGFloat(minRightRotate){
            rightFlipper?.zRotation = minRightRotate
            rightFlipper?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        if contact.bodyA.node?.name == "Ball"{
            collisionBetween(ball: contact.bodyA.node!, other: contact.bodyB.node!)
        }
        else if contact.bodyB.node?.name == "Ball"{
            collisionBetween(ball: contact.bodyB.node!, other: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(ball: SKNode, other: SKNode){

    }
}
