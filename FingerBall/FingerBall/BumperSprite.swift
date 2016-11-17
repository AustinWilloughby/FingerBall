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
    
    init() {
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: SKColor.white, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        if contact.bodyA.node?.name == "Ball"{
            collisionBetween(ball: contact.bodyA.node!, other: contact.bodyB.node!)
        }
        else if contact.bodyB.node?.name == "Ball"{
            collisionBetween(ball: contact.bodyB.node!, other: contact.bodyA.node!)
        }
    }
}
