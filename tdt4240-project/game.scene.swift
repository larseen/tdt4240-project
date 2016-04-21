import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewController: GameController!
    
    var board : Board!
    var puck: Puck!
    var playerOne : Player!
    var playerTwo : Player!
    var direction : CGVector!
    var ai: AI!
    
    override func didMoveToView(view: SKView) {
        
        let physics:physicsFactory = physicsFactory();
        physicsWorld.contactDelegate = self
        physics.setPhys(self)
        ai = AI()
        
        
        let game = Game.instance
        game.initGame(self.frame)
        
        
        board = game.getBoard()
        puck = game.getPuck()
        if (game.getPlayers() == 2){
            playerOne = Player(id: 1, name: "Player One", isAI: false, color: "blue", homeGoal: "bottom")
            playerTwo = Player(id: 2, name: "Player Two", isAI: false, color: "red", homeGoal: "top")

        }
        else {
            playerOne = Player(id: 1, name: "Player One", isAI: false, color: "blue", homeGoal: "bottom")
            playerTwo = Player(id: 2, name: "Player Two", isAI: true, color: "red", homeGoal: "top")
            
        }
        
        self.addChild(board.leftWall)
        self.addChild(board.rightWall)
        self.addChild(board.topGoal)
        self.addChild(board.bottomGoal)
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
        //print("location: ", location)
        //print("old: ", oldPosition)
        let xOffset = oldPosition.x - location.x
        let yOffset = oldPosition.y - location.y
        let vectorLen = sqrt((xOffset * xOffset) + (yOffset * yOffset))
        let time = touch!.timestamp - previousTimestamp
        //print(time)
        
        
        let speed = (Double(vectorLen) / time) * 10
        let CGSpeed = CGFloat(speed)
        direction = CGVectorMake(25000*(CGSpeed*xOffset / vectorLen), 25000*(CGSpeed*yOffset / vectorLen))
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
    
    override func update(currentTime: NSTimeInterval) {
        puckIsOffScreen(puck)
        if (playerTwo.getIsAi()){
            let action = ai.newAction(playerTwo, playerPos: playerTwo.getMallet().position, puckPos: puck.position)
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
        
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.malCol)){
            
            if ((playerTwo.getIsAi()) && secondBody.isEqual(playerTwo.getMallet().physicsBody)){
                print("hei")
        
            }
            else{
                let impulse = SKAction.applyImpulse(direction, duration: 0.001)
                let waitToKnock = SKAction.waitForDuration(0.9)
                print (direction)
                puck.runAction(SKAction.sequence([impulse, waitToKnock]))
                secondBody.velocity = CGVectorMake(0, 0)
            }
        }
     
            
        
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.botCol)){
            playerOne.addScore(1)
            print(playerOne.getScore())
        }
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.topCol)){
            playerTwo.addScore(1)
            print(playerTwo.getScore())
        }
        
    }
    
    func puckIsOffScreen(node:SKSpriteNode){
        if (!CGRectContainsPoint(self.frame, CGPointMake(puck.frame.midX, puck.frame.minY + 10))){
            let waitToRespawn = SKAction.waitForDuration(1.5)
            let remove = SKAction.hide()
            let show = SKAction.unhide()
            let moveBackx = SKAction.moveToX(self.frame.size.width/2, duration: 0)
            let moveBacky = SKAction.moveToY(self.frame.size.height/2, duration: 0)
            puck.runAction(SKAction.sequence([waitToRespawn, remove]))
            puck.runAction(SKAction.sequence([waitToRespawn,moveBackx,moveBacky,show]))
            puck.physicsBody?.velocity = CGVectorMake(0, 0)
            
            
            
            
            
        }
    }
    

    
}