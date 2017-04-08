//
//  WBStatusViewModel.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBStatusViewModel: WBStatusModel {
    //微博数据模型
    var statusModel:WBStatusModel
    
    //经过处理的来源字符串
    var sourceStr: String?
    
    //经过处理的vip等级
    var vipIcon:UIImage?
    
    //经过处理的皇冠等级
    var levelIcon:UIImage?
    
    //经过时间字符串
    var timeStr:String?
    
    //经过处理的转发微博文字
    var retweetedText:String?
    
    init(statusModel:WBStatusModel){
        self.statusModel = statusModel
        super.init()
        
        dealWithSource()
        dealWithVip()
        dealWithLevelIcon()
        dealWithTimeStr()
        dealWithRetweetedStatus()
    }
    
    //处理微博来源字符串
    func dealWithSource(){
        //"<a href=\"http://weibo.com/\" rel=\"nofollow\">iPhone 7 Plus</a>"
        if let source = statusModel.source, source.characters.count > 0{
            let startIndex = source.range(of: "\">")?.upperBound
            let endIndex = source.range(of: "</a")?.lowerBound
            
            let range = startIndex!..<endIndex!
            sourceStr = source.substring(with: range)
        }
    }
    
    func dealWithVip(){
        if let vip = statusModel.user?.verified_type{
            switch vip {
            case 0:
                vipIcon = UIImage(named: "avatar_vip")
            case 2,3,5:
                vipIcon = UIImage(named: "avatar_enterprise_vip")
            case 220:
                vipIcon = UIImage(named: "avatar_grassroot")
            default:
                vipIcon = nil
            }
        }
    }
    
    func dealWithLevelIcon(){
        if let mbrank = statusModel.user?.mbrank , mbrank>0 && mbrank<7{
            levelIcon = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    }
    
    func dealWithTimeStr(){
        if let serverTime = statusModel.created_at {
            timeStr = Date.requiredTimeStr(ServerTime: serverTime)
        }
    }
    
    func dealWithRetweetedStatus(){
        if let userName = statusModel.retweeted_status?.user?.screen_name,
            let text = statusModel.retweeted_status?.text {
                retweetedText = "@\(userName): \(text)"
        }
    }
}


