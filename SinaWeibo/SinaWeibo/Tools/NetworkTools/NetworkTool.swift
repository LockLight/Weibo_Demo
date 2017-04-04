//
//  NetworkTool.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTool: AFHTTPSessionManager {
    //单例
    static let shared: NetworkTool = {
        let tool = NetworkTool(baseURL: nil)
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
    
    /// 网络中间层
    func request(url: String, method: String, parameters: Any?, callBack: @escaping (Any?)->()) {
        if method == "GET" {
            self.get(url, parameters: parameters, progress: nil, success: { (_, responseObject) in
                callBack(responseObject)
            }, failure: { (_, error) in
                print(error)
                callBack(nil)
            })
        }
        
        if method == "POST" {
            self.post(url, parameters: parameters, progress: nil, success: { (_, responseObject) in
                callBack(responseObject)
            }, failure: { (_, error) in
                print(error)
                callBack(nil)
            })
        }
    }
}
