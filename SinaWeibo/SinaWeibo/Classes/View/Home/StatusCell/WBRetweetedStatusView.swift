//
//  WBRetweetedStatusView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBRetweetedStatusView: UIView {
    
    var statusViewModel:WBStatusViewModel?{
        didSet{
            //转发微博正文
            retweetedStatusLabel.text =  statusViewModel?.retweetedText
        }
    }
    
    //转发微博正文
    lazy var retweetedStatusLabel:UILabel = UILabel(title: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBRetweetedStatusView{
    fileprivate func setupUI(){
        
        self.backgroundColor = home_CellColor
        self.addSubview(retweetedStatusLabel)
        
        retweetedStatusLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
       }
    }
}


