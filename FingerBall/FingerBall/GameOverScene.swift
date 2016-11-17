//
//  GameOverScene.swift
//  FingerBall
//
//  Created by student on 11/16/16.
//  Copyright © 2016 Team Finger. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    // MARK: - ivars -
    let sceneManager:GameViewController
    let button:SKLabelNode = SKLabelNode(fontNamed: GameData.font.mainFont)
    
    // MARK: - Initialization -
    init(size: CGSize, scaleMode:SKSceneScaleMode, sceneManager:GameViewController){
        self.sceneManager = sceneManager
        super.init(size: size)
        self.scaleMode = scaleMode
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been inplemented")
    }
    
    //Set up scene
    override func didMove(to view: SKView) {
        backgroundColor = GameData.scene.backgroundColor
        let label2 = SKLabelNode(fontNamed: "AvenirNextCondensed-HeavyItalic")
        
        label2.text = "Game Over"
        label2.fontSize = 200
        label2.position = CGPoint(x:size.width/2, y:size.height/2 + 100)
        label2.zPosition = 1
        addChild(label2)
        
        let label4 = SKLabelNode(fontNamed: GameData.font.mainFont)
        label4.text = "Tap to Play Again"
        label4.fontColor = UIColor.lightGray
        label4.fontSize = 70
        label4.position = CGPoint(x:size.width/2, y:size.height/2 - 700)
        addChild(label4)
        
        
    }
    
    override func touchesBegan(_ touchces: Set<UITouch>, with event: UIEvent?){
        sceneManager.loadHomeScene()
    }
}
