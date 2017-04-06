//
//  WBWelcomeView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/5.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomeView: UIView {
    lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        iconView.sd_setImage(with: URL(string: WBUserAccount.shared.avatar_large!)!, placeholderImage: UIImage(named: "avatar_default_big")!)
        return iconView
    }()
    
    lazy var welcomeLabel:UILabel = UILabel(title: "欢迎回来,\(WBUserAccount.shared.screen_name!)",  fontSize: 15,  alignment: .center)

    override init(frame: CGRect) {
        super.init(frame: screenBounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //动画要在控件部署完后添加
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        addAnimation()
    }
    
}

extension WBWelcomeView{
    func setupUI() {
        self.backgroundColor = UIColor.white
        
        //添加控件
        addSubview(iconView)
        addSubview(welcomeLabel)
        
        //头像圆角
        iconView.layer.cornerRadius = 45
        iconView.layer.masksToBounds = true
        
        //自动布局
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-100)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        welcomeLabel.snp.makeConstraints { (make ) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-150)
        }
        
        //动画添加前,强制更新UI布局
        layoutIfNeeded()
    }
    
    func addAnimation(){
        iconView.snp.updateConstraints { (make ) in
            make.centerY.equalTo(self).offset(-130)
        }
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 9.8, options: [], animations: { 
            self.layoutIfNeeded()
        }) { (isFinish) in
            self.removeFromSuperview()
        }
    }
}
