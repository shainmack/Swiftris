//
//  GameViewController.swift
//  Swiftris
//
//  Created by Shain Toth on 1/29/20.
//  Copyright © 2020 Shain Toth. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SwiftrisDelegate {
    
    var scene: GameScene!
    
    var swiftris:Swiftris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        
        // Present the scene
        skView.presentScene(scene)
        
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        //        scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
        //            self.swiftris.nextShape?.moveTo(column: StartingColumn, row: StartingRow)
        //            self.scene.movePreviewShape(shape: self.swiftris.nextShape!) {
        //                let nextShapes = self.swiftris.newShape()
        //                self.scene.startTicking()
        //                self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape!){}
        //            }
        //        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTick() {
        swiftris.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!, completion: {})
        self.scene.movePreviewShape(shape: fallingShape, completion: {})
        
        self.view.isUserInteractionEnabled = true
        self.scene.startTicking()
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite != nil {
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(shape: swiftris.fallingShape!) {}
    }
}

