//
//  puck.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class puck: SKSpriteNode, SKPhysicsContactDelegate {
     var puck = SKSpriteNode(imageNamed: "puck")
    
    private var _pointValue:Int = 100
    
   /* var pointValue:Int {
        get {
            return _pointValue
        }
        set {
            _pointValue = newValue;
            
        }
    }*/

    
    func get(width : CGFloat, height : CGFloat) -> SKSpriteNode{
        puck.position = CGPointMake(width/2, height/2)
        puck.zPosition = 1
        puck.physicsBody = SKPhysicsBody(circleOfRadius: puck.size.width/2)
        return puck;
    }
}

