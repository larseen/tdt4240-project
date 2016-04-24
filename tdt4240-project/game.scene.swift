import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var viewController: UIViewController!
    
    var board : Board!
    var puck: Puck!
    var playerOne : Player!
    var playerTwo : Player!
    
    var pauseButton : UIButton! = nil
    var exitButton : UIButton! = nil
    var storyBoard : UIStoryboard! = nil
    var game : Game! = nil
    var previousTimestamp : Double = 0.0
    
    var powerUpsHandler : PowerUpController?
    
    
    override func didMoveToView(view: SKView) {
        powerUpsHandler = PowerUpController(gameScene: self)
        physicsWorld.contactDelegate = self
        self.view?.multipleTouchEnabled = true
        
        
        Helpers.setPhys(self)
        
        
        
        
        
        game = Game.instance
        
        game.initGame(self.frame)
        
        board = game.getBoard()
        puck = game.getPuck()
        playerOne = game.getPlayerOne()
        playerTwo = game.getPlayerTwo()
        
        self.addChild(board.board)
        self.addChild(puck)
        self.addChild(playerOne.getMallet())
        self.addChild(playerTwo.getMallet())
        self.addChild(playerOne.getScoreBoard())
        self.addChild(playerTwo.getScoreBoard())
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(GameScene.pause(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view?.addGestureRecognizer(doubleTap)
        
        // Listen for game over-notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(gameOver), name: GAME_OVER, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(timeOutGameOver), name: TIME_OUT, object: nil)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        let touch = touches.first
        let location = touch!.locationInView(self.view)
        let oldPosition = touch!.previousLocationInView(self.view)
        let xOffset = oldPosition.x - location.x
        let yOffset = oldPosition.y - location.y
        let vectorLen = sqrt((xOffset * xOffset) + (yOffset * yOffset))
        let time = touch!.timestamp - previousTimestamp
        let speed = 0.01 * Double(vectorLen) / time
        let CGSpeed = CGFloat(speed)
        puck.updateDirection(CGVectorMake(CGSpeed*xOffset / vectorLen, CGSpeed*yOffset / vectorLen))
        previousTimestamp = touch!.timestamp
        
        
        for touch in touches {
            if (self.paused){
                return
            }
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
            playerOne.addScore(puck.getPoints())
            puck.reset()
        }
        // Points to player two
        if ((firstBody.categoryBitMask == CollisionCategories.puckCol) && (secondBody.categoryBitMask == CollisionCategories.botCol)){
            playerTwo.addScore(puck.getPoints())
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
    
    
    func pause(sender: UITapGestureRecognizer){
        if (!self.paused){
            self.paused = true;
            pauseButton   = UIButton(type: UIButtonType.RoundedRect) as UIButton
            pauseButton.frame = CGRectMake((self.frame.size.width/2) - 60, 140, 125, 50)
            pauseButton.backgroundColor = UIColor.clearColor()
            pauseButton.setTitle("Unpause", forState: UIControlState.Normal)
            pauseButton.titleLabel?.font = UIFont(name: "helvetica", size: 25)
            pauseButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            exitButton   = UIButton(type: UIButtonType.RoundedRect) as UIButton
            exitButton.frame = CGRectMake((self.frame.size.width/2) - 60, 200, 125, 50)
            exitButton.backgroundColor = UIColor.clearColor()
            exitButton.setTitle("Exit", forState: UIControlState.Normal)
            exitButton.titleLabel?.font = UIFont(name: "helvetica", size: 25)
            exitButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            pauseButton.addTarget(self, action: #selector(GameScene.unpause(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            exitButton.addTarget(self, action: #selector(GameScene.exitPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view!.addSubview(pauseButton)
            self.view!.addSubview(exitButton)
            self.powerUpsHandler?.pause()
        }
        
    }
    
    func exitPressed(sender:UIButton!){
        puck.parent?.removeAllChildren()
        exitButton.removeFromSuperview()
        pauseButton.removeFromSuperview()
        self.viewController.performSegueWithIdentifier("moveToMain", sender: viewController)
    }
    
    
    func unpause(sender:UIButton!){
        self.paused = false;
        exitButton.removeFromSuperview()
        pauseButton.removeFromSuperview()
        self.powerUpsHandler?.resume()
    }
    
    // Called when game is over
    @objc func gameOver(notification: NSNotification) {
        // End game here
        if(game.getGameMode() == GameMode.GoalBased) {
            let _winner = notification.userInfo!["winner"] as! Player
            game.setWinner(_winner)
            self.viewController.performSegueWithIdentifier("moveToHighscore", sender: viewController)
        }
    }
    
    @objc func timeOutGameOver(notification: NSNotification) {
        // End time based game here
        let _winner = playerOne.getScore() > playerTwo.getScore() ? playerOne : playerTwo
        game.setWinner(_winner)
        self.viewController.performSegueWithIdentifier("moveToHighscore", sender: viewController)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


