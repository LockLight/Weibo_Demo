//
//  WBCustomKeyBoard.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/14.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

fileprivate class EmotionLayout:UICollectionViewFlowLayout{
    override fileprivate func prepare() {
        super.prepare()
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        itemSize = CGSize(width:screenWidth, height: 150)
    }
}

class WBCustomKeyBoard: UIView {
    //表情的collectionView
    lazy var emotionView:UICollectionView = {
        let emotionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:EmotionLayout())
        
        
        return emotionView
    }()
    
}
