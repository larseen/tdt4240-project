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

    
    func get(width : CGFloat, height : CGFloat) -> SKSpriteNode{
        mallet.position = CGPointMake(width/2, height/4)
        mallet.name = "mallet";
        mallet.zPosition = 1
        mallet.setScale(CGFloat(0.35))
        return mallet;
    }
}

