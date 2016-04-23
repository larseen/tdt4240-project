import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewController: GameController!
    
    var board : Board!
    var puck: Puck!
    var playerOne : Player!
    var playerTwo : Player!
    var powerUpsHandler : PowerUpController?
    
    override func didMoveToView(view: SKView) {
        powerUpsHandler = PowerUpController(gameScene: self)
        let physics:physicsFactory = physicsFactory();
        physicsWorld.contactDelegate = self
        physics.setPhys(self)
        let game = Game.instance
        game.initGame(self.frame)
        
        board = game.getBoard()
        puck = game.getPuck()
        playerOne = game.getPlayerOne()
        playerTwo = game.getPlayerTwo()

        self.addChild(board.board)
        self.addChild(puck)
        self.addChild(playerOne.getMallet())
        self.addChild(playerTwo.getMallet())
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        var previousTimestamp = NSTimeInterval(0)
        let touch = touches.first
        let location = touch!.locationInNode(self)
        let oldPosition = touch!.previousLocationInNode(self)
        let xOffset = oldPosition.x - location.x
        let yOffset = oldPosition.y - location.y
        let vectorLen = sqrt((xOffset * xOffset) + (yOffset * yOffset))
        let time = touch!.timestamp - previousTimestamp
        let speed = (Double(vectorLen) / time)
        let CGSpeed = CGFloat(speed)
        puck.updateDirection(CGVectorMake(250000*(CGSpeed*xOffset / vectorLen), 250000*(CGSpeed*yOffset / vectorLen)))
        previousTimestamp = touch!.timestamp
        
        for touch in touches {
            let location = touch.locationInNode(self)
            if(nodeAtPoint(location).name == "mallet"){
                let touchedNode = nodeAtPoint(location)
                touchedNode.position = location
            }
            
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        if (playerTwo.isAi()){
            let action = playerTwo.getAi().newAction(playerTwo, playerPos: playerTwo.getMallet().position, puckPos: puck.position)
            playerTwo.getMallet().runAction(action)
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
        
        // points to player one
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.topCol)){
            board.updateBottomText(String(playerOne.addScore(puck.getPoints())))
            puck.reset()
        }
        // Points to player two
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.botCol)){
            board.updateTopText(String(playerTwo.addScore(puck.getPoints())))
            puck.reset()
        }
        
        // If puck touches powerup
        if((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.powerupCol)) {
            powerUpsHandler!.didGetCaught(puck.getLastTouched())
        }
        
        // mallet touches puck
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.malCol)){
            //Save who last touched the puck
            puck.touched(secondBody.isEqual(playerTwo.getMallet().physicsBody) ? playerTwo : playerOne)
            
            // Trying on some physics
            if ((playerTwo.isAi()) && secondBody.isEqual(playerTwo.getMallet().physicsBody)){
        
            } else{
                puck.hit()
                secondBody.velocity = CGVectorMake(0, 0)
            }
        }
    }
}


