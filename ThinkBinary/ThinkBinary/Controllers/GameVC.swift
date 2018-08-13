//
//  GameVC.swift
//  ThinkBinary
//
//  Created by AppDev on 5/26/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import UIKit

class GameVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // Outlets
    @IBOutlet weak var currPointsLbl: UILabel!
    @IBOutlet weak var timeRemainingLbl: UILabel!
    @IBOutlet weak var targetValueLbl: UILabel!
    @IBOutlet weak var currValueLbl: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    // Timer Running State
    var isTimerRunning:Bool = false
    // Option IndexPaths
    var indexPaths: [IndexPath] = []
    // Total Score Received From Delegate
    var totalScore: Int = 0
   
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GameManager.sharedInstance.delegate = self
        GameManager.sharedInstance.startGame()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didTapHome(_ sender: UIButton) {
        GameManager.sharedInstance.endGame()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapRestart(_ sender: UIButton) {
        GameManager.sharedInstance.resetGame()
        GameManager.sharedInstance.startGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOver" {
            let gameOverVC: GameOverVC = segue.destination as! GameOverVC
            gameOverVC.finalScoreAmount = totalScore
        }
    }
    
    
    // Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameManager.sharedInstance.currOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! OptionCell
        cell.backgroundColor = UIColor.clear
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.pinkAccent.cgColor
        cell.layer.cornerRadius = cell.frame.width*0.5
        cell.optionLabel.text = "\(GameManager.sharedInstance.selectableOptions[indexPath.item])"
        cell.optionLabel.textColor = UIColor.pinkAccent
        indexPaths.append(indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/6, height: self.view.frame.width/6)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GameManager.sharedInstance.didTapOption(indexPath: indexPath)
    }
    
    

}

extension GameVC: GameDelegate {
    func updateOptions(withIndexPath indexPath: IndexPath, withStatus status: OptionStatus) {
        print("Updating Option")
        let cell: OptionCell = self.optionsCollectionView.cellForItem(at: indexPath) as! OptionCell
        
        switch(status) {
        case .ACTIVE:
            cell.backgroundColor = UIColor.pinkAccent
            cell.layer.borderColor = UIColor.pinkAccent.cgColor
            cell.optionLabel.textColor =  UIColor.white
        case .INACTIVE:
            cell.backgroundColor = UIColor.clear
            cell.layer.borderColor = UIColor.pinkAccent.cgColor
            cell.optionLabel.textColor = UIColor.pinkAccent
        }
    }
    
    func updateGameCounters() {
        print("Updating the Game's Data")
        let totalPoints: Int = GameManager.sharedInstance.totalPoints
        let currentValue: Int = GameManager.sharedInstance.currValue
        let currentTarget: Int = GameManager.sharedInstance.targetValue
        
        self.currPointsLbl.text = "\(totalPoints)"
        self.currValueLbl.text = "\(currentValue)"
        self.targetValueLbl.text = "\(currentTarget)"
    }
    
    func updateForNextTarget() {
        print("Resetting The Board")
        self.optionsCollectionView.reloadData()
    }
    
    func endGame(withTotalScore score: Int) {
        print("Ending Game")
        totalScore = score
        self.performSegue(withIdentifier: "gameOver", sender: nil)
        
    }
    
    func updateTimeLeft(withTime time: String) {
        print("Time Left: \(time)")
        self.timeRemainingLbl.text = time
    }
    
}
