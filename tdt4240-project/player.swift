
//
//  player.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 11.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//


import Foundation
import SpriteKit

class Player {
    
    /*
     *
     * PRIVATE VARIABLES
     *
     */
    private var mallet : Mallet
    private var ai : AI!
    private var id : Int
    private var name : String
    private var isAI : Bool
    private var color: String
    private var homeGoal: String
    private var scoreBoard: ScoreBoard
    
    // Score with observer
    private var score : Int = 0 {
        willSet(newScore) {
            // Called when score is updated
            scoreBoard.updateText(String(newScore))
        }
    }
    
    /*
     *
     * RESET / INIT FUNCTIONS
     *
     */
    
    init(id : Int, name : String, isAI : Bool, color: String, homeGoal: String, frame: CGRect) {
        self.id = id
        self.mallet = Mallet(color: color)
        self.name = name
        self.isAI = isAI || false
        self.color = color
        self.homeGoal = homeGoal
        if (isAI){
            mallet.name = "aiMallet"
            ai = AI()
        }
        let isTopPlayer = homeGoal == "top" ? true : false
        self.scoreBoard = ScoreBoard(frame: frame, isTopBoard: isTopPlayer)
    }
    
    
    func getMallet() -> Mallet {
        return mallet;
    }
    
    func addScore(value : Int) -> Int {
        score = score + value
        return score
    }
    
    func decreaseScore(value : Int) -> Int {
        score = score - value
        return score
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getHomeGoal() -> String {
        return homeGoal
    }
    
    func isAi() -> Bool{
        return isAI
    }
    
    func getAi() -> AI{
        return ai
    }
    

    func getScoreBoard() -> ScoreBoard {
        return scoreBoard
    }

}