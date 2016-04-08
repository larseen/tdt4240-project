import UIKit
import SpriteKit

class GameScene: SKScene {
    weak var viewController: GameController!
    
    override func didMoveToView(view: SKView) {
        
        let game = Game.instance
        let board = game.getBoard(self.frame.size.width, height: self.frame.size.height)
        board.size = self.frame.size
        self.addChild(board)

    }
}