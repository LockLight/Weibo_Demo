//
//  WBPhotoViewerController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/9.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBPhotoViewerController: UIViewController {
    
    //当前展示图片的index
    var index:Int = 0
    
    //图片的url数组
    var pic_urlArr:[String] = []
    
    //重载构造函数,设置所需参数
    init(index:Int, pic_urlArr:[String]){
        super.init(nibName: nil, bundle: nil)
        
        self.index = index
        self.pic_urlArr = pic_urlArr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("第\(index)张图片,url地址是\(pic_urlArr[index])")
        setupUI()
    }
}

extension WBPhotoViewerController{
    func setupUI(){
        
    }
}
