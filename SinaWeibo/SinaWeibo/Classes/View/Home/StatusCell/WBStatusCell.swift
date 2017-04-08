//
//  WBStatusCell.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {
    //微博数据模型
    var statusViewModel:WBStatusViewModel?{
        didSet{
            originalStatusView.statusViewModel = statusViewModel
            retweetedStatusView.statusViewModel = statusViewModel
            
            //如果模型中有转发微博
            if let _ = statusViewModel?.statusModel.retweeted_status{
                self.isHidden = false
                retweetedStatusView.snp.updateConstraints { (make) in
                    make.left.equalTo(self.contentView).offset(10)
                    make.right.bottom.equalTo(self.contentView).offset(-10)
                    make.top.equalTo(originalStatusView.snp.bottom)
                }
            }else{
                self.isHidden = true
                retweetedStatusView.snp.remakeConstraints({ (make) in
                })
            }
        }
    }
    
    //原创微博视图
    lazy var originalStatusView:WBOriginalStatusView = WBOriginalStatusView()
    //转发微博视图
    lazy var retweetedStatusView:WBRetweetedStatusView = WBRetweetedStatusView()
    //微博图片视图
    lazy var statusPicView:WBStatusPictureView = WBStatusPictureView()
    //微博底边栏视图
    lazy var statusToolBar:WBStatusToolBar = WBStatusToolBar()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBStatusCell{
    func setupUI(){
        //添加视图
        self.contentView.addSubview(originalStatusView)
        self.contentView.addSubview(retweetedStatusView)
//        self.contentView.addSubview(statusPicView)
        self.contentView.addSubview(statusToolBar)
        
        //设置子视图的颜色
        contentView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        originalStatusView.backgroundColor = UIColor.white
        retweetedStatusView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        //约束
        originalStatusView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(5)
            make.left.right.equalTo(self.contentView)
        }
        
        retweetedStatusView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.bottom.equalTo(self.contentView).offset(-10)
            make.top.equalTo(originalStatusView.snp.bottom)
        }
        
        statusToolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(36)
            make.top.equalTo(retweetedStatusView.snp.bottom)
        }
    }
}
