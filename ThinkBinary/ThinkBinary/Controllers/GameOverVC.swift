//
//  GameOverVC.swift
//  ThinkBinary
//
//  Created by AppDev on 5/29/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController {
    @IBOutlet weak var finalScoreLbl: UILabel!
    @IBOutlet weak var bestScoreLbl: UILabel!
    @IBOutlet weak var gameOverMessage: UILabel!
    
    var finalScoreAmount: Int = 0
    var bestScoreAmount: Int = 0
    var gameOverMethod: GameOverMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreManager.sharedInstance.registerScore(withScore: finalScoreAmount)
        finalScoreLbl.text = "Your Scored: \(finalScoreAmount)"
        bestScoreLbl.text = "Best Score: \(ScoreManager.sharedInstance.getHighScore())"
        
       
       /*
        if (UserDefaults.standard.object(forKey: "highScore") != nil) {
            bestScoreAmount = UserDefaults.standard.integer(forKey: "highScore")
            if (finalScoreAmount > bestScoreAmount) {
                bestScoreAmount = finalScoreAmount
                UserDefaults.standard.set(bestScoreAmount, forKey: "highScore")
            }
        } else {
            bestScoreAmount = finalScoreAmount
            UserDefaults.standard.set(bestScoreAmount, forKey: "highScore")
        }
        
        bestScoreLbl.text = "\(bestScoreAmount)"*/
        
    }
    
    func setupView() {
        if let method = gameOverMethod {
            switch (method) {
            case .NUMBEROVER:
                gameOverMessage.text = "Game Over"
            case .TIMESUP:
                gameOverMessage.text = "Time's Up"
            case .HOMEPRESSED:
                break
            }
        }
        
        finalScoreLbl.text = "\(finalScoreAmount)"
        
    }
    


}
