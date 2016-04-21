//
//  player.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 11.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//


import Foundation
import SpriteKit

class AI {
    let speed = 200.0
    var currentVelocity = CGVector(dx: 0, dy: 0)
    
    func newAction(player: Player,playerPos:CGPoint, puckPos: CGPoint)->SKAction{
        if (puckPos.y > playerPos.y){
            if (abs(puckPos.x - playerPos.x) > 50 ){
                let direction = CGVector(dx: 0, dy: puckPos.y + 100 - playerPos.y)
                let dist = sqrt(direction.dx*direction.dx + direction.dy*direction.dy)
                currentVelocity = direction
                return SKAction.moveTo(CGPoint(x: playerPos.x, y: puckPos.y + 100), duration: Double(dist)/speed)
            }
            return SKAction.moveByX(50,y:0, duration:50/speed)
            
        }
        let dist = sqrt(pow(puckPos.x - playerPos.x, 2) + pow(puckPos.y - playerPos.y,2))
        return SKAction.moveTo(CGPoint(x: puckPos.x, y: puckPos.y), duration: Double(dist)/speed)
        
    }
    
    func normalize(v: CGVector) -> CGVector{
        let largest = max(v.dx, v.dy)
        return CGVector(dx: v.dx/largest, dy: v.dx/largest)
        
    }
    
    
    

    
}