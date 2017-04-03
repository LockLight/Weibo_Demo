//
//  UIButton+convenience.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UIButton {
    //至少有一个参数是必传的, 如果所有参数都有默认值, 就意味所有参数都可以不传, 如果所有的参数都不传, 写法就会与默认的构造函数init()方法冲突
    convenience init(title: String?,
                     titleColor: UIColor = UIColor.darkGray,
                     fontSize: CGFloat = 14,
                     image: String? = nil,
                     bgImage: String? = nil,
                     target: AnyObject? = nil,
                     action: Selector? = nil,
                     event: UIControlEvents = .touchUpInside) {
        self.init()
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        //如果传了图片, 才设置
        if let image = image {
            self.setImage(UIImage(named: image), for: .normal)
            self.setImage(UIImage(named: "\(image)_highlighted"), for: .highlighted)
        }
        
        //如果传了背景图片, 才设置
        if let bgImage = bgImage {
            self.setBackgroundImage(UIImage(named: bgImage), for: .normal)
            self.setBackgroundImage(UIImage(named: "\(bgImage)_highlighted"), for: .highlighted)
        }
        
        //添加事件
        if let target = target, let action = action {
            self.addTarget(target, action: action, for: event)
        }
    }

}
