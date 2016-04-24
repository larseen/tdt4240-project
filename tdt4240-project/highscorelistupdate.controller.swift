//
//  highscorelistupdate.controller.swift
//  tdt4240-project
//
//  Created by Elida Reknes on 22/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import Foundation
import UIKit

class HighscoreListUpdateController : UIViewController, UITextFieldDelegate {
    
    let highscores : HighscoreList! = SinglePlayerHighscoreList()
    var threshold: Int = 0
    var score: Int = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noUpdateLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.threshold = highscores.getHighscoreThreshold()
        score = Game.instance.getWinner().getScore();
        nameInput.delegate = self
        checkVisible()
    }
    
    func checkVisible(){
        if (score >= threshold){
            self.noUpdateLabel.hidden = true
            self.scoreLabel.text = String(score)
        } else {
            self.nameLabel.hidden = true
            self.submitButton.hidden = true
            self.nameInput.hidden = true
        }
    }
    
    @IBAction func submitClicked(sender: AnyObject) {
        highscores.updateHighscores(Highscore(score: score, name: nameInput.text!))
        self.performSegueWithIdentifier("moveToList", sender: self)
    }
}
