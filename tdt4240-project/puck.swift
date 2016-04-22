//
//  puck.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Puck: SKSpriteNode, SKPhysicsContactDelegate {
    let points = 100
    init() {
        let texture = SKTexture(imageNamed: "puck")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.setScale(0.4)
        self.zPosition = 1
        self.name = "puck"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.restitution = 1
        self.physicsBody?.mass = 0.02
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.puckCol
        self.physicsBody?.contactTestBitMask = CollisionCategories.malCol
        self.physicsBody?.collisionBitMask = CollisionCategories.malCol
    
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setPos(frame: CGRect){
        self.position = CGPointMake (frame.width/2, frame.height/2)
    }
    

    func bounce(){
        self.physicsBody?.applyImpulse(CGVectorMake(10, 0))
        print("lol")
    }
    
    func getPoints() -> Int{
        return points
    }
    
    func setVelocity(){
        self.physicsBody?.velocity = CGVectorMake(0, 0)
    }
}

