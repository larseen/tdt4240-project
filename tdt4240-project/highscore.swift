//
//  highscore.swift
//  tdt4240-project
//
//  Created by Elida Reknes on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//
import UIKit

class Highscore: NSObject, NSCoding {
    // MARK: Properties
    
    let score: Int!
    let date: NSDate!
    let name: String!
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("highscores")
    
    // MARK: Types
    
    struct PropertyKey {
        static let scoreKey = "score"
        static let dateKey = "date"
        static let nameKey = "name"
    }
    
    // MARK: Initialization
    
    init(score: Int, name: String){
        self.score = score
        self.name = name
        self.date = NSDate()
    }
    
    func getScore() -> Int {
        return  score
    }
    
    func getName() -> String {
        return name
    }
    func getDate() -> NSDate {
        return date
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        print ( aCoder.encodeInteger(score, forKey: PropertyKey.scoreKey))
        aCoder.encodeInteger(score, forKey: PropertyKey.scoreKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let score = aDecoder.decodeIntegerForKey(PropertyKey.scoreKey)
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
            self.init(score: score, name: name)
    
    }
    
}