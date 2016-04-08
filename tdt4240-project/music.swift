//
//  music.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import AVFoundation

var backgroundMusicPlayer = AVAudioPlayer()
var musicPlaying = true

func playBackgroundMusic() {
    let url = NSBundle.mainBundle().URLForResource("16 - Perturbator.mp3", withExtension: nil)
    guard let newURL = url else {
        return
    }
    do {
        musicPlaying = true
        backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch let error as NSError {
        print(error.description)
    }
}

func stopBackgroundMusic() {
    musicPlaying = false;
    backgroundMusicPlayer.stop()
}

func statusBackgroundMusic() -> BooleanType {
    return musicPlaying
}