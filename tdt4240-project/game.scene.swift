import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewController: GameController!
    
    var board : Board!
    var puck: Puck!
    var playerOne : Player!
    var playerOneScore : SKLabelNode!
    var playerTwoScore : SKLabelNode!
    var playerTwo : Player!
    var direction : CGVector!
    var ai: AI!
    var updatesCalled = 0;
    var lastTouchedPuck : Player? // Who last touched the puck
    var powerUpsHandler : PowerUpController?
    
    override func didMoveToView(view: SKView) {
        powerUpsHandler = PowerUpController(gameScene: self)
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
        playerOneScore = board.bottomScore
        playerTwoScore = board.topScore
        self.addChild(board.leftWall)
        self.addChild(board.rightWall)
        self.addChild(board.topGoal)
        self.addChild(board.bottomGoal)
        self.addChild(board.board)
        self.addChild(puck)
        self.addChild(playerOne.getMallet())
        self.addChild(playerTwo.getMallet())
        self.addChild(playerOneScore);
        self.addChild(playerTwoScore);
        
    
        
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
        direction = CGVectorMake(250000*(CGSpeed*xOffset / vectorLen), 250000*(CGSpeed*yOffset / vectorLen))
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
        // points to player one
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.topCol)){
            playerOneScore.text = String(playerOne.addScore(puck.getPoints()))
            puckIsOffScreen()
        }
        // Points to player two
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.botCol)){
            playerTwoScore.text = String(playerTwo.addScore(puck.getPoints()))
            puckIsOffScreen()
        }
        
        // If puck touches powerup
        if((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.powerupCol)) {
            powerUpsHandler!.didGetCaught(lastTouchedPuck!)
        }
        
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.malCol)){
            //Save who last touched the puck
            lastTouchedPuck = secondBody.isEqual(playerTwo.getMallet().physicsBody) ? playerTwo : playerOne
            
            if ((playerTwo.getIsAi()) && secondBody.isEqual(playerTwo.getMallet().physicsBody)){
        
            } else{
                let impulse = SKAction.applyImpulse(direction, duration: 0.001)
                puck.runAction(impulse)
                //puck.physicsBody?.applyImpulse(direction)
                secondBody.velocity = CGVectorMake(0, 0)
            }
        }
    }
    
    func puckIsOffScreen() {
        let waitToRespawn = SKAction.waitForDuration(1)
        let remove = SKAction.hide()
        let show = SKAction.unhide()
        let moveBackx = SKAction.moveToX(self.frame.size.width/2, duration: 0)
        let moveBacky = SKAction.moveToY(self.frame.size.height/2, duration: 0)
        puck.runAction(SKAction.sequence([remove, waitToRespawn,moveBackx,moveBacky,show]))
    }
    
}


