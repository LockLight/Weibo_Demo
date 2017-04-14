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
    
    
    func upload(url:String,parameters:Any?,data:Data,name:String,fileName:String,
        callBack:@escaping (Any?)->()){
        self.post(url, parameters: parameters, constructingBodyWith: { (bodyData) in
            bodyData.appendPart(withFileData: data, name: name, fileName: fileName, mimeType: "application/octet-stream")
        }, progress: nil, success: { (_ , response) in
            callBack(response)
        }) { (_ , error ) in
            callBack(error)
        }
    }
}
