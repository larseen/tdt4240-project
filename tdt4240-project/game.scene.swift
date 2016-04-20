import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewController: GameController!
    
    var board : Board!
    var puck: Puck!
    var playerOne : Player!
    var playerTwo : Player!
    var direction : CGVector!
    
    override func didMoveToView(view: SKView) {
        
        let physics:physicsFactory = physicsFactory();
        physicsWorld.contactDelegate = self
        physics.setPhys(self)
        
        
        let game = Game.instance
        game.initGame(self.frame)
        
        
        board = game.getBoard()
        puck = game.getPuck()
        playerOne = Player(id: 1, name: "Player One", isAI: false, color: "blue")
        playerTwo = Player(id: 2, name: "Player Two", isAI: false, color: "red")
        
        self.addChild(board.leftWall)
        self.addChild(board.rightWall)
        self.addChild(board.board)
        self.addChild(puck)
        self.addChild(playerOne.getMallet())
        self.addChild(playerTwo.getMallet())
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        var previousTimestamp = NSTimeInterval(0)
        
        let touch = touches.first
        let location = touch!.locationInView(self.view)
        let oldPosition = touch!.previousLocationInView(self.view)
        print("location: ", location)
        print("old: ", oldPosition)
        let xOffset = oldPosition.x - location.x
        let yOffset = oldPosition.y - location.y
        let vectorLen = sqrt(xOffset * xOffset + yOffset * yOffset)
        let time = touch!.timestamp - previousTimestamp
        
        
        let speed = (5*Double(vectorLen) / time)
        let CGSpeed = CGFloat(speed)
        direction = CGVectorMake(5000*(CGSpeed*xOffset / vectorLen), 5000*(CGSpeed*yOffset / vectorLen))
        let directionPath = CGPathCreateMutable();
        CGPathMoveToPoint(directionPath, nil, oldPosition.x, oldPosition.y);
        CGPathAddLineToPoint(directionPath, nil, location.x, location.y);
        previousTimestamp = touch!.timestamp
        
        
        
        
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
    
}