
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
    private var id : Int
    private var name : String
    private var isAI : Bool
    private var score : Int
    private var color: String
    private var homeGoal: String
    
    
    /*
     *
     * RESET / INIT FUNCTIONS
     *
     */
    
    init(id : Int, name : String, isAI : Bool, color: String, homeGoal: String) {
        self.id = id
        self.mallet = Mallet(color: color)
        self.name = name
        self.score = 0
        self.isAI = isAI || false
        self.color = color
        self.homeGoal = homeGoal
        if (isAI){
            mallet.name = "aiMallet"
        }
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
    func getIsAi() -> Bool{
        return isAI
        
    }
    
    
    
}