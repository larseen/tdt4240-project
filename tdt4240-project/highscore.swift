//
//  highscore.swift
//  tdt4240-project
//
//  Created by Elida Reknes on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//
import UIKit

struct Highscore {
    let score: Int64!
    let date: NSDate!
    let name: String!
    
    init(score: Int64, name: String){
        self.score=score
        self.name=name
        self.date=NSDate()
    }
    
    func getScore() -> Int64 {
        return  score
    }
    
    func getName() -> String{
        return name
    }
}