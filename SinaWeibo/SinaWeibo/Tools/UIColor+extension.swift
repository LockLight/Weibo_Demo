//
//  UIColor+extension.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let red = r/255.0
        let green = g/255.0
        let blue = b/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
