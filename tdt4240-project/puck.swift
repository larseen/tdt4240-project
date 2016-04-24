//
//  puck.swift
//  tdt4240-project
//
//  Created by Andreas Ystmark on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Puck: SKSpriteNode, SKPhysicsContactDelegate {
    private let points = 1
    private var lastTouched : Player!
    private var direction : CGVector!
    
    init() {
        let texture = SKTexture(imageNamed: "puck")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.setScale(0.4)
        self.zPosition = 1
        self.name = "puck"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.restitution = 1
        self.physicsBody?.mass = 0.02
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
    
    func reset() {
        let waitToRespawn = SKAction.waitForDuration(1)
        let remove = SKAction.hide()
        let show = SKAction.unhide()
        let moveBackx = SKAction.moveToX(frame.size.width/2, duration: 0)
        let moveBacky = SKAction.moveToY(frame.size.height/2, duration: 0)
        self.runAction(SKAction.sequence([remove, waitToRespawn,moveBackx,moveBacky,show]))
    }
    
    func touched(player : Player) {
        lastTouched = player
    }
    
    func getLastTouched() -> Player{
        return lastTouched
    }
    
    func updateDirection(_direction : CGVector) {
        direction = _direction
    }
    
    func getDirection() -> CGVector{
        return direction
    }
    
    func getPoints() -> Int{
        return points
    }
    
    func hit() {
        let impulse = SKAction.applyImpulse(direction, duration: 0.001)
        self.runAction(impulse)
    }
    
    func setVelocity(){
        self.physicsBody?.velocity = CGVectorMake(0, 0)
    }
}

