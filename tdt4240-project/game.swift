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
    private var playerTwo : Player!
    private var playerOne : Player!
    private var board = Board()
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
        if (self.getPlayers() == 2){
            playerOne = Player(id: 1, name: "Player One", isAI: false, color: "blue", homeGoal: "bottom")
            playerTwo = Player(id: 2, name: "Player Two", isAI: false, color: "red", homeGoal: "top")
            
        } else {
            playerOne = Player(id: 1, name: "Player One", isAI: false, color: "blue", homeGoal: "bottom")
            playerTwo = Player(id: 2, name: "Player Two", isAI: true, color: "red", homeGoal: "top")
            
        }
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
    
    func getPlayerOne() -> Player {
        return playerOne
    }
    
    func getPlayerTwo() -> Player {
        return playerTwo
    }
    
    func getBoard() -> Board {
        return board
    }

    func getPuck() -> Puck {
        return puck
    }
}
