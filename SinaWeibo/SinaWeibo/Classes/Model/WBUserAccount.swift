//
//  WBUserAccount.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

let userAccountKey: String = "userAccountKey"

class WBUserAccount: NSObject {
    /// 单例
    static let shared = WBUserAccount()
    
    /// token
    var access_token: String?
    
    /// 过期的秒数
    var expires_in: Double = 0 {
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    /// 过期的日期
    var expires_date: Date?
    
    /// 用户的id
    var uid: String?
    
    /// 用户的昵称
    var screen_name: String?
    
    ///用户的头像地址
    var avatar_large: String?
    
    override init() {
        super.init()
        read()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    ///用户是否登录
    var isLogin: Bool {
        //根据access_token是否纯在或过期确定是否登录
        return access_token != nil && Date().timeIntervalSince(expires_date!) < 0
    }
    
    func save(dict: [String: Any]) {
        //先给对象的属性赋值
        setValuesForKeys(dict)
        //将模型转成dic
        let userDict = dictionaryWithValues(forKeys: ["access_token", "uid", "expires_date", "screen_name", "avatar_large"])
        //将字典保存
        UserDefaults.standard.set(userDict, forKey: userAccountKey)
    }
    
    func read() {
        //userDefault中取出User的Dic,赋值
        if let userDic = UserDefaults.standard.value(forKey: userAccountKey) as? [String: Any] {
            setValuesForKeys(userDic)
        }
    }
}
