//
//  UIColor+Extension.swift
//  ThinkBinary
//
//  Created by AppDev on 5/27/18.
//  Copyright © 2018 TamerBader. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let lightGreen: UIColor = UIColor(displayP3Red: 246/255, green: 196/255, blue: 152/255, alpha: 1)
    static let mediumGreen: UIColor = UIColor(displayP3Red: 86/255, green: 224/255, blue: 115/255, alpha: 1)
    static let darkGreen: UIColor = UIColor(displayP3Red: 84/255, green: 190/255, blue: 114/255, alpha: 1)
    
    static let darkBackground: UIColor = UIColor(hex: 0x1e222e)
    static let pinkAccent: UIColor = UIColor(hex: 0xfa758e)
    static let greenAccent: UIColor = UIColor(hex: 0xfda770)
    static let blueAccent: UIColor = UIColor(hex: 0x6ebefb)
    
    
    convenience init(red:Int, green:Int, blue:Int)
    {
        let div:CGFloat = 255.0;
        self.init(red:CGFloat(red) / div, green:CGFloat(green) / div, blue:CGFloat(blue) / div, alpha:1.0);
    }
    convenience init(hex:Int)
    {
        let bitMask:Int = 0xFF;
        let redHex:Int = (hex >> 16) & bitMask;
        let greenHex:Int = (hex >> 8) & bitMask;
        let blueHex:Int = (hex & 0xFF) & bitMask;
        
        self.init(red: redHex, green: greenHex, blue: blueHex)
    }
}
