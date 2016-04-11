//
//  main.controller.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import UIKit
import SpriteKit


class SettingsController: UIViewController {
    
    let music = getMusicInstance()
    @IBOutlet weak var statusMusic: UISwitch!
    @IBOutlet weak var clearHighscoreButton: UIButton!
    var clearHighscoresHasBeenTapped = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(music.statusBackgroundMusic()){
            statusMusic.setOn(true, animated:true)
        }else{
            statusMusic.setOn(false, animated:true)
        }
    }
    
    @IBAction func clearHighscoresTapped(sender: UIButton) {
        if(clearHighscoresHasBeenTapped) {
            let shp = SinglePlayerHighscoreList()
            shp.clearHighscoreList()
            clearHighscoreButton.setTitle("Highscores cleared", forState: UIControlState())
            clearHighscoreButton.setTitleColor(UIColor.grayColor(), forState: UIControlState())
            clearHighscoreButton.enabled = false

        }
        else {
            clearHighscoresHasBeenTapped = true;
            clearHighscoreButton.setTitle("You sure?", forState: UIControlState())
            clearHighscoreButton.setTitleColor(UIColor.redColor(), forState: UIControlState())
        }
    }
    
    @IBAction func toggleMusic(sender: AnyObject) {
        if(music.statusBackgroundMusic()){
            music.stopBackgroundMusic()
        }else{
            music.playBackgroundMusic()
        }
    }
}