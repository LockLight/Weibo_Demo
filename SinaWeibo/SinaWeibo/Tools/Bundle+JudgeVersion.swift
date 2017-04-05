//
//  Bundle+JudgeVersion.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/5.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

let versionKey:String = "versionKey"

extension Bundle {
    var isNewFeatrue:Bool{
        //获取当前版本
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
                            as! String
        //获取老版本
        let oldVersion = UserDefaults.standard.value(forKey: versionKey) as? String
        
        if(oldVersion == nil || currentVersion != oldVersion){
            //保持当前版本号
            UserDefaults.standard.set(currentVersion, forKey: versionKey)
            
            return true
        }
        return false
    }
}
