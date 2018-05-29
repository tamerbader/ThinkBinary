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
    
    
    // Array of binary numbers to choose from
    let options: [Int] = [1,2,4,8,16,32,64,128,256,512]
    
    // Array of currently being played options
    var currOptions: [Int] = [1,2,4,8,16]
    
    // Maximum Values
    let maxValues: [Int] = [1,3,7,15,31,63,127,255,511,1023]
    
    // Hardness Level Unlocks
    var hardnessLevel:Int = 4
    
    // Current Selected Value: Default to 0
    var currValue:Int = 0
    
    // Current Target Value
    var targetValue:Int = 0
    
    // Current Amount of Points
    var totalPoints:Int = 0
    
    // Number of Seconds in a Game
    let gameTimeAmount:Int = 60
    
    // Current Time Left in Game
    var currTimeLeft:Int = 0
    
    // Timer
    var timer:Timer = Timer()
    
    // Timer Running State
    var isTimerRunning:Bool = false
    
    // Option IndexPaths
    var indexPaths: [IndexPath] = []
   
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didTapHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        endGame()
    }
    
    @IBAction func didTapRestart(_ sender: UIButton) {
        restart()
    }
    
    @objc func updateTimer() {
        if (currTimeLeft > 0) {
            currTimeLeft -= 1
            timeRemainingLbl.text = timeToString(time: TimeInterval(currTimeLeft))
        } else {
            endGame()
        }
    }
    
    func updateCurrentValue(beingAdded:Bool, value:Int) {
        if (beingAdded) {
            currValue += value
        } else {
            currValue -= value
        }
        currValueLbl.text = "\(currValue)"
        if(currValue == targetValue) {
            resetOptions()
            currValue = 0
            currValueLbl.text = "0"
            totalPoints += 1
            currPointsLbl.text = "\(totalPoints)"
            
            if (totalPoints % 5 == 0) {
                nextLevel()
                currTimeLeft += 30
            }
            generateNewTarget()
        }
        
        if (currValue > targetValue) {
            endGame()
        }
    }
    
    func startGame() {
        currTimeLeft = gameTimeAmount
        currValue = 0
        currValueLbl.text = "\(currValue)"
        currPointsLbl.text = "\(totalPoints)"
        timeRemainingLbl.text = timeToString(time: TimeInterval(gameTimeAmount))
        generateNewTarget()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameVC.updateTimer)), userInfo: nil, repeats: true)
    }
    func endGame() {
        timer.invalidate()
        resetOptions()
        self.performSegue(withIdentifier: "gameOver", sender: nil)
    }
    func restart() {
        timer.invalidate()
        resetOptions()
        totalPoints = 0
        currPointsLbl.text = "\(totalPoints)"
        hardnessLevel = 4
        currOptions = [1,2,4,8,16]
        indexPaths.removeAll()
        optionsCollectionView.reloadData()
        startGame()
    }
    
    func nextLevel() {
        hardnessLevel += 1
        currOptions.append(options[hardnessLevel])
        indexPaths.removeAll()
        optionsCollectionView.reloadData()
        
    }
    
    func resetOptions() {
        for i in 0...currOptions.count - 1 {
            let myCell = optionsCollectionView.cellForItem(at: indexPaths[i]) as! OptionCell
            myCell.backgroundColor = UIColor.white
            myCell.layer.borderColor = UIColor.mediumGreen.cgColor
            myCell.optionLabel.textColor = UIColor.mediumGreen
            myCell.isTapped = false
        }
    }
    
    func generateNewTarget() {
        targetValue = Int(arc4random_uniform(UInt32(maxValues[hardnessLevel])) + 1)
        targetValueLbl.text = "\(targetValue)"
    }
    
    func timeToString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", arguments: [minutes, seconds])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOver" {
            let gameOverVC: GameOverVC = segue.destination as! GameOverVC
            gameOverVC.finalScoreAmount = totalPoints
        }
    }
    
    
    // Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! OptionCell
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.mediumGreen.cgColor
        cell.layer.cornerRadius = cell.frame.width*0.5
        cell.optionLabel.text = "\(options[indexPath.item])"
        cell.optionLabel.textColor = UIColor.mediumGreen
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
        let cell: OptionCell = collectionView.cellForItem(at: indexPath) as! OptionCell
        if (!cell.isTapped) {
            cell.backgroundColor = UIColor.mediumGreen
            cell.layer.borderColor = UIColor.white.cgColor
            cell.optionLabel.textColor =  UIColor.white
            cell.isTapped = true
            updateCurrentValue(beingAdded: true, value: options[indexPath.item])
        } else {
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.mediumGreen.cgColor
            cell.optionLabel.textColor = UIColor.mediumGreen
            updateCurrentValue(beingAdded: false, value: options[indexPath.item])
            cell.isTapped = false
        }
    }
    
    

}
