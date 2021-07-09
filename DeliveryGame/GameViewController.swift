//
//  GameViewController.swift
//  DeliveryGame
//
//  Created by Alexander Markevich on 6.07.21.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameViewControllerDelegate {
   func endGame(points: Double)
}

class GameViewController: UIViewController {
    
    var delegate: GameViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        runGame()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    private func runGame() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                scene.physicsWorld.gravity = .zero
                scene.endGameDelegate = self
                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}

extension GameViewController: GameViewControllerDelegate {
    func endGame(points: Double) {
        navigationController?.popToRootViewController(animated: true)
        delegate?.endGame(points: points)
    }
}
