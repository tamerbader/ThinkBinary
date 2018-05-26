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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTapStart(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: nil)
    }
    
}
