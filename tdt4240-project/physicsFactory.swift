import UIKit
import SpriteKit

class physicsFactory{
    
    init(){
        
    }
    
    func setPhys(scene : SKScene){
        scene.physicsBody?.friction = 0.2
        scene.physicsBody?.linearDamping = 0.3
        scene.physicsBody?.restitution = 2.0
        scene.physicsWorld.gravity = CGVectorMake(0,0)
    
        
    }
    
    
    
    
}