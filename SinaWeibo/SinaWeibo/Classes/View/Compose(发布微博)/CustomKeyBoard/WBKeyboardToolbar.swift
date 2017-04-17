//
//  WBKeyboardToolbar.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/14.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

fileprivate let baseTag = 88

protocol WBKeyboardToolbarDelegate:NSObjectProtocol {
    func toggleKeyobard(section:Int)
}

class WBKeyboardToolbar: UIStackView {
    weak var delegate:WBKeyboardToolbarDelegate?
    
    //记录选中的btn
    var selectedButton: UIButton?
    
    //选中btn的Index
    var selectedIndex:Int = 0 {
        didSet{
            let selectedTag = selectedIndex + baseTag
            let button = self.viewWithTag(selectedTag) as! UIButton
            button.isSelected = true
            selectedButton = button
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //水平 平均
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        setupUI()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WBKeyboardToolbar{
    func setupUI () {
        let buttonDicArr: [[String: Any]] = [["title": "最近", "image": "left"],
                                             ["title": "默认", "image": "mid"],
                                             ["title": "emoji", "image": "mid"],
                                             ["title": "浪小花", "image": "right"]]
        
        //compose_emotion_table_left_normal
        for (index, dic) in buttonDicArr.enumerated() {
            let title = dic["title"] as! String
            let imageName = dic["image"] as! String
            let normalImageName = "compose_emotion_table_\(imageName)_normal"
            let selectedImage = UIImage(named: "compose_emotion_table_\(imageName)_selected")
            
            let button = UIButton(title: title, titleColor: UIColor.white, fontSize: 16, bgImage: normalImageName, target: self, action: #selector(toggleKeyobard(button:)))
            //设置button的选中状态的文字和背景图片
            button.setTitleColor(UIColor.darkGray, for: .selected)
            button.setBackgroundImage(selectedImage, for: .selected)
            
            button.tag = index + baseTag
            
            //按下标顺序添加到视图
            addArrangedSubview(button)
            
            if index == 0 {
                button.isSelected = true
                selectedButton = button
            }
        }
    }
}

extension WBKeyboardToolbar{
    func toggleKeyobard(button:UIButton){
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        delegate?.toggleKeyobard(section: button.tag - baseTag)
    }
}

