//
//  WBStatusCell.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {
    
    var statusViewModel:WBStatusViewModel?{
        didSet{
            originalView.statusViewModel = statusViewModel
            retweetedView.statusViewModel = statusViewModel
            
            if let _ = statusViewModel?.statusModel.retweeted_status{
                retweetedView.isHidden = false
                retweetedView.snp.updateConstraints { (make) in
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.bottom.equalTo(toolBar.snp.top).offset(-10)
                    make.top.equalTo(originalView.snp.bottom)
                }
            }else{
                retweetedView.isHidden = true
                retweetedView.snp.remakeConstraints { (make) in
                }
            }
        }
        
    }
    
    lazy var originalView: WBOriginalStatusView = WBOriginalStatusView()
    lazy var retweetedView: WBRetweetedStatusView = WBRetweetedStatusView()
    lazy var toolBar: WBStatusToolBar = WBStatusToolBar()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -设置UI
extension WBStatusCell {
    
    func setupUI(){
        self.selectionStyle = .none
        self.contentView.addSubview(originalView)
        self.contentView.addSubview(retweetedView)
        self.contentView.addSubview(toolBar)
    
        originalView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        
        retweetedView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(toolBar.snp.top).offset(-10)
            make.top.equalTo(originalView.snp.bottom)
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.height.equalTo(32)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(retweetedView.snp.bottom)
            make.top.greaterThanOrEqualTo(originalView.snp.bottom)
        }
    }
}
