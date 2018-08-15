//
//  GameManager.swift
//  ThinkBinary
//
//  Created by AppDev on 8/12/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import Foundation

class GameManager {
    // Instance of Game Manager
    static let sharedInstance: GameManager = GameManager()
    
    // Game Delegate
    var delegate: GameDelegate!
    
    // Game Constants
    
    // Array of binary numbers to choose from
    let selectableOptions: [Int] = [1,2,4,8,16,32,64,128,256,512]
    // Maximum Summable Values
    private let maxValues: [Int] = [1,3,7,15,31,63,127,255,511,1023]
    // Number of Seconds in a Game
    private let gameTimeAmount:Int = 20
    // Time Increments For Each Level
    private let gameTimeIncrement: Int = 20
    
    // Game Data
    
    // Current Game Status
    private var gameStatus: GameStatus!
    // Array of currently being played options
    var currOptions: [Int]!
    private var selectedOptions: [Int]!
    // Hardness Level Unlocks
    private var currLevel:Int!
    // Current Selected Value: Default to 0s
    var currValue:Int!
    // Current Target Value
    var targetValue:Int!
    // Current Amount of Points
    var totalPoints:Int!
    // Current Time Left in Game
    private var currTimeLeft:Int!
    private var timer: Timer!
    
    
    // Private Initializer
    private init() {
        self.gameStatus = .OVER
        self.currOptions = [1,2,4,8,16]
        self.selectedOptions = []
        self.currLevel = 4
        self.currValue = 0
        self.targetValue = 0
        self.totalPoints = 0
        self.currTimeLeft = 0
        self.timer = Timer()
    }
    
    // Resets Game Information
    func resetGame() {
        self.gameStatus = .OVER
        self.timer.invalidate()
        self.currOptions = [1,2,4,8,16]
        self.currLevel = 4
        self.currValue = 0
        self.targetValue = 0
        self.totalPoints = 0
        self.currTimeLeft = 0
    }
    
    // Starts the Game
    func startGame() {
        self.gameStatus = .ACTIVE
        self.currTimeLeft = gameTimeAmount
        nextTarget()
        delegate.updateGameCounters()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)

    }
    
    func endGame(withEnding endingMethod: GameOverMethod) {
        self.gameStatus = .OVER
        self.timer.invalidate()
        delegate.endGame(withTotalScore: self.totalPoints, withMethod: endingMethod)
        print("Game Over")
    }
    
    func nextTarget() {
        self.targetValue = Int(arc4random_uniform(UInt32(maxValues[currLevel])) + 1)
        self.selectedOptions = []
        self.currValue = 0
        delegate.updateGameCounters()
        delegate.updateForNextTarget()
    }
    
    func nextLevel() {
        self.currLevel = currLevel + 1
        self.currOptions.append(selectableOptions[currLevel])
        self.currTimeLeft = self.currTimeLeft + self.gameTimeIncrement
        
        // Tell the controller to reset the options
        nextTarget()
    }
    
    func didHitTarget() {
        self.totalPoints  = self.totalPoints + 1
        
        if (totalPoints % 5 == 0) {
            nextLevel()
        } else {
            nextTarget()
        }
        
    }
    
    func didTapOption(indexPath: IndexPath) {
        let selectedValue: Int = selectableOptions[indexPath.item]
        
        if (selectedOptions.contains(selectedValue)) {
            for i in 0...selectedOptions.count - 1 {
                if selectedOptions[i] == selectedValue {
                    selectedOptions.remove(at: i)
                    break
                }
            }
            delegate.updateOptions(withIndexPath: indexPath, withStatus: .INACTIVE)
        } else {
            selectedOptions.append(selectedValue)
            delegate.updateOptions(withIndexPath: indexPath, withStatus: .ACTIVE)
        }
        
        calculateCurrSelectionTotal()
        
    }
    
    func calculateCurrSelectionTotal() {
        var currentTotal: Int = 0
        for option in selectedOptions {
            currentTotal += option
        }
        self.currValue = currentTotal
        
        if (self.currValue > targetValue) {
            endGame(withEnding: .NUMBEROVER)
        } else if (self.currValue == targetValue) {
            didHitTarget()
        } else {
            delegate.updateGameCounters()
        }
        
    }
    
    @objc func updateTimer() {
        if (currTimeLeft > 0) {
            self.currTimeLeft = self.currTimeLeft - 1
            let timeRemaining: String = timeToString(time: TimeInterval(currTimeLeft))
            delegate.updateTimeLeft(withTime: timeRemaining)
        } else {
            endGame(withEnding: .TIMESUP)
        }
    }
    
    func timeToString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", arguments: [minutes, seconds])
    }
    
    
    
    
}
