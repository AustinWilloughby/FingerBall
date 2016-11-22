//
//  GameScene.swift
//  FingerBall
//
//  Created by student on 11/9/16.
//  Copyright © 2016 Team Finger. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var leftFlipper : SKSpriteNode?
    private var rightFlipper : SKSpriteNode?
    private var ballSpawn : SKSpriteNode?
    private var livesLabel: SKLabelNode?
    private var scoreLabel: SKLabelNode?
    
    private var maxLeftRotate : CGFloat = 0.7
    private var minLeftRotate : CGFloat = -0.35
    
    private var maxRightRotate : CGFloat = -0.7
    private var minRightRotate : CGFloat = 0.35
    
    private var lives = 3
    private var timer = 9.0
    private var score = 0 {
        didSet{
            let scoreString = String(format: "%06d", score)
            scoreLabel?.text = "Score: " + scoreString
        }
    }
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0.5
    var ballInterval = 10.0
    
    override func didMove(to view: SKView) {
        leftFlipper = self.childNode(withName: "LeftFlipper") as? SKSpriteNode
        rightFlipper = self.childNode(withName: "RightFlipper") as? SKSpriteNode
        ballSpawn = self.childNode(withName: "BallSpawn") as? SKSpriteNode
        livesLabel = self.childNode(withName: "LivesLabel") as? SKLabelNode
        scoreLabel = self.childNode(withName: "ScoreLabel") as? SKLabelNode
        
        leftFlipper?.physicsBody?.usesPreciseCollisionDetection = true
        rightFlipper?.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsWorld.contactDelegate = self
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.y < -550{
            run(SKAction.playSoundFileNamed("Hit_Hurt6.mp3", waitForCompletion: true))
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
                    let bumper = node as! BumperSprite
                    bumper.activateBumper()
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
                        let bumper = node as! BumperSprite
                        bumper.deactivateBumper()
                    }
                })
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if pos.y < -550{
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
                    let bumper = node as! BumperSprite
                    bumper.deactivateBumper()
                    
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
        calculateDeltaTime(currentTime: currentTime)
        timer += dt
        
        if(timer > ballInterval)
        {
            let newBall = ballSpawn?.copy() as! SKSpriteNode?
            if(newBall != nil){
                newBall?.name = "Ball"
                let fadeIn = SKAction.fadeIn(withDuration: 1.0)
                newBall?.run(fadeIn, completion: {
                    newBall?.physicsBody?.categoryBitMask = CollisionMask.projectile
                    newBall?.physicsBody?.contactTestBitMask = CollisionMask.all
                    newBall?.physicsBody?.usesPreciseCollisionDetection = true
                    newBall?.physicsBody?.allowsRotation = true
                    newBall?.physicsBody?.affectedByGravity = true
                    newBall?.physicsBody?.isDynamic = true
                    newBall?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
                    self.run(SKAction.playSoundFileNamed("Laser_Shoot35.mp3", waitForCompletion: true))

                })
                addChild(newBall!)
                let trail = SKEmitterNode(fileNamed: "Trail.sks")
                trail?.targetNode = self
                newBall?.addChild(trail!)
            }
            timer = 0.0
        }
        
        enumerateChildNodes(withName: "Ball", using:
            { (node, stop) -> Void in
                if(node.position.y < -1000)
                {
                    self.removeBall(node: node)
                }
        })

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
            if contact.bodyB.node?.name == "Bumper"{
                let bumper = contact.bodyB.node as! BumperSprite
                bumper.repelBall(ball: contact.bodyA.node as! SKSpriteNode)
                score += 10
            }
        }
        else if contact.bodyB.node?.name == "Ball"{
            if contact.bodyA.node?.name == "Bumper"{
                let bumper = contact.bodyA.node as! BumperSprite
                bumper.repelBall(ball: contact.bodyB.node as! SKSpriteNode)
                score += 10
            }
        }
    }
    
    //Calculate time since last cycle
    func calculateDeltaTime(currentTime: TimeInterval){
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }
        else{
            dt = 0
        }
        lastUpdateTime = currentTime
    }
    
    func removeBall(node: SKNode)
    {
        lives -= 1
        livesLabel?.text = "Lives: \(lives)"
        if let emit = SKEmitterNode(fileNamed: "Explosion.sks"){
            emit.position = node.position
            addChild(emit)
        }
        if(lives <= 0)
        {
            sceneManager?.loadGameOverScene()
        }
        node.removeFromParent()
        
        run(SKAction.playSoundFileNamed("Explosion6.mp3", waitForCompletion: true))
    }
}
