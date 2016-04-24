//
//  powerup.controller.swift
//  tdt4240-project
//
//  Created by Anna Kastet on 22/04/16.
//  Copyright © 2016 group-1. All rights reserved.
//

import SpriteKit

// A class that controls the cycle of powerups in the game
class PowerUpController {
    private var powerups : [PowerUp]
    private var timer = NSTimer()
    private var chosenPowerUp : PowerUp?
    private var gameScene: GameScene
    
    private var timeLeft: NSTimeInterval?
    private var currentTimerSelector: String?
    private var selectors: [String: Selector] = ["showPowerUp": #selector(PowerUpController.show), "hide": #selector(hide), "stop": #selector(stopPowerup)]
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        powerups = [MegaMallet()] // insert powerups here
        pickAndStartRandomPowerUp()
    }
    
    // Returns random powerup from powerups array
    private func pickAndStartRandomPowerUp() {
        let index = Helpers.getRandomIntBetween(0, to: powerups.count)
        chosenPowerUp = powerups[index]
        startShowingCountdown()
    }
    
    // Starts timer. When it times out, powerup is shown.
    private func startShowingCountdown() {
        timer.invalidate()
        currentTimerSelector = "showPowerUp"
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(Helpers.getRandomIntBetween(10, to: 20)), target: self, selector: selectors[currentTimerSelector!]!, userInfo: nil, repeats: false)
    }
        
    // Timer method. Shows icon and sets new timer.
    @objc private func show() {
        chosenPowerUp!.showIcon(self.gameScene)
        // when this timer times out, powerup is hidden
        timer.invalidate()
        currentTimerSelector = "hide"
        timer = NSTimer.scheduledTimerWithTimeInterval(chosenPowerUp!.getVisibleDuration(), target: self, selector: selectors[currentTimerSelector!]!, userInfo: nil, repeats: false)
    }
    
    // Timer method. Hides the powerup icon.
    @objc private func hide() {
        chosenPowerUp!.hide()
        pickAndStartRandomPowerUp() // Pick new and start cycle over
    }
    
    // Called when powerup gets caught
    func didGetCaught(player: Player) {
        chosenPowerUp!.didGetCaught(player)
        timer.invalidate()
        currentTimerSelector = "stop"
        timer = NSTimer.scheduledTimerWithTimeInterval(chosenPowerUp!.getPowerupActionDuration(), target: self, selector: selectors[currentTimerSelector!]!, userInfo: nil, repeats: false)
    }
    
    @objc private func stopPowerup() {
        chosenPowerUp!.stop()
        pickAndStartRandomPowerUp() // Pick new and start cycle over
    }
    
    func pause() {
        timeLeft = timer.fireDate.timeIntervalSinceNow
        timer.invalidate()
    }
    
    func resume() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeLeft!, target: self, selector: selectors[currentTimerSelector!]!, userInfo: nil, repeats: false)
    }
    
}