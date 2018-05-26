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
    
    // Current Selected Value: Default to 0
    var currValue:Int = 0
    
    // Current Target Value
    var targetValue:Int = 0
    
    // Number of Seconds in a Game
    let gameTimeAmount:Int = 60
    
    // Current Time Left in Game
    var currTimeLeft:Int = 0
    
    // Timer
    var timer:Timer = Timer()
    
    // Timer Running State
    var isTimerRunning:Bool = false
    
   
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
    
    func startGame() {
        currTimeLeft = gameTimeAmount
        timeRemainingLbl.text = timeToString(time: TimeInterval(gameTimeAmount))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameVC.updateTimer)), userInfo: nil, repeats: true)
    }
    func endGame() {
        timer.invalidate()
    }
    func restart() {
        endGame()
        startGame()
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
    

}
