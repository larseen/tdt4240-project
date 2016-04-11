import UIKit
import SpriteKit

class physicsFactory{
    
    func setPhys(scene : SKScene){
        scene.physicsBody?.friction = 0.01
        scene.physicsBody?.linearDamping = 0.3
        scene.physicsBody?.restitution = 1.0
        scene.physicsWorld.gravity = CGVectorMake(0,0)
    
        
    }
    
    
    
    
}