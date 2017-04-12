//
//  WBTextView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/12.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBTextView: UITextView {
    
    //占位文字
    var placeHoder:String = "请输入文字..."{
        didSet{
            placeHoderLabel.text = placeHoder
        }
    }
    
    //重写font属性
    override var font:UIFont?{
        didSet{
            placeHoderLabel.font = font
        }
    }
    
    //占位label
    lazy var placeHoderLabel:UILabel={
        let pLabel = UILabel(title: nil, textColor: UIColor.lightGray, fontSize: 14)
        pLabel.font = self.font
        return pLabel
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupUI()
        
        //接收系统通知,监听textView的text长度
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: Notification.Name.UITextViewTextDidChange, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 事件处理
extension WBTextView{
    func textDidChange(){
        placeHoderLabel.isHidden = self.text.characters.count > 0
    }
}


//MARK: - 设置UI
extension WBTextView{
    func setupUI(){
        self.keyboardDismissMode = .onDrag
        self.backgroundColor = UIColor.randomColor()
        
        addSubview(placeHoderLabel)
        let view  = UIView()
        view.backgroundColor = UIColor.yellow
        insertSubview(view, at: 0)
        
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(self)
        }
        
        placeHoderLabel.snp.makeConstraints { (make ) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.equalTo(self).offset(8)
        }
    }
}
