//
//  WBRootController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/2.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBRootController: UIViewController {
    
    var visitorView: WBVisitorController?
    
    //访客的图片和label 字典
    var visitorInfo:[String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension WBRootController {
    func setupUI() {
        setVisitorView()
        
    }
    
    func setVisitorView(){
        visitorView = WBVisitorController(frame: self.view.bounds)
        visitorView?.visitorInfo = self.visitorInfo
        visitorView?.delegate = self
        self.view.addSubview(visitorView!)
    }
}

extension WBRootController:WBVisitorControllerDelegate{
    func login() {
        let loginController = WBLoginController()
        let loginNav = UINavigationController(rootViewController: loginController)
        present(loginNav, animated: true, completion: nil)
    }
}






