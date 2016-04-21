//
//  board.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Board : SKSpriteNode,SKPhysicsContactDelegate {
    
    var board = SKSpriteNode(imageNamed: "Board")
    var leftWall : SKShapeNode!
    var rightWall : SKShapeNode!
    var topGoal : SKShapeNode!
    var bottomGoal: SKShapeNode!
    let x = CGFloat(60)
    let w = CGFloat(4)
    
    func createLeftWall(width : CGFloat, height : CGFloat) {
        let wallLeft = CGPathCreateMutable();
        CGPathMoveToPoint(wallLeft, nil, CGFloat(width/2-x), CGFloat(height));
        CGPathAddLineToPoint(wallLeft, nil, CGFloat(0), CGFloat(height));
        CGPathAddLineToPoint(wallLeft, nil, CGFloat(0), CGFloat(0));
        CGPathAddLineToPoint(wallLeft, nil, CGFloat(width / 2 - x), CGFloat(0));
        
        CGPathAddLineToPoint(wallLeft, nil, CGFloat(width / 2 - x), w);
        CGPathAddLineToPoint(wallLeft, nil, w, w);
        CGPathAddLineToPoint(wallLeft, nil, w, CGFloat(height) - w);
        CGPathAddLineToPoint(wallLeft, nil, CGFloat(width/2-x), CGFloat(height) - w);
        
        CGPathCloseSubpath(wallLeft);
        leftWall = SKShapeNode(path: wallLeft)
        leftWall.fillColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
        leftWall.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
        leftWall.position = CGPointMake(0, 0)
        leftWall.physicsBody?.restitution = 1
        leftWall.physicsBody = SKPhysicsBody(edgeChainFromPath: wallLeft)
        leftWall.zPosition = 0
    }
    
    func createRightWall(width : CGFloat, height : CGFloat) {
        let wallRight = CGPathCreateMutable();
        CGPathMoveToPoint(wallRight, nil, CGFloat(width/2+x), CGFloat(height));
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width), CGFloat(height));
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width), CGFloat(0));
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width / 2 + x), CGFloat(0));
        
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width / 2 + x), w);
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width) - w, w);
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width) - w, CGFloat(height) - w);
        CGPathAddLineToPoint(wallRight, nil, CGFloat(width/2 + x), CGFloat(height) - w);
        CGPathCloseSubpath(wallRight);
        rightWall = SKShapeNode(path: wallRight)
        rightWall.fillColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
        rightWall.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
        rightWall.position = CGPointMake(0, 0)
        rightWall.physicsBody?.restitution = 1
        rightWall.physicsBody = SKPhysicsBody(edgeChainFromPath: wallRight)
        rightWall.zPosition = 0
    }
    
    func createTopGoal(width : CGFloat, height : CGFloat){
    
        let goalTop = CGPathCreateMutable();
        
        CGPathMoveToPoint(goalTop, nil, CGFloat(width/2-x), CGFloat(height));
        CGPathAddLineToPoint(goalTop, nil, CGFloat(width/2+x), CGFloat(height));
        CGPathAddLineToPoint(goalTop, nil, CGFloat(width/2+x), CGFloat(height)-w);
        CGPathAddLineToPoint(goalTop, nil, CGFloat(width/2-x), CGFloat(height)-w);
        CGPathCloseSubpath(goalTop);
        topGoal = SKShapeNode(path: goalTop)
        topGoal.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0)
        topGoal.position = CGPointMake(0, 0)
        topGoal.physicsBody?.restitution = 0
        topGoal.physicsBody?.categoryBitMask = CollisionCategories.topCol
        topGoal.physicsBody?.collisionBitMask = CollisionCategories.puckCol
        topGoal.zPosition = 0
        print(topGoal.physicsBody?.categoryBitMask)
    }
    
    func createBottomGoal(width : CGFloat, height : CGFloat){
        
        let goalBottom = CGPathCreateMutable();
        
        CGPathMoveToPoint(goalBottom, nil, CGFloat(width/2-x), CGFloat(0));
        CGPathAddLineToPoint(goalBottom, nil, CGFloat(width/2+x), CGFloat(0));
        CGPathAddLineToPoint(goalBottom, nil, CGFloat(width/2+x), CGFloat(w));
        CGPathAddLineToPoint(goalBottom, nil, CGFloat(width/2-x), CGFloat(w));
        CGPathCloseSubpath(goalBottom);
        bottomGoal = SKShapeNode(path: goalBottom)
        bottomGoal.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0)
        bottomGoal.position = CGPointMake(0, 0)
        bottomGoal.physicsBody?.restitution = 0
        bottomGoal.physicsBody?.categoryBitMask = CollisionCategories.botCol
        bottomGoal.physicsBody?.collisionBitMask = CollisionCategories.puckCol
        print(bottomGoal.physicsBody?.categoryBitMask)
        bottomGoal.zPosition = 0
    }
    
    func initialize (frame: CGRect) {
        createLeftWall(frame.size.width, height: frame.size.height)
        createRightWall(frame.size.width, height: frame.size.height)
        createBottomGoal(frame.size.width, height: frame.size.height)
        createTopGoal(frame.size.width, height: frame.size.height)
        board.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        board.size = frame.size
        board.zPosition = -1
    }
    
    

}
