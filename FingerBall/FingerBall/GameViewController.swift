//
//  GameViewController.swift
//  FingerBall
//
//  Created by student on 11/9/16.
//  Copyright © 2016 Team Finger. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // MARK: - ivars -
    var gameScene: GameScene?
    var skView: SKView!
    let showDebugData = true
    let screenSize = CGSize(width: 1080, height: 1920) // iPhone 6+, 16:9 (1.77) aspect ratio
    let scaleMode = SKSceneScaleMode.aspectFill
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func loadHomeScene(){
        let scene = HomeScene(size: screenSize, scaleMode:scaleMode, sceneManager:self)
        let reveal = SKTransition.crossFade(withDuration: 0.7)
        skView.presentScene(scene, transition: reveal)
    }
    
    func loadGameScene(){
        let scene = GameScene(size:screenSize, sceneManager:self)
        let reveal = SKTransition.crossFade(withDuration: 0.7)
        skView.presentScene(scene, transition: reveal)
    }
}
