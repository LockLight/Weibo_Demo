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
            picView.statusViewModel = statusViewModel
            
            
            //根据是否存在配图模型更新约束
            if let count = statusViewModel?.statusModel.retweeted_status?.pic_urls?.count,count > 0 {
                picView.snp.updateConstraints({ (make) in
                    make.top.equalTo(retweetedStatusLabel.snp.bottom).offset(10)
                    make.left.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-10)
                    make.size.equalTo((statusViewModel?.picViewSize)!)
                })
            }else{
                picView.snp.updateConstraints({ (make) in
                    make.top.equalTo(retweetedStatusLabel.snp.bottom)
                    make.left.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-10)
                    make.size.equalTo(CGSize.zero)
                })
            }
        }
    }
    
    //转发微博正文
    lazy var retweetedStatusLabel:UILabel = UILabel(title: nil)
    
    //微博配图
    lazy var picView:WBStatusPictureView = WBStatusPictureView()
    
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
        addSubview(retweetedStatusLabel)
        addSubview(picView)
        
        retweetedStatusLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    
        picView.snp.makeConstraints { (make) in
            make.top.equalTo(retweetedStatusLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize.zero)
       }
    }
}


