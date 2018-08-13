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
    
    var finalScoreAmount: Int = 0
    var bestScoreAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScoreLbl.text = "\(finalScoreAmount)"
        
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
        
        bestScoreLbl.text = "\(bestScoreAmount)"
        
    }
    


}
