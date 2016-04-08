import UIKit
import SpriteKit

class GameScene: SKScene {
    weak var viewController: GameController!
    
    override func didMoveToView(view: SKView) {
        let settingsLabel = SKLabelNode(fontNamed:"Helvetica")
        settingsLabel.text = "Settings"
        settingsLabel.fontSize = 35
        settingsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetHeight(self.frame)*4/5)
        let game = Game.instance
      //  let board = game.getBoard(CGRectGetMaxY(self.frame), height: CGRectGetMaxX(self.frame))
        let puck = game.getPuck(self.frame.size.width, height: self.frame.size.height)
      //  self.addChild(board)
        self.addChild(settingsLabel)
        self.addChild(puck)
    }
}