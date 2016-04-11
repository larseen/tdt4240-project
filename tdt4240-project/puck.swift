//
//  puck.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Puck: SKSpriteNode, SKPhysicsContactDelegate {
    //var puck = SKSpriteNode(imageNamed: "puck")
    init() {
        let texture = SKTexture(imageNamed: "puck")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.position = CGPointMake (frame.size.width/2, frame.size.height/2)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2.5)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.puckCol
        self.physicsBody?.contactTestBitMask = CollisionCategories.malCol
    
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }
    
    
   // private var _pointValue:Int = 100
    
   /* var pointValue:Int {
        get {
            return _pointValue
        }
        set {
            _pointValue = newValue;
            
        }
    }*/

    

    func bounce(){
        self.physicsBody?.applyImpulse(CGVectorMake(10, 0))
        print("lol")
    }
}

