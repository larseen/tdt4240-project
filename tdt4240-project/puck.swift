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
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2.5)
        self.physicsBody?.restitution = 1
        self.physicsBody?.mass = 0.01
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.puckCol
        self.physicsBody?.contactTestBitMask = CollisionCategories.malCol
    
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setPos(frame: CGRect){
        self.position = CGPointMake (frame.width/2, frame.height/2)
    }
    
    
    private var pointValue:Int{
        get {
            return self.pointValue
        }
        set {
            self.pointValue = newValue;
            
        }
    }

    

    func bounce(){
        self.physicsBody?.applyImpulse(CGVectorMake(10, -10))
        print("lol")
    }
}

