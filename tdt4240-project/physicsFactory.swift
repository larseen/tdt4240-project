import UIKit
import SpriteKit

class physicsFactory{
    
    init(){
        
    }
    
    func setPhys(scene : SKScene){
        scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: scene.frame)
        scene.physicsBody?.friction = 0.5
        scene.physicsBody?.linearDamping = 0.3
        scene.physicsBody?.restitution = 1.0
        scene.physicsWorld.gravity = CGVectorMake(0,0)
        
    }
    
    
    
    
}