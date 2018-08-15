//
//  ScoreManager.swift
//  ThinkBinary
//
//  Created by AppDev on 8/15/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import Foundation

class ScoreManager {
    static let sharedInstance: ScoreManager = ScoreManager()
    let HIGH_SCORE_KEY:String = "highscore"
    
    
    private init() {
    }
    
    func registerScore(withScore score: Int) {
        
        let currentHighScore: Int = getHighScore()
        if (score > currentHighScore) {
            self.setHighScore(withScore: score)
        }
        
    }
    
    func getHighScore() -> Int {
        guard let highScore: Int = UserDefaults.standard.object(forKey: HIGH_SCORE_KEY) as? Int else {
            setHighScore(withScore: 0)
            return 0
        }
        return highScore
    }
    
    func setHighScore(withScore score: Int) {
        UserDefaults.standard.set(score, forKey: HIGH_SCORE_KEY)
    }
}
