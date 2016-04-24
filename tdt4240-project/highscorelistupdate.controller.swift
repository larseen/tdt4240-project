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
    
    private let highscores : HighscoreList! = SinglePlayerHighscoreList()
    private var threshold: Int64 = 0
    private let score = 500//game.getScorePlayerOne();
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noUpdateLabel: UILabel!
    
    func checkVisible(){
        if (Int64(score) >= threshold){
            self.noUpdateLabel.hidden = true
        }
        else {
            self.nameLabel.hidden = true
            self.submitButton.hidden = true
            self.nameInput.hidden = true
        }
    }
    
    @IBAction func submitClicked(sender: AnyObject) {
        highscores.updateHighscores(Highscore(score: Int64(self.score), name: nameInput.description))
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.threshold = highscores.getHighscoreThreshold()
        
        nameInput.delegate = self
    }
    
    
}
