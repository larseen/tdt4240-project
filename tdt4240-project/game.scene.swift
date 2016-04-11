import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewController: GameController!
    
    var board : Board!
    var puck: Puck!
    var mallet : Mallet!
    var direction : CGVector!
    
    override func didMoveToView(view: SKView) {
        
        let physics:physicsFactory = physicsFactory();
        physics.setPhys(self)
        let game = Game.instance
        game.initGame(self.frame)
        board = game.getBoard()
        physicsWorld.contactDelegate = self
        
        let puck = game.getPuck()
        let mallet = game.getMallet()
        
        
        self.addChild(board.leftWall)
        self.addChild(board.rightWall)
        self.addChild(board.board)
        self.addChild(puck)
        self.addChild(mallet)
        
        
        //puck.physicsBody!.applyImpulse(CGVectorMake(-1, 1))
        print(puck)
        print(puck.physicsBody!.categoryBitMask)
        print(CollisionCategories.puckCol)
        print(mallet.physicsBody!.categoryBitMask)
        print(CollisionCategories.malCol)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        var previousTimestamp = NSTimeInterval(0)
        for touch in touches {
            let location = touch.locationInNode(self)
            if(nodeAtPoint(location).name == "mallet"){
                let touchedNode = nodeAtPoint(location)
                touchedNode.position = location
                let oldPosition = touch.previousLocationInNode(touchedNode)
                let xOffset = location.x - oldPosition.x
                let yOffset = location.y - oldPosition.y
                let vectorLen = sqrt(xOffset * xOffset + yOffset * yOffset)
                let time = touch.timestamp - previousTimestamp
                
                print (vectorLen)
                print (time)
                
                let speed = Double(vectorLen) / time
                let CGSpeed = CGFloat(speed)
                print (speed)
                
                direction = CGVectorMake( 400*(CGSpeed*xOffset / vectorLen), 400*(CGSpeed*yOffset / vectorLen))
                print(direction)
                
                
                previousTimestamp = touch.timestamp
                
                
            }
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact){
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.malCol)){
            firstBody.applyImpulse(direction)
        }
        
    }
    override func update(currentTime: CFTimeInterval) {
    }
    
}