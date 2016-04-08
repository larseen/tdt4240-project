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

    
    
    func Create(){
        let texture = SKTexture(imageNamed: "puck")
        self.texture = texture
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.angularDamping = 0.0
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = true
    }
    
    var pointValue:Int {
        get {
            return _pointValue
        }
        set {
            _pointValue = newValue;
            
        }
    }
    
    
    

    


    
    
    
    
    

}
