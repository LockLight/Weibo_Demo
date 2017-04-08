//
//  common.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

//MARK: - 登录相关
let appKey = "3781619220"
let appSecrect = "ed3924e8e94e97f6e397b66a81eef258"
let redirectURI = "http://www.baidu.com"
let wbuserName = "27909649@qq.com"
let wbPassword = "purel@3.21weibo"

//MARK: - 和rect相关
let screenBounds = UIScreen.main.bounds
let screenWidth = screenBounds.width
let screenHeight = screenBounds.height
let screenScale = UIScreen.main.scale //缩放比例

//MARK: - UI相关
let globalColor: UIColor = UIColor.orange


//MARK: - 全局通知
let loginSuccessNotification = Notification.Name(rawValue: "loginSuccessNotification")

//MARK: - 在微博模块中的一些常量的封装
struct WBStatusStruct {
    let iconSize: CGSize = CGSize(width: 35, height: 35)
    let margin: CGFloat = 10
    let vipSize: CGSize = CGSize(width: 15, height: 15)
    
    let imageHeight = (screenWidth - 4 * 10)/3
    var imageSize = CGSize.zero
    
    init() {
        imageSize = CGSize(width: imageHeight, height: imageHeight)
    }
}

let wbStatusStruct = WBStatusStruct()

//MARK: - 首页的cell分割颜色
let home_CellColor = UIColor(white: 0.8, alpha: 1.0)


