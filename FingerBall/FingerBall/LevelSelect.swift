//
//  LevelSelect.swift
//  FingerBall
//
//  Created by student on 11/22/16.
//  Copyright © 2016 Team Finger. All rights reserved.
//

import SpriteKit

class LevelSelect: SKScene {
    // MARK: - ivars -
    let button:SKLabelNode = SKLabelNode(fontNamed: GameData.font.mainFont)
    
    private var level1:SKShapeNode?
    private var level2:SKShapeNode?
    private var level3:SKShapeNode?
    
    //Set up scene
    override func didMove(to view: SKView) {
        backgroundColor = GameData.scene.backgroundColor
        
        level1 = self.childNode(withName: "Level1") as? SKShapeNode
        level2 = self.childNode(withName: "Level2") as? SKShapeNode
        level3 = self.childNode(withName: "Level3") as? SKShapeNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let touchedNodes = self.nodes(at: pos)
        if touchedNodes.count > 0{
            for node in touchedNodes {
                if node.name == "Level1"{
                    sceneManager?.loadGameScene()
                }
                else if node.name == "Level2"{
                    sceneManager?.loadGameSceneTwo()
                }
                else if node.name == "Level3"{
                    sceneManager?.loadGameSceneThree()
                }
            }
        }
    }
}
