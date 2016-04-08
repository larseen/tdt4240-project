import UIKit
import SpriteKit

class GameScene: SKScene {
    weak var viewController: GameController!
    
    var board : Board!
    
    override func didMoveToView(view: SKView) {
        
        let physics:physicsFactory = physicsFactory();
        physics.setPhys(self)
        let game = Game.instance
        game.initGame(self.frame)
        board = game.getBoard()
        
        let puck = game.getPuck(self.frame.size.width, height: self.frame.size.height)
        let mallet = game.getMallet(self.frame.size.width, height: self.frame.size.height)
        
        
        self.addChild(board.leftWall)
        self.addChild(board.rightWall)
        self.addChild(board.board)
        self.addChild(puck)
        self.addChild(mallet)
        
        puck.physicsBody?.applyImpulse(CGVectorMake(30, -30))
        
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
    
}