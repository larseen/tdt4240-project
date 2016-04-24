//
//  highscoreprotocol.swift
//  tdt4240-project
//
//  Created by Elida Reknes on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import Foundation

protocol HighscoreList {
    // currentHighscores - liste av highscoreobjekter på max 10
    var currentHighscores: [Highscore]! {get set}
    var listName: String! {get}
    var highscoreThreshold: Int {get set}
    var listLength: Int {get set}
    
    func updateHighscores(highscore: Highscore)
    func updateHighscoreThreshold() -> Int
    func clearHighscoreList()
    func getCurrentHighscores() -> [Highscore]
    func getHighscoreThreshold() -> Int
    func getListName() -> String
    
    
    //
    
}