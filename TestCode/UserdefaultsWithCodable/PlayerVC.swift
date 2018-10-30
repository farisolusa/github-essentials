//
//  PlayerVC.swift
//  TestCode
//
//  Created by Anil Prasad on 10/17/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation
import UIKit

class PlayerVC {
    init() {
        
        saveUserdefaults()
        loadUserdefaults()
        // Get Plist path
        #if arch(i386) || arch(x86_64)
            if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
                print("Document Directory: \(documentsPath)")
                // This file is in binary format.
            }
        #endif
    }
    func saveUserdefaults() {
        let player = Player(name: "Jamal Khan", highScore: 323)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(player), forKey: "player")
    }
    func loadUserdefaults() {
        guard let playerData = UserDefaults.standard.object(forKey: "player") as? Data else {
            return
        }
        guard let player = try? PropertyListDecoder().decode(Player.self, from: playerData) else {
            return
        }
        print(player.name)
    }
}
