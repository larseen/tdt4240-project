//
//  highscorelist.controller.swift
//  tdt4240-project
//
//  Created by Anna Kastet on 08/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import UIKit

class HighscoreListController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var highscores : [Highscore]!
    let cellIdentifier = "HighscoreCell"
    let highscoreList : HighscoreList = SinglePlayerHighscoreList()
    var tableTitle = "HIGHSCORES"
    
    
    // MARK: Initialize TableView with highscore data
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return tableTitle
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let highscore = highscores[indexPath.row] // get highscore at given index
        cell.textLabel?.text = String(indexPath.row+1) + ". " + highscore.getName() + " " + String(highscore.getScore())
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (highscoreList.currentHighscores.description)
        highscores = highscoreList.getCurrentHighscores() // get highscores in sorted order
    }
    
}