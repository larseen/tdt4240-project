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
    
    let score: Int64!
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
    
    init(score: Int64, name: String){
        self.score=score
        self.name=name
        self.date=NSDate()
    }
    
    init?(score: Int64, name: String, date: NSDate) {
        self.score=score
        self.name=name
        self.date=date
    }
    
    
    func getScore() -> Int64 {
        return  score
    }
    
    func getName() -> String {
        return name
    }
    func getDate() -> NSDate {
        return date
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt64(score, forKey: PropertyKey.scoreKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let score = aDecoder.decodeObjectForKey(PropertyKey.scoreKey) as! Int64
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        self.init(score: score, name: name, date: date) //samme som super.init() uten convenience?
    }
    
}