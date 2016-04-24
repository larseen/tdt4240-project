//
//  music.swift
//  tdt4240-project
//
//  Created by Kristoffer Larsen on 08.04.2016.
//  Copyright © 2016 group-1. All rights reserved.
//

import AVFoundation

func getMusicPreference() -> Bool{
    let defaults = NSUserDefaults.standardUserDefaults()
    if !defaults.dictionaryRepresentation().keys.contains("preferMusic") {
        return true
    }
    return defaults.boolForKey("preferMusic")
}

private let instance = music()

func getMusicInstance() ->music{
    return instance
}


class music {
    var backgroundMusicPlayer: AVAudioPlayer
    var musicPlaying:Bool
    
    
    private init(){
        print("init music class")
        backgroundMusicPlayer = AVAudioPlayer()
        let musicPreference = getMusicPreference()
        musicPlaying = musicPreference
        if musicPreference{
            playBackgroundMusic()
        }
    }
    
    
    
    func playBackgroundMusic() {
        musicPlaying = true
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "preferMusic")
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
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "preferMusic")
    }

    func statusBackgroundMusic() -> BooleanType {
        return musicPlaying
    }
}
