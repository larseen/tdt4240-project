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
        var isAi = true
        if (self.getPlayers() == 2){
            isAi = false
        }
        playerOne = Player(id: 1, name: "Player One", isAI: false, color: "blue", homeGoal: "bottom", frame: frame)
        playerTwo = Player(id: 2, name: "Player Two", isAI: isAi, color: "red", homeGoal: "top", frame: frame)
        
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
    

    func limitMovement(){
        playerOne.getMallet().constraints = [SKConstraint.positionY(SKRange(lowerLimit: 0, upperLimit: self.getBoard().board.frame.height/2))]
        playerOne.getMallet().position = CGPoint(x: self.getBoard().board.frame.width/2, y: self.getBoard().board.frame.height/4)
        playerTwo.getMallet().constraints = [SKConstraint.positionY(SKRange(lowerLimit: self.getBoard().board.frame.height/2, upperLimit: self.getBoard().board.frame.height))]
        playerTwo.getMallet().position = CGPoint(x: self.getBoard().board.frame.width/2, y: self.getBoard().board.frame.height*3/4)
        
    }
   

    func getScoreBoard(player: Player) -> ScoreBoard {
        return player.getScoreBoard()
    }
}
