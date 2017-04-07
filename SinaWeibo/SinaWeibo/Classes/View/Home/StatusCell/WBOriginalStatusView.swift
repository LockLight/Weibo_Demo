//
//  WBOriginalStatusView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBOriginalStatusView: UIView {
    //微博数据的模型
    var statusViewModel:WBStatusViewModel?{
        didSet{
            let url = URL(string: (statusViewModel?.statusModel.user?.avatar_large)!)
            userIcon.sd_setImage(with: url!, placeholderImage: UIImage.init(named: "avatar_default_big"))
            userNameLabel.text = statusViewModel?.statusModel.user?.screen_name
            statusLabel.text = statusViewModel?.statusModel.text
            sourceLabel.text = statusViewModel?.sourceStr
            vipIcon.image = statusViewModel?.vipIcon
            levelIcon.image = statusViewModel?.levelIcon
            timeLabel.text = statusViewModel?.timeStr
        }
    }
    
    //用户头像
    lazy var userIcon:UIImageView = UIImageView(imageName: "avatar_default_big")
    //用户的VIP图标
    lazy var vipIcon:UIImageView = UIImageView(imageName: "avatar_grassroot")
    //用户昵称
    lazy var userNameLabel:UILabel = UILabel(title: "伟大领柚金三胖")
    //用户皇冠等级
    lazy var levelIcon:UIImageView = UIImageView(imageName: "common_icon_membership_level6")
    //微博来源
    lazy var sourceLabel:UILabel = UILabel(title: "新浪")
    //微博的发布时间
    lazy var timeLabel:UILabel = UILabel(title: "两小时前")
    //微博征文的label
    lazy var statusLabel:UILabel = UILabel(title: "地雷哥回基地就狂吐了好几回，我闻着都要吐了[笑cry]今天其实在现场的感觉挺感动的，在当初很恶劣的电竞环境坚持下来的，现在回忆起当年，这几个哥们记忆的闸门拉都拉不住。大家都是成年人啦，过去的事早渐渐烟消云散，说出来也只是一笑而过，之前答应了大家播一播，大家看看乐一乐就好，与其带节奏不如多花时间在自己的梦想和要追求的人和事上，这样，在你时隔多年后重温起现在的时光才能不悔")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBOriginalStatusView{
    func setupUI(){
        //添加控件
        addSubview(userIcon)
        addSubview(vipIcon)
        addSubview(userNameLabel)
        addSubview(levelIcon)
        addSubview(sourceLabel)
        addSubview(timeLabel)
        addSubview(statusLabel)
        
        //约束
        userIcon.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        vipIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(-10)
            make.top.equalTo(userIcon.snp.bottom).offset(-10)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(10)
            make.top.equalTo(userIcon)
        }
        
        levelIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel.snp.right).offset(10)
            make.bottom.equalTo(userNameLabel).offset(-3)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(10)
            make.bottom.equalTo(userIcon)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.bottom.equalTo(userIcon)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userIcon.snp.bottom).offset(10)
            make.left.equalTo(userIcon)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
    }
}


