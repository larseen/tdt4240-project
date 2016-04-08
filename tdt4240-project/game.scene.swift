import UIKit
import SpriteKit

class GameScene: SKScene {
    weak var viewController: GameController!
    
    override func didMoveToView(view: SKView) {
        
        let game = Game.instance
        let board = game.getBoard(self.frame.size.width, height: self.frame.size.height)
        let puck = game.getPuck(self.frame.size.width, height: self.frame.size.height)
        let physics:physicsFactory = physicsFactory();
        board.size = self.frame.size
        
        self.addChild(board)
        self.addChild(puck)
        physics.setPhys(self)
        puck.physicsBody?.applyImpulse(CGVectorMake(30, -30))
        
        
    }
}