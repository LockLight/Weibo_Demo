//
//  UILable+extension.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(title: String?,
                     textColor: UIColor = UIColor.darkGray,
                     fontSize: CGFloat = 14,
                     numOfLines: Int = 0,
                     alignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
        
        self.sizeToFit()
    }
}
