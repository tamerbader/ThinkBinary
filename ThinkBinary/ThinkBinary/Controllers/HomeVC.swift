//
//  HomeVC.swift
//  ThinkBinary
//
//  Created by AppDev on 5/26/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var rateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.layer.cornerRadius = startBtn.frame.height / 1.75
        
        rateBtn.layer.cornerRadius = rateBtn.frame.height / 1.75
    }

    @IBAction func didTapStart(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: nil)
    }
    
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) {
    }
    
}
