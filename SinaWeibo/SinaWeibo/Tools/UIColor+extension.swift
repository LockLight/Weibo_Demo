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
    
    //随机颜色
    class func randomColor () -> UIColor {
        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        
        let red = CGFloat(r)/255.0
        let green = CGFloat(g)/255.0
        let blue = CGFloat(b)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
