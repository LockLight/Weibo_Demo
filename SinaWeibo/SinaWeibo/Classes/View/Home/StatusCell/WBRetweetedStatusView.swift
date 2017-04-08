//
//  WBRetweetedStatusView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBRetweetedStatusView: UIView {
    //转发微博的label
    lazy var retweetedStatusLabel:UILabel = UILabel(title: nil)
    
    //微博数据模型
    var statusViewModel:WBStatusViewModel?{
        didSet{
            retweetedStatusLabel.text = statusViewModel?.retweetedText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBRetweetedStatusView{
    func setupUI(){
        addSubview(retweetedStatusLabel)
        
        retweetedStatusLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(wbStatusStruct.margin)
            make.right.bottom.equalTo(self).offset(-wbStatusStruct.margin)
        }
    }
}


