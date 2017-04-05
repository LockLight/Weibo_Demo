//
//  WBNewFeatureView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/5.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()
    
    lazy var pageController:UIPageControl = {
        let pageController = UIPageControl()
        pageController.pageIndicatorTintColor = UIColor.black
        pageController.currentPageIndicatorTintColor = globalColor
        pageController.currentPage = 0
        pageController.numberOfPages = 4
        return pageController
    }()

    override init(frame: CGRect) {
        super.init(frame: screenBounds)
        setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//Mark: UI相关
extension WBNewFeatureView{
    func setupUI() {
        //添加视图
        addSubview(scrollView)
        addSubview(pageController)
        
        //设置scrollView的图片
        for i in 1...4{
            let imageView = UIImageView(imageName: "new_feature_\(i)")
            imageView.frame = screenBounds.offsetBy(dx:CGFloat((i-1))*screenWidth, dy: 0)
            scrollView.addSubview(imageView)
        }
        
        //约束
        pageController.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-100)
        }
        
        //scrollView的contentSize
        scrollView.contentSize = CGSize(width: screenWidth*5, height: screenHeight)
    }
}

//Mark: Scrollview代理
extension WBNewFeatureView:UIScrollViewDelegate{
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        //计算当前页
        let page = Int(offsetX/screenWidth + 0.5)
        pageController.currentPage = page
        
        //隐藏pageController
        pageController.isHidden = offsetX > (screenWidth * 3.4)
        
        //移除新特性页
        if(offsetX >= screenWidth * 4){
            self.removeFromSuperview()
        }
    }
}




