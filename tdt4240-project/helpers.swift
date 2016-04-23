//
//  helpers.swift
//  tdt4240-project
//
//  Created by Anna Kastet on 22/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Helpers {
    class func getRandomPositionInFrame(frame: CGRect) -> CGPoint {
        let frameWidth = UInt32(frame.size.width)
        let frameHeight = UInt32(frame.size.height)
        let randomX = Int(arc4random_uniform(frameWidth))
        let randomY = Int(arc4random_uniform(frameHeight))
        return CGPoint(x: randomX, y: randomY)
    }
    
    class func getRandomIntBetween(from: Int, to: Int) -> Int {
        return from + Int(arc4random_uniform(UInt32(to - from)))
    }
}