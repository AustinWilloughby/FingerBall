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

var sceneManager:GameViewController?

class GameViewController: UIViewController {

    let screenSize = CGSize(width: 1080, height: 1920) // iPhone 6+, 16:9 (1.77) aspect ratio
    let scaleMode = SKSceneScaleMode.aspectFill
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHomeScene()
        sceneManager = self
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
    
    func loadGameScene(){
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
    
    func loadGameSceneTwo(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene2") {
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
    
    func loadGameSceneThree(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene3") {
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
    
    func loadHomeScene(){
        if let view = self.view as! SKView? {
            let scene = HomeScene(size:screenSize, scaleMode:scaleMode, sceneManager:self )
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func loadLevelSelect(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "LevelSelect") {
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
    
    func loadGameOverScene(score:CGFloat){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameOverScene(size:screenSize, scaleMode:scaleMode, sceneManager:self, score:score )
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
