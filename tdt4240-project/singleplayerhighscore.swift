//
//  singleplayerhighscore.swift
//  tdt4240-project
//
//  Created by Elida Reknes on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//


import Foundation;

@ objc class SinglePlayerHighscoreList: NSObject, HighscoreList {
    var listName: String!
    var currentHighscores: [Highscore]!
    var highscoreThreshold: Int64
    var listLength: Int64
    var game1 = Highscore(score: 8000, name: "Me")
    var game2 = Highscore(score: 4000, name: "Trine")
    var game3 = Highscore(score: 6000, name: "")
    
    
    override init() {
        //FIX: laste opp fra local storage. Regne ut initial highscreThreshold.
        listLength=10 //default, any other wishes must be specified by calling changeListLength()
        listName = "Single Player Highscores"
        //self.currentHighscores = listFromStorage
        //if list in storage==0, set empty 10-item list
        highscoreThreshold = 0
        super.init()
        print(self)
        if let savedList = loadHighscoreList() {
            print ("saved")
            currentHighscores = savedList
        }
        else {
            self.currentHighscores = [Highscore]()}
        // self.currentHighscores=[Highscore?](count: self.listLength, repeatedValue: nil)}*/
        updateHighscores(game1)
        updateHighscores(game2)
        updateHighscores(game3)
        self.highscoreThreshold = updateHighscoreThreshold();
        
        //self.highscoreThreshold = highscoreThreshold //Regnes utifra listen fra storage
    }
    
    func updateHighscores(newHighscore: Highscore) {
        
        currentHighscores.append(newHighscore)
        currentHighscores = currentHighscores.sort({game1, game2 in return game1.score>game2.score})
        if (Int64(currentHighscores.count) > listLength) {
            currentHighscores.removeLast()}
        updateHighscoreThreshold() }
    
    func changeListLength(newLength: Int64) {
        self.listLength=newLength
        //  var range = Range<Int>(start: 0, end: listLength)
        while (Int64(currentHighscores.count) > listLength) {
            currentHighscores.removeLast()
        }
        // saveHighscoreList()
        updateHighscoreThreshold()
    }
    
    func updateHighscoreThreshold() -> Int64 {
        if (Int64(currentHighscores.count) < listLength ){
            return 0
        }
        else {
            var lowestScore: Int64
            lowestScore = 99999999
            for highscore in currentHighscores {
                if Int64(highscore.score) < Int64(lowestScore) {
                    lowestScore = Int64(highscore.score)}
            }
            return lowestScore}
    }
    
    func getCurrentHighscores() -> [Highscore] { //return list only containing !nil-objects
        print(currentHighscores, "here")
        //let peesAsArrayP: [P] = pees.map{$0 as P}
        let asArray: [Highscore] = currentHighscores.map{$0 as Highscore}
        print ("attempt", asArray,asArray.dynamicType )
        return asArray //currentHighscores//.filter{$0 != nil}
    }
    
    func clearHighscoreList () {
        currentHighscores=[]
        //        saveHighscoreList()
        updateHighscoreThreshold()
    }
    
    func getListName() -> String {
        return listName
    }
    
    func getHighscoreThreshold() -> Int64 {
        return highscoreThreshold
    }
    
    // MARK: NSCoding
    
    func saveHighscoreList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(currentHighscores, toFile: Highscore.ArchiveURL.path!)
        if !isSuccessfulSave {
            "Save failed"
        }
    }
    
    func loadHighscoreList() -> [Highscore]? {
        print (NSKeyedUnarchiver.unarchiveObjectWithFile(Highscore.ArchiveURL.path!) as? [Highscore], "this")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Highscore.ArchiveURL.path!) as? [Highscore]
    }
    
}