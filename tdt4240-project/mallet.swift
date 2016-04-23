

import SpriteKit

let malletFileNames:[String:String] = ["red":"MalletRed", "blue":"MalletBlue"]

class Mallet: SKSpriteNode, SKPhysicsContactDelegate {
    
    //var mallet = SKSpriteNode(imageNamed: "Mallet")
    
    init(color: String) {
        let texture = SKTexture(imageNamed: malletFileNames[color]!)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.position = CGPointMake(frame.width/2, frame.height/4)
        self.name = "mallet";
        self.zPosition = 1
        self.setScale(CGFloat(0.35))
        setPhysicsBody()
    }
    
    func setPhysicsBody() {
        self.physicsBody?.restitution = 1
        self.physicsBody?.mass = 500
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.malCol
        self.physicsBody?.contactTestBitMask = CollisionCategories.puckCol
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }

    

}

