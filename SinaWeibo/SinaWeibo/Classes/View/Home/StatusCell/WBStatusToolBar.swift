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
        
        
        addSubview(retweetButton)
        addSubview(commentButton)
        addSubview(prizeButton)
        
        //自动布局
        retweetButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.left.equalTo(retweetButton.snp.right)
            make.top.equalTo(retweetButton)
            make.bottom.equalTo(retweetButton)
            make.width.equalTo(retweetButton)
        }
        
        prizeButton.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.right.equalTo(self)
            make.top.equalTo(commentButton)
            make.bottom.equalTo(commentButton)
            make.width.equalTo(commentButton)
        }
    }
}
