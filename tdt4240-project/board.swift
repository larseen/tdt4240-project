//
//  board.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

class Board : SKSpriteNode,SKPhysicsContactDelegate {
    
    private var board = SKSpriteNode(imageNamed: "Board")
    private var leftWall : SKShapeNode!
    private var rightWall : SKShapeNode!
    private var topGoal : SKShapeNode!
    private var bottomGoal: SKShapeNode!
    private let x = CGFloat(60)
    private let w = CGFloat(4)
    
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
        leftWall.fillColor = SKColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        leftWall.strokeColor = SKColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        leftWall.position = CGPointMake(-width/2, -height/2)
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
        rightWall.fillColor = SKColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        rightWall.strokeColor = SKColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        rightWall.position = CGPointMake(-width/2, -height/2)
        rightWall.physicsBody?.restitution = 1
        rightWall.physicsBody = SKPhysicsBody(edgeChainFromPath: wallRight)
        rightWall.zPosition = 0
    }
    
    func createTopGoal(width : CGFloat, height : CGFloat){
    
        let goalTop = CGPathCreateMutable();
        
        CGPathMoveToPoint(goalTop, nil, CGFloat(0), CGFloat(height+100));
        CGPathAddLineToPoint(goalTop, nil, CGFloat(width), CGFloat(height+100));
        CGPathCloseSubpath(goalTop);
        topGoal = SKShapeNode(path: goalTop)
        topGoal.physicsBody = SKPhysicsBody(edgeChainFromPath: goalTop)
        topGoal.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
        topGoal.position = CGPointMake(-width/2, -height/2)
        topGoal.physicsBody?.restitution = 0
        topGoal.physicsBody?.categoryBitMask = CollisionCategories.topCol
        topGoal.physicsBody?.contactTestBitMask = CollisionCategories.puckCol
        topGoal.physicsBody?.collisionBitMask = CollisionCategories.malCol
        topGoal.zPosition = 0
    }
    
    func createBottomGoal(width : CGFloat, height : CGFloat){
        
        let goalBottom = CGPathCreateMutable();
        
        CGPathMoveToPoint(goalBottom, nil, CGFloat(0), CGFloat(-100));
        CGPathAddLineToPoint(goalBottom, nil, CGFloat(width), CGFloat(-100));
        CGPathCloseSubpath(goalBottom);
        bottomGoal = SKShapeNode(path: goalBottom)
        bottomGoal.strokeColor = SKColor(colorLiteralRed: 255, green: 0, blue: 0, alpha: 1)
        bottomGoal.position = CGPointMake(-width/2, -height/2)
        bottomGoal.physicsBody = SKPhysicsBody(edgeChainFromPath: goalBottom)
        bottomGoal.physicsBody?.restitution = 0
        bottomGoal.physicsBody?.categoryBitMask = CollisionCategories.botCol
        bottomGoal.physicsBody?.contactTestBitMask = CollisionCategories.puckCol
        bottomGoal.physicsBody?.collisionBitMask = CollisionCategories.malCol
        bottomGoal.zPosition = 0
    }
    
    func initialize (frame: CGRect) {
        createLeftWall(frame.size.width, height: frame.size.height)
        createRightWall(frame.size.width, height: frame.size.height)
        createBottomGoal(frame.size.width, height: frame.size.height)
        createTopGoal(frame.size.width, height: frame.size.height)
        board.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        board.size = frame.size
        board.zPosition = -10
        
        board.addChild(leftWall)
        board.addChild(rightWall)
        board.addChild(topGoal)
        board.addChild(bottomGoal)
    }
    
    func getBoard() -> SKSpriteNode {
        return self.board
    }
}
