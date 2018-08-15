//
//  AppDefs.swift
//  ThinkBinary
//
//  Created by AppDev on 8/12/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import Foundation

enum GameStatus: Int {
    case ACTIVE = 0
    case OVER = 1
}

enum OptionStatus: Int {
    case ACTIVE = 0
    case INACTIVE = 1
}

enum GameOverMethod: Int {
    case NUMBEROVER = 0
    case TIMESUP = 1
    case HOMEPRESSED = 2
}

protocol GameDelegate {
    func updateOptions(withIndexPath indexPath: IndexPath, withStatus status: OptionStatus)
    func updateGameCounters()
    func updateForNextTarget()
    func endGame(withTotalScore score: Int, withMethod endingMethod: GameOverMethod)
    func updateTimeLeft(withTime time: String)
    
}



