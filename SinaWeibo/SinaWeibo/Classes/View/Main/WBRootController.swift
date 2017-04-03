//
//  WBRootController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/2.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBRootController: UIViewController {
    
    //访客的图片和label 字典
    var visitorInfo:[String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension WBRootController {
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        setVisitorView()
        
    }
    
    func setVisitorView(){
        let visitorView = WBVisitorController(frame: self.view.bounds)
        visitorView.visitorInfo = self.visitorInfo
        
        self.view.addSubview(visitorView)
    }
}
