//
//  scoreboard.swift
//  tdt4240-project
//
//  Created by Anna Kastet on 23/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class ScoreBoard: SKLabelNode {
    init(frame: CGRect, isTopBoard: Bool) {
        super.init()
        let width = frame.size.width
        let height = frame.size.height
        
        //Set the position of the scoreboard
        let pos = CGPointMake(-width/2, -height/2)
        self.position = CGPoint(x: pos.x + 40, y: pos.y + 10)
        
        if(isTopBoard) {
            self.zRotation = CGFloat(M_PI)
            self.position = CGPoint(x: pos.x + width - 40, y: pos.y + height - 10)
        }
        self.color = SKColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        self.text = "000"
    }
    
    func updateText(text: String) {
        self.text = String(count: 3 - text.characters.count, repeatedValue: Character("0")) + text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
