//
//  physicsFactory.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit


class physicsFactory {
    init(){
        
    }
    
    func setPhys(scene : SKScene){
        scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: scene.frame)
        scene.physicsBody?.friction = 0
        scene.physicsBody?.linearDamping = 0
        scene.physicsBody?.restitution = 1.0
    }
    

    
    
}
