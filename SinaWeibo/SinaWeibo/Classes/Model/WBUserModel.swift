//
//  WBUserModel.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/5.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import YYModel

class WBUserModel: NSObject {
    /// 用户的id
    var id: String?
    /// 用户的昵称
    var screen_name: String?
    /// 用户的头像地址
    var avatar_large: String?
    /// 用户的皇冠的等级 从1到6
    var mbrank: Int = 0
    /// 用户vip的信息: 0代表达人, 2, 3, 5代表企业达人, 220代表草根达人
    var verified_type: Int = -1
    
    /// 描述信息
    override var description: String {
        return self.yy_modelDescription()
    }
    
}
