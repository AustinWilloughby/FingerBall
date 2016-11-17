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
    
    var strength : CGFloat = 100.0
    
    init() {
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: SKColor.white, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func didBegin(_ contact: SKPhysicsContact){
        if contact.bodyA.node?.name == "Ball"{
            if contact.bodyB.node?.name == "Bumper"{
                repelBall(ball: (contact.bodyA.node as! SKSpriteNode?)!, bumper: (contact.bodyB.node as! BumperSprite?)!)
            }
        }
        else if contact.bodyB.node?.name == "Ball"{
            if contact.bodyA.node?.name == "Bumper"{
                repelBall(ball: (contact.bodyB.node as! SKSpriteNode?)!, bumper: (contact.bodyA.node as! BumperSprite?)!)
            }
        }
    }
    
    func repelBall(ball: SKSpriteNode, bumper: BumperSprite){
        var direction = CGVector(dx: ball.position.x - bumper.position.x, dy: ball.position.y - bumper.position.y)
        direction = direction.normalize()
        ball.physicsBody?.applyImpulse(direction * strength)
    }
}
