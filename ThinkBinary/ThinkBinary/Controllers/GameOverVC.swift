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
    @IBOutlet weak var replayBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    
    var finalScoreAmount: Int = 0
    var bestScoreAmount: Int = 0
    var gameOverMethod: GameOverMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreManager.sharedInstance.registerScore(withScore: finalScoreAmount)
        finalScoreLbl.text = "Your Scored: \(finalScoreAmount)"
        bestScoreLbl.text = "Best Score: \(ScoreManager.sharedInstance.getHighScore())"
        
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
    
    @IBAction func didTapReplay(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToGame", sender: nil)
    }
    @IBAction func didTapHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToHome", sender: nil)
    }
    


}
