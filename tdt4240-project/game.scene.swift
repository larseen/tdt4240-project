import UIKit
import SpriteKit
import Darwin

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewController: GameController!
    
    var board : Board!
    var puck: Puck!
    var mallet : Mallet!
    var direction : CGVector!
    var count = 0
    
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

        
        
        
        
        for touch in touches {
            var location = touch.locationInNode(self)
            if(nodeAtPoint(location).name == "mallet"){
                let touchedNode = nodeAtPoint(location)
                touchedNode.position = location
                var previousTimestamp = NSTimeInterval(0)
                
                let oldPosition = touch.previousLocationInNode(self)
                let xOffset = oldPosition.x - location.x
                let yOffset = oldPosition.y - location.y
                let vectorLen = sqrt(xOffset * xOffset + yOffset * yOffset)
                let time = touch.timestamp - previousTimestamp
                
                
                let speed = (5*Double(vectorLen) / time)
                let CGSpeed = CGFloat(speed)
                direction = CGVectorMake(15000*(CGSpeed*xOffset / vectorLen), 15000*(CGSpeed*yOffset / vectorLen))
                
                /*let directionPath = CGPathCreateMutable();
                CGPathMoveToPoint(directionPath, nil, location.x, location.y);
                CGPathAddLineToPoint(directionPath, nil, oldPosition.x, oldPosition.y);
                var directionPathNode = SKShapeNode(path: directionPath)
                directionPathNode.lineWidth = 5;
                directionPathNode.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
                self.addChild(directionPathNode)*/
                
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
                print(direction)
                firstBody.applyImpulse(direction)
                secondBody.dynamic = false
                delay(1){
                    secondBody.dynamic = true
                }
                
            }
        }
    
    
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    

    
}