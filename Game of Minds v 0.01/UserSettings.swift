//
//  UserSettings.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 22.04.20.
//  Copyright © 2020 Dream Team. All rights reserved.
//

import UIKit

final class UserSettings {
    
    static var gameType: String! {
        get {
            return UserDefaults.standard.string(forKey: "gameType")
        }
        set {
            let defaults = UserDefaults.standard
            if let gameType = newValue {
                defaults.set(gameType, forKey: "gameType")
            } else {
                defaults.removeObject(forKey: "gameType")
            }
        }
    }

    
    static var wrongResult: Int! {
        get {
            return UserDefaults.standard.integer(forKey: "wrongResult")
        }
        set {
            let defaults = UserDefaults.standard
            if let wrongResult = newValue {
                defaults.set(wrongResult, forKey: "wrongResult")
            } else {
                defaults.removeObject(forKey: "wrongResult")
            }
        }
    }
    
    static var currentResult: Int! {
        get {
            return UserDefaults.standard.integer(forKey: "currentResult")
        }
        set {
            let defaults = UserDefaults.standard
            if let currentResult = newValue {
                defaults.set(currentResult, forKey: "currentResult")
            } else {
                defaults.removeObject(forKey: "currentResult")
            }
        }
    }
    
    static var finishGameFlag: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: "flag")
        }
        set {
            let defaults = UserDefaults.standard
            if let flag = newValue {
                defaults.set(flag, forKey: "flag")
            } else {
                defaults.removeObject(forKey: "flag")
            }
        }
    }

}
