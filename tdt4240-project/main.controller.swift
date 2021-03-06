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
    let music = getMusicInstance()
    
    @IBOutlet weak var numPlayers: UILabel!
    var newGame : Game! = nil
    @IBOutlet weak var gameMode: UILabel!
    
    
    @IBAction func changeGameMode(sender: UIButton) {
        gameMode.text = newGame.changeGameMode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame = Game.instance
        newGame.reset()
        numPlayers.text = String(newGame.getPlayers())
        gameMode.text = String(newGame.getGameModeString())
    }
   
    @IBAction func addPlayer(sender: AnyObject) {
        numPlayers.text = String(newGame.addPlayer())

    }
    
    @IBAction func removePlayer(sender: AnyObject) {
         numPlayers.text = String(newGame.removePlayer())
    }
    @IBAction func toogleSound(sender: AnyObject) {
        if(music.statusBackgroundMusic()){
            music.stopBackgroundMusic()
        }else{
            music.playBackgroundMusic()
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