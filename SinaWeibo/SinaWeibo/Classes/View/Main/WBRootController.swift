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
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: loginSuccessNotification, object: nil)
    }
}

//MARK: - 事件处理
extension WBRootController{
    func loginSuccess(){
        print("登录成功")
        visitorView?.removeFromSuperview()
        visitorView = nil
    }
}


//MARK: - 设置UI
extension WBRootController {
    func setupUI() {
        setVisitorView()
        
    }
    
    func setVisitorView(){
        if WBUserAccount.shared.isLogin == false{
            visitorView = WBVisitorController(frame: self.view.bounds)
            visitorView?.visitorInfo = self.visitorInfo
            visitorView?.delegate = self
            self.view.addSubview(visitorView!)
        }
    }
}

//MARK: - 访客视图的代理方法
extension WBRootController:WBVisitorControllerDelegate{
    func login() {
        let loginController = WBLoginController()
        let loginNav = UINavigationController(rootViewController: loginController)
        present(loginNav, animated: true, completion: nil)
    }
}






