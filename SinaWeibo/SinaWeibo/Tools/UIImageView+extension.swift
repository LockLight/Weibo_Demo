//
//  UIImageView+extension.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        let image = UIImage(named: imageName)
        self.image = image
    }
}
