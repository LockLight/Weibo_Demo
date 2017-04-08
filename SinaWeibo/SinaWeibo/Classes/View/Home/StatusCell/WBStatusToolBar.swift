//
//  WBStatusToolBar.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBStatusToolBar{
    func setupUI(){
        //patternImage: 将图片平铺
        self.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_card_bottom_line_highlighted")!)
        
        let retweetButton = UIButton(title: "30", titleColor: UIColor.gray, fontSize: 10, image: "timeline_icon_retweet")
        let commentButton = UIButton(title: "30", titleColor: UIColor.gray, fontSize: 10, image: "timeline_icon_comment")
        let prizeButton = UIButton(title: "30", titleColor: UIColor.gray, fontSize: 10, image: "timeline_icon_unlike")
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(retweetButton)
        addSubview(commentButton)
        addSubview(prizeButton)
        
        //自动布局
        retweetButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.left.equalTo(retweetButton.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(retweetButton)
        }
        
        prizeButton.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.right.equalToSuperview()
            make.width.equalTo(commentButton)
            make.top.bottom.equalToSuperview()
        }
    }
}
