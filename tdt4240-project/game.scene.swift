import UIKit
import SpriteKit

class GameScene: SKScene {
    weak var viewController: GameController!
    
    var board : Board!
    var puck : Puck!
    var mallet : Mallet!
    
    override func didMoveToView(view: SKView) {
        
        let physics:physicsFactory = physicsFactory();
        physics.setPhys(self)
        let game = Game.instance
        game.initGame(self.frame)
        board = game.getBoard()
        
        let puck = game.getPuck()
        let mallet = game.getMallet()
        
        
        self.addChild(board.leftWall)
        self.addChild(board.rightWall)
        self.addChild(board.board)
        self.addChild(puck.puck)
        self.addChild(mallet.mallet)
        
        
        puck.puck.physicsBody!.applyImpulse(CGVectorMake(10, -40))
        print(puck.puck.physicsBody!.categoryBitMask)
        print(CollisionCategories.puckCol)
        print(mallet.mallet.physicsBody!.categoryBitMask)
        print(CollisionCategories.malCol)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        for touch in touches {
            let location = touch.locationInNode(self)
            if(nodeAtPoint(location).name == "mallet"){
                let touchedNode = nodeAtPoint(location)
                touchedNode.position = location
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact){
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        print("HEI")
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.malCol)){
            print("hei")
        }
        
    }
    override func update(currentTime: CFTimeInterval) {
    }
    
}