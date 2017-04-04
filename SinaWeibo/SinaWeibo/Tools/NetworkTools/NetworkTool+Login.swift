//
//  NetworkTool+Login.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

extension NetworkTool {
    var loginURL: String {
        return "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectURI)"
    }
    
    /// 调用该方法来获取code api.weibo.com/oauth2/access_token?client_id
    func requestToken(code: String, callBack: @escaping (Any?)->()) {
        let parameters = ["client_id": appKey,
                          "client_secret": appSecrect,
                          "grant_type":"authorization_code",
                          "code":code,
                          "redirect_uri":redirectURI]
        request(url: "https://api.weibo.com/oauth2/access_token", method: "POST", parameters: parameters) { (response) in
            callBack(response)
        }
    }
    
    
    /// 根据uid获取用户信息
    func reqeustUser(uid: String, accessToken: String, callBack: @escaping (Any?)->()) {
        let parameters = ["access_token":accessToken,
                          "uid":uid]
        request(url: "https://api.weibo.com/2/users/show.json", method: "GET", parameters: parameters) { (response) in
            callBack(response)
        }
    }
}
