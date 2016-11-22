//
//  BumperSprite.swift
//  FingerBall
//
//  Created by student on 11/16/16.
//  Copyright © 2016 Team Finger. All rights reserved.
//

import Foundation
import SpriteKit

class BumperSprite : SKSpriteNode{
    
    var strength : CGFloat = 150.0
    
    init() {
        //Setup bumper
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: SKColor.white, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func repelBall(ball: SKSpriteNode){
        //Code to push ball from bumper
        var direction = CGVector(dx: ball.position.x - position.x, dy: ball.position.y - position.y)
        direction = direction.normalize()
        ball.physicsBody?.applyImpulse(direction * strength)
        if let emit = SKEmitterNode(fileNamed: "Hit.sks"){
            emit.position = ball.position
            addChild(emit)
        }
        run(SKAction.playSoundFileNamed("Powerup5.mp3", waitForCompletion: true))
    }
    
    //Code for when the player activates a bumper
    func activateBumper(){
        alpha = 1
        physicsBody = SKPhysicsBody(circleOfRadius: frame.width / 2.2)
        physicsBody?.contactTestBitMask = CollisionMask.all
        physicsBody?.categoryBitMask = CollisionMask.button
        physicsBody?.collisionBitMask = CollisionMask.all
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
    //Code for when a player deactivates a bumper
    func deactivateBumper(){
        alpha = 0.3
        physicsBody = nil
    }
}
