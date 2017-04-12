//
//  WBComposeController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/11.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBComposeController: WBRootController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.randomColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK: - 事件处理
extension WBComposeController{
    func back(){
        dismiss(animated: false, completion: nil)
    }
    
    func compose(){
        print("发布微博")
    }
}

extension WBComposeController{
    override func setupUI() {
        //设置导航栏
        setNavigationBar()
    }
    
    func setNavigationBar(){
        //取消按钮
        let cancelBtn = UIButton(title: "取消", titleColor: UIColor.white, fontSize: 14,bgImage: "new_feature_finish_button",target: self, action: #selector(back))
        cancelBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let leftBtn = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem = leftBtn
        
        //发布按钮
        let composeBtn = UIButton(title: "发布", titleColor: UIColor.white, fontSize: 14, bgImage: "new_feature_finish_button", target: self, action: #selector(compose))
        composeBtn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .disabled)
        composeBtn.setTitleColor(UIColor.gray, for: .disabled)
        
        composeBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let rightBtn = UIBarButtonItem(customView: composeBtn)
        navigationItem.rightBarButtonItem = rightBtn
        
        composeBtn.isEnabled = false
        
        //设置titleView
        let titleLabel = UILabel(title: nil,alignment: .center)
        let titleText = NSMutableAttributedString(string: "发布微博\n", attributes: [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 16)])
        let userText = NSMutableAttributedString(string: "\(WBUserAccount.shared.screen_name!)", attributes: [NSForegroundColorAttributeName:UIColor.lightGray,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 12)])
        titleText.append(userText)
        titleLabel.attributedText = titleText
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
}
