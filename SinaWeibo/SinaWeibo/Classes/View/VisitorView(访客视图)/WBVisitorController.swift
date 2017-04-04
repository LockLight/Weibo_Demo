//
//  WBVisitorController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/3.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

protocol WBVisitorControllerDelegate:NSObjectProtocol {
    func login()
}

class WBVisitorController: UIView {
    //登录按钮代理
    weak var delegate:WBVisitorControllerDelegate?
    
    //图标
    lazy var iconImageView:UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")
    //转动图标
    lazy var circleImageView:UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
    //渐变视图
    lazy var maskImageView:UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
    //描述label
    lazy var titleLabel:UILabel = UILabel(title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", alignment: .center)
    //登录按钮
    lazy var loginBtn:UIButton = UIButton(title: "登录", bgImage: "common_button_white_disable", target: self, action:#selector(btnClick))
    //注册按钮
    lazy var registerBtn:UIButton = UIButton(title:"注册", titleColor:.orange ,bgImage: "common_button_white_disable", target: self, action: #selector(btnClick))
    
    
    //图标与label的字典
    var visitorInfo:[String:Any]?{
        didSet {
            iconImageView.image = UIImage(named: visitorInfo?["imageName"] as! String)
            titleLabel.text = visitorInfo?["message"] as? String
            
            if let _ = visitorInfo?["isAnimation"] as? Bool {
                circleImageView.isHidden = false
            } else {
                circleImageView.isHidden = true
            }
        }
    }
    
    
    /// 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 事件处理
extension WBVisitorController{
    func btnClick(){
        print("hello world")
        delegate?.login()
    }
}


// MARK: - 设置UI
extension WBVisitorController{
    func setupUI(){
        self.backgroundColor = UIColor.rgbColor(r: 237, g: 237, b: 237)
        
        //添加控件
        addSubview(iconImageView)
        addSubview(circleImageView)
        addSubview(maskImageView)
        addSubview(titleLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        //约束
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-100)
        }
        
        circleImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView)
            make.centerY.equalTo(iconImageView)
        }
        
        maskImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView)
            make.centerY.equalTo(iconImageView).offset(40)
            make.left.right.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView)
            make.centerY.equalTo(iconImageView).offset(150)
            make.left.equalTo(self).offset(50)
            make.right.equalTo(self).offset(-50)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(70)
            make.bottom.equalTo(self).offset(-120)
            make.size.equalTo(CGSize(width: 80, height: 35))
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-70)
            make.bottom.equalTo(registerBtn)
            make.size.equalTo(CGSize(width: 80, height: 35))
        }
        
        addAnimation()
    }
    
    //转动图标动画
    func addAnimation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 7
        animation.repeatCount = MAXFLOAT
        //保持动画状态,当页面跳转后
        animation.isRemovedOnCompletion = false
        
        circleImageView.layer.add(animation, forKey: nil)
    }
}
