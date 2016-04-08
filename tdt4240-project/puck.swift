//
//  puck.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class puck: SKSpriteNode, SKPhysicsContactDelegate {
    
    private var _pointValue:Int = 100
    
    var pointValue:Int {
        get {
            return _pointValue
        }
        set {
            _pointValue = newValue;
            
        }
    }

    
    var puck = SKSpriteNode(imageNamed: "puck")
    
    func get(width : CGFloat, height : CGFloat) -> SKSpriteNode{
        puck.position = CGPointMake(width/2, height/2)
        puck.zPosition = 1
        return puck;
    }
}

