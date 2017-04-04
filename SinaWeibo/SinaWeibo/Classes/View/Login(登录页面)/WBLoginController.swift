//
//  WBLoginController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/4.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBLoginController: WBRootController {
    /// webView的懒加载属性
    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        //加载数据
        loadLoginPage()
    }
    
    override func setupUI () {
        //添加webVew
        self.view.addSubview(webView)
        
        //设置返回按钮
        let buttonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = buttonItem
    }
    
    func loadLoginPage() {
        let url = URL(string: NetworkTool.shared.loginURL)
        let request = URLRequest(url: url!)
        
        webView.loadRequest(request)
    }
    
    func back() {
        dismiss(animated: true, completion: nil)
    }
}

extension WBLoginController: UIWebViewDelegate {
    /// 网页将要加载时执行, 如果return true, 则request请求成功, 否则失败
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //判断url是否是回调页
        if let urlString = request.url?.absoluteString,
            urlString.hasPrefix(redirectURI) == true,
            let query = request.url?.query {
            //判断点击是否为授权按钮
            if (query.hasPrefix("code=")) {
                //截取字符串, 获取code
                let subrange = urlString.range(of: "code=")
                let code = urlString.substring(from: (subrange?.upperBound)!)
                
                //使用code获取token
                NetworkTool.shared.requestToken(code: code, callBack: { (tokenDic) in
                    //判断token是否获取到
                    if let tokenDic = tokenDic as? [String: Any],
                        let uid = tokenDic["uid"] as? String,
                        let token = tokenDic["access_token"] as? String {
                        //获取token并保存用户信息
                        NetworkTool.shared.reqeustUser(uid: uid, accessToken: token, callBack: { (userDic) in
                            //判断userDic是否有值
                            if var userDic = userDic as? [String: Any] {
                                //合并字典
                                for (k, v) in tokenDic {
                                    userDic[k] = v
                                }
                                //保存用户信息
                                WBUserAccount.shared.save(dict: userDic)
                                self.dismiss()
                            } else {
                                //没有成功获取到user信息
                                self.dismiss()
                            }
                        })
                    } else {
                        //没有成功获取到token
                        self.dismiss()
                    }
                })
            } else { //点击的是取消按钮
                self.dismiss()
            }
            return false
        }
        return true
    }
    
    /// 网页成功加载后自定填充密码
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('userId').value='\(wbuserName)';document.getElementById('passwd').value='\(wbPassword)'")
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
