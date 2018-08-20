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
    @IBAction func didTapRate(_ sender: UIButton) {
        rateApp(appId: "id1428253345")
    }
    
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) {
    }
    
    fileprivate func rateApp(appId: String) {
        openUrl("itms-apps://itunes.apple.com/app/" + appId)
    }
    fileprivate func openUrl(_ urlString:String) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
