//
//  WBCustomKeyBoard.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/14.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

fileprivate let indentifier = "indentifier"

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
    //数据源
    var dataSourceArr = [[1, 2, 3], [1, 2], [1, 2, 3, 4], [1, 2]]
    
    //表情的collectionView
    lazy var emotionView:UICollectionView = {
        let emotionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:EmotionLayout())
        emotionView.delegate = self
        emotionView.dataSource = self
        emotionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: indentifier)
        emotionView.showsHorizontalScrollIndicator = false
        emotionView.isPagingEnabled = true
        
        return emotionView
    }()
    
    //切换表情类的toolBar
    lazy var keyboardToolBar:WBKeyboardToolbar = {
        let toolbar = WBKeyboardToolbar()
        toolbar.delegate = self
        return toolbar
    }()
    
    //分页控制器
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.isEnabled = false
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKey: "_pageImage") //默认的小图片
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage") //选中的小图片
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBCustomKeyBoard:WBKeyboardToolbarDelegate{
    func toggleKeyobard(section: Int) {
        let indexpath = IndexPath(item: 0, section: section)
        emotionView.scrollToItem(at: indexpath, at: .left, animated: false)
        setupPageControl(indexPath: indexpath)
    }
}

extension WBCustomKeyBoard:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        //获取当前偏移局域内的所有cell信息
        let x = proposedContentOffset.x
        let y = proposedContentOffset.y
        let w = screenWidth   
        let h = emotionView.bounds.size.width
        
        //获取当前偏移区域内cell的布局信息
        let arrList:[UICollectionViewLayoutAttributes] = UICollectionViewLayout.layoutAttributesForElements(EmotionLayout)
        
        
        //获取当前中心参照点
        let center = proposedContentOffset.x + screenWidth;
        
        //设置最小距离
        let minDistance = center - arrList[0].center.x;
        
        //遍历布局数组 计算最小距离
        for (NSInteger i = 1; i < arrList.count; i++) {
            CGFloat currentDistance = center - arrList[i].center.x;
            if(ABS(currentDistance) < ABS(minDistance)){
                minDistance = currentDistance;
            }
        }
        
        //返回距离中心最近的cell的坐标
        return CGPointMake(x - minDistance, y);
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArr[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = emotionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        cell.contentView.viewWithTag(55)?.removeFromSuperview()
        let lable = UILabel(title: "section:\(indexPath.section), item:\(indexPath.item)", fontSize: 40, alignment: .center)
        lable.sizeToFit()
        lable.tag = 55
        lable.center = cell.contentView.center
        cell.contentView.addSubview(lable)
        return cell
    }
}

//MARK: - UI相关
extension WBCustomKeyBoard{
    func setupUI(){
        addSubview(emotionView)
        addSubview(keyboardToolBar)
        addSubview(pageControl)
        
        emotionView.backgroundColor = UIColor.white
        keyboardToolBar.backgroundColor = UIColor.yellow
        
        emotionView.snp.makeConstraints { (make) in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(150)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(emotionView.snp.bottom)
            make.height.equalTo(29)
            make.left.right.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        keyboardToolBar.snp.makeConstraints { (make ) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(36)
        }
    }
    
    func setupPageControl(indexPath: IndexPath) {
        pageControl.numberOfPages = dataSourceArr[indexPath.section].count
        pageControl.currentPage = indexPath.item
    }
}




