//
//  powerup.swift
//  tdt4240-project
//
//  Created by Anna Kastet on 22/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

// Base class for powerups
class PowerUp {
    private let visibleDuration : NSTimeInterval = 20 // how long powerup icon to be caught is visible
    private let powerupActionDuration : NSTimeInterval = 20 // how long powerup is in action
    private var gameScene : GameScene
    private var player : Player? // the player with the powerup. set when player catches it
    private var iconNode : SKSpriteNode?

    init(gameScene : GameScene) {
        self.gameScene = gameScene
    }
    
    // Place icon to be caught in random position in frame
    func showIcon() {
        iconNode!.position = Helpers.getRandomPositionInFrame(gameScene.frame)
        iconNode!.physicsBody = SKPhysicsBody(circleOfRadius: iconNode!.size.width/2)
        iconNode!.setScale(0.4)
        iconNode!.physicsBody?.categoryBitMask = CollisionCategories.powerupCol
        iconNode!.physicsBody?.contactTestBitMask = CollisionCategories.puckCol
        gameScene.addChild(iconNode!)
    }
    
    // Hide icon
    func hide() {
        iconNode?.removeFromParent()
    }
    
    func getVisibleDuration() -> NSTimeInterval {
        return visibleDuration
    }
    
    func getPowerupActionDuration() -> NSTimeInterval {
        return powerupActionDuration
    }
    
    // called when powerup icon is caught by one of the players
    func didGetCaught(player : Player) {
        hide() // remove icon from scene
        self.player = player
        self.start() // start doing the cool stuff
    }
    
    // start the powerup
    func start() {
        // must be overriddden
    }
    
    // stop the powerup
    func stop() {
        // must be overriden
    }
}

/*
 * MegaMallet: Increases the size of the mallet of the player who catches it!
 */
class MegaMallet : PowerUp {

    private let MALLET_SCALE : Double = 2 // How much bigger the mallet should become

    override func showIcon() {
        let iconTexture = SKTexture(imageNamed: "MegaMallet")
        iconNode = SKSpriteNode(texture: iconTexture, color: SKColor.clearColor(), size: iconTexture.size())
        super.showIcon()
    }
    
    /*
     * Start powerup on affected player
     */
    override func start() {
        let malletSize = player!.getMallet().size
        player!.getMallet().size = CGSize(width: Double(malletSize.width) * MALLET_SCALE, height: Double(malletSize.height) * MALLET_SCALE)
        player!.getMallet().setPhysicsBody(); //set physics body according to new mallet size
    }
    
    /*
     * Stop the powerup
     */
    @objc override func stop() {
        let malletSize = player!.getMallet().size
        player!.getMallet().size = CGSize(width: Double(malletSize.width) / MALLET_SCALE, height: Double(malletSize.height) / MALLET_SCALE)
        player!.getMallet().setPhysicsBody(); //set physics body according to new mallet size
    }
}
