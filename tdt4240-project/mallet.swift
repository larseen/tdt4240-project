//
//  puck.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Mallet: SKSpriteNode, SKPhysicsContactDelegate {
    
    var mallet = SKSpriteNode(imageNamed: "Mallet")
    
    init() {
        let texture = SKTexture(imageNamed: "Mallet")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        mallet.position = CGPointMake(frame.width/2, frame.height/4)
        mallet.name = "mallet";
        mallet.zPosition = 1
        mallet.setScale(CGFloat(0.35))
        mallet.physicsBody = SKPhysicsBody(circleOfRadius: mallet.size.width/2)
        //mallet.physicsBody?.usesPreciseCollisionDetection = true
        mallet.physicsBody?.categoryBitMask = CollisionCategories.malCol
        mallet.physicsBody?.contactTestBitMask = CollisionCategories.puckCol
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }

    

}

