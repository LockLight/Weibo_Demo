//
//  WBPictureModel.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/5.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import YYModel

class WBPictureModel: NSObject {
    /// 微博的图片的缩略图的地址
    var thumbnail_pic: String?{
        didSet{
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }
    
    /// 描述信息
    override var description: String {
        return self.yy_modelDescription()
    }
}
