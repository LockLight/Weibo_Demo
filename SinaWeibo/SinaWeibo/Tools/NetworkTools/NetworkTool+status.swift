//
//  NetworkTool+status.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/5.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import YYModel

extension NetworkTool{
    func requestHomeStaus(since_id:Int64,max_id:Int64,callBack:@escaping (Any?) ->()){
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters:[String:Any] = ["access_token":WBUserAccount.shared.access_token!,"since_id":since_id,"max_id":max_id]
        
        self.get(urlString, parameters: parameters, progress: nil, success: { (_, reseponse) in
            //获取statuses的key 对应的字典数组
            if let reseponse = reseponse as?[String:Any],
                let statusArr =  reseponse["statuses"] as? [[String:Any]]{
                //转换为模型数组
                if let statusMoldeArr = NSArray.yy_modelArray(with: WBStatusModel.self, json: statusArr) as? [WBStatusModel]{
                    callBack(statusMoldeArr)
                }else{
                    callBack(nil)
                }
            }
        }) { (_, error) in
            print(error)
            callBack(nil)
        }
    }
}
