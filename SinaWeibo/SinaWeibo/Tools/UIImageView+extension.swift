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
    
    func wb_setImageView(urlStr:String,placehoder:String){
        let url = URL(string: urlStr)
        let placehoderImage = UIImage(named: placehoder)
        
        if let url = url,let placehoderImage = placehoderImage{
            self.sd_setImage(with: url, placeholderImage:placehoderImage)
        }
    }
}
