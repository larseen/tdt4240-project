//
//  board.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Board : SKSpriteNode {
    
    var board = SKSpriteNode(imageNamed: "Board")
    
    func get(width : CGFloat, height : CGFloat) -> SKSpriteNode{
        board.position = CGPointMake(width/2, height/2)
        return board;
    }
    

}