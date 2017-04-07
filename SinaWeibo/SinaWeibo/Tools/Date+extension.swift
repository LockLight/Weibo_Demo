//
//  Date+extension.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/7.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

//DateFormatter,Calendar消耗性能,作为全局变量仅创建一次,oc中作单例
let dateFormatter = DateFormatter()
let calendar = Calendar.current

extension Date{
    static func requiredTimeStr(ServerTime:String) -> String{
        let date = Date.serverTimeToDate(ServerTime: ServerTime)
        return date.dateToRequiredTimeStr()
    }
    
    //结构体的类方法使用static修饰
    //用新浪返回的时间字符串创建date对象
    static func serverTimeToDate(ServerTime:String) -> Date{
        let formatStr = "EEE MMM dd HH:mm:ss zzz yyyy"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = formatStr
        
        return dateFormatter.date(from: ServerTime)!
    }
    
    //将date对象转化为需要的时间字符串
    func dateToRequiredTimeStr ()->String{
        let seconds:Int64 = Int64(Date().timeIntervalSince(self))
        
        if seconds < 60 {
            return "刚刚"
        }
        if seconds < 3600{
            return "\(seconds/60)分钟前"
        }
        if seconds < 3600 * 24 {
            return "\(seconds/3600)小时前"
        }
        
        var formatStr = ""
        if calendar.isDateInToday(self){
            formatStr = "昨天 HH:mm"
        }else{
            let dateYear = calendar.component(.year, from: self)
            let currentYear = calendar.component(.year, from: Date())
            
            if dateYear == currentYear {
                formatStr = "MM-dd HH:mm"
            }else{
                formatStr = "yyyy-MM-dd HH:mm"
            }
        }
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = formatStr
        
        return dateFormatter.string(from: self)
    }
}
