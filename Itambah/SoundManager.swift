//
//  SoundManager.swift
//  Itambah
//
//  Created by Vicky Irwanto on 09/04/23.
//

import SwiftUI
import AVFoundation

class SoundManager{
    static let instance = SoundManager()
    
    var player : AVAudioPlayer?
    
    func PlaySound(){
        guard let url = Bundle.main.url(forResource: "kids", withExtension: ".mp3") else {return}
        
        do{
          
            player = try AVAudioPlayer(contentsOf:url)
            player?.numberOfLoops = -1
            player?.play()
        } catch let error{
            print("error playing sound. \(error.localizedDescription)")
        }
    }
    
    func StopSound(){
        guard let url = Bundle.main.url(forResource: "kids", withExtension: ".mp3") else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf:url)
            player?.pause()
        } catch let error{
            print("error stopping sound. \(error.localizedDescription)")
        }
    }
    
    
}
