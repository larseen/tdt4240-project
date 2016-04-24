//
//  main.controller.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import UIKit
import SpriteKit


class GameController: UIViewController {
    
    @IBOutlet weak var numPlayers: UILabel!
    var game : Game! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game.instance
        print(game)
        let scene = GameScene(size: view.bounds.size)
        scene.viewController = self
        let skView = self.view as! SKView
        skView.presentScene(scene)
    }
}