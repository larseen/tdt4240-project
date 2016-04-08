//
//  singleplayerhighscore.swift
//  tdt4240-project
//
//  Created by Elida Reknes on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//


//må kanskje egentlig hentes ut fra og lagres til local storage.
class SinglePlayerHighscoreList: HighscoreList {
    var listName: String!
    var currentHighscores: [Highscore?]!
    var highscoreThreshold: Int64!  //vil hente ut highscorelist i framtiden.
    var listLength: Int!
    var game1 = Highscore(score: 8000, name: "Me")
    var game2 = Highscore(score: 4000, name: "Trine")
    var game3 = Highscore(score: 6000, name: "")

    
    init() {
        //FIX: laste opp fra local storage. Regne ut initial highscreThreshold.
        print("party")
        listLength=2
        self.listName = "Single Player Highscores"
        //self.currentHighscores = listFromStorage
        self.currentHighscores=[Highscore?](count: self.listLength, repeatedValue: nil)//trenger ikke å gjøres om vi har en liste med highscores i lager. Men den må lagres til å begynne med. Confused.
        updateHighscores(game1)
        print(currentHighscores)
        print(highscoreThreshold)
        updateHighscores(game2)
        print(currentHighscores)
        print(highscoreThreshold)
        updateHighscores(game3)
        print(currentHighscores)
        print(highscoreThreshold)
        updateHighscoreThreshold();
        //self.highscoreThreshold = highscoreThreshold //Regnes utifra listen fra storage
    }
    
    func updateHighscores(newHighscore: Highscore) {
        
        currentHighscores.insert(newHighscore, atIndex: listLength-1)
        currentHighscores.removeAtIndex(listLength)
        currentHighscores = currentHighscores.sort({game1, game2 in return game1?.score>game2?.score})
        updateHighscoreThreshold() }

    func changeListLength(newLength: Int) {
        self.listLength=newLength
    }
    
    func updateHighscoreThreshold() {
        if ((currentHighscores.last! != Optional(nil)!)) {
            print ((currentHighscores.last! == Optional(nil)!))
        var lowestScore: Int64
        lowestScore = 10000000000000
        for highscore in currentHighscores {
            if highscore != nil {
            if highscore!.score < lowestScore {
                lowestScore = highscore!.score
                } }
            else {
                break
            }
            self.highscoreThreshold=lowestScore}}
        else {
            highscoreThreshold=0
        }
    }
    
    func getCurrentHighscores() -> [Highscore?]{
        return currentHighscores
    }
    
    func clearHighscoreList () {
        self.currentHighscores=[Highscore?](count: self.listLength, repeatedValue: nil)
    }
    
    func getListName() -> String {
        return listName
    }
    
    func getHighscoreThreshold() -> Int64 {
        return highscoreThreshold
    }
    
    
    
}