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
    private var mallet = Mallet(color: "red")
    private var puck = Puck()
    
    
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
    
    func initGame(frame : CGRect) {
        board.initialize(frame)
        puck.setPos(frame)
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
    
    func getBoard() -> Board {
        return board
    }

    func getPuck() -> Puck {
        return puck
    }
    
    func getMallet() -> Mallet {
        return mallet
    }

    
    
}
