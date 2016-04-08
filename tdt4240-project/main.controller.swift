//
//  main.controller.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import UIKit
import SpriteKit


class MainController: UIViewController {
    
    @IBOutlet weak var numPlayers: UILabel!
    var newGame : Game! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame = Game.instance
        newGame.reset()
        numPlayers.text = String(newGame.getPlayers())
    }
   
    @IBAction func addPlayer(sender: AnyObject) {
        numPlayers.text = String(newGame.addPlayer())
    }
    
    @IBAction func removePlayer(sender: AnyObject) {
         numPlayers.text = String(newGame.removePlayer())
    }
    @IBAction func toogleSound(sender: AnyObject) {
        if(statusBackgroundMusic()){
            stopBackgroundMusic()
        }else{
            playBackgroundMusic()
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}