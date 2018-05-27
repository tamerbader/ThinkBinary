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
    
    // Maximum Values
    let maxValues: [Int] = [1,3,7,15,31,63,127,255,511,1023]
    
    // Hardness Level Unlocks
    var hardnessLevel:Int = 5
    
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
            generateNewTarget()
            currValue = 0
            currValueLbl.text = "0"
            totalPoints += 1
            currPointsLbl.text = "\(totalPoints)"
            resetOptions()
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
    }
    func restart() {
        endGame()
        startGame()
        resetOptions()
        totalPoints = 0
        currPointsLbl.text = "\(totalPoints)"
    }
    
    func resetOptions() {
        for i in 0...9 {
            let myCell = optionsCollectionView.cellForItem(at: indexPaths[i]) as! OptionCell
            myCell.backgroundColor = UIColor(displayP3Red: 35/255, green: 48/255, blue: 63/255, alpha: 1)
            myCell.layer.borderColor = UIColor(displayP3Red: 118/255, green: 141/255, blue: 168/255, alpha: 1).cgColor
            myCell.optionLabel.textColor = UIColor(displayP3Red: 118/255, green: 141/255, blue: 168/255, alpha: 1)
            myCell.isTapped = false
        }
        //optionsCollectionView.reloadData()
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
    
    
    // Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! OptionCell
        cell.backgroundColor = UIColor(displayP3Red: 35/255, green: 48/255, blue: 63/255, alpha: 1)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(displayP3Red: 118/255, green: 141/255, blue: 168/255, alpha: 1).cgColor
        cell.layer.cornerRadius = cell.frame.width*0.5
        cell.optionLabel.text = "\(options[indexPath.item])"
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
            cell.backgroundColor = UIColor(displayP3Red: 153/255, green: 128/255, blue: 68/255, alpha: 1)
            cell.layer.borderColor = UIColor(displayP3Red: 200/255, green: 164/255, blue: 76/255, alpha: 1).cgColor
            cell.optionLabel.textColor =  UIColor(displayP3Red: 200/255, green: 164/255, blue: 76/255, alpha: 1)
            cell.isTapped = true
            updateCurrentValue(beingAdded: true, value: options[indexPath.item])
        } else {
            cell.backgroundColor = UIColor(displayP3Red: 35/255, green: 48/255, blue: 63/255, alpha: 1)
            cell.layer.borderColor = UIColor(displayP3Red: 118/255, green: 141/255, blue: 168/255, alpha: 1).cgColor
            cell.optionLabel.textColor = UIColor(displayP3Red: 118/255, green: 141/255, blue: 168/255, alpha: 1)
            updateCurrentValue(beingAdded: false, value: options[indexPath.item])
            cell.isTapped = false
        }
    }
    
    

}
