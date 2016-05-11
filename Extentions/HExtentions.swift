//
//  HExtentions.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/11.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

// HEX Color Designation using UIColor Extension
extension UIColor {
    class func hexStr (hexStr : NSString, alpha : CGFloat) -> UIColor {
        let hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}