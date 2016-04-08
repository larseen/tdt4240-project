//
//  game.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import Foundation
import SpriteKit

class Game {
    
    /*
     *
     * PRIVATE VARIABLES
     *
     */
    
    static let instance = Game()
    private var numPlayers = 1
    private var maxPlayers = 2
    private var minPlayers = 1
    private var board = Board()
    private var pukk = puck()
    
    
    /*
     *
     * RESET / INIT FUNCTIONS
     *
     */
    
    private init() {
        numPlayers = 1;
    }
    
    func reset() {
        numPlayers = 1
    }
    
    /*
     *
     * PLAYER FUNCTIONS
     *
     */
    
    func addPlayer() -> Int {
        if(numPlayers + 1 > 2){
            return numPlayers
        } else {
            numPlayers += 1
            return numPlayers
        }
    }
    
    func removePlayer() -> Int {
        if(numPlayers - 1 < 1){
            return numPlayers
        } else {
            numPlayers -= 1
            return numPlayers
        }
        
    }
    
    func getPlayers() -> Int {
        return numPlayers
    }
    
    
    func getBoard(width : CGFloat, height : CGFloat) -> SKSpriteNode {
        let boardSprite = board.get(width, height: height)
        return boardSprite
    }
    func getPuck(width : CGFloat, height : CGFloat) -> SKSpriteNode {
        let puckSprite = pukk.get(width, height: height)
        return puckSprite
    }

    
    
}
