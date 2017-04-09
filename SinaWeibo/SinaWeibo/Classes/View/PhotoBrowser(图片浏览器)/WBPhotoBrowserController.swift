//
//  WBPhotoBrowserController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/9.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBPhotoBrowserController: UIViewController {
    
    //当前展示图片的index
    var index:Int = 0
    
    //图片的url数组
    var pic_urlArr:[String] = []
    
    //重载构造函数,设置所需参数
    init(index:Int, pic_urlArr:[String]){
        super.init(nibName: nil, bundle: nil)
        
        self.index = index
        self.pic_urlArr = pic_urlArr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.randomColor()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WBPhotoBrowserController{
    func setupUI(){
        //创建分页控制器
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:20])
        
        //添加到当前控制器
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.didMove(toParentViewController: self)
        
        //设置分页控制器的子控制器
        let photoViewerVC = WBPhotoViewerController(index: index, pic_urlArr: pic_urlArr)
        pageVC.setViewControllers([photoViewerVC], direction: .forward, animated: true, completion: nil)
        
        pageVC.dataSource = self
        

        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        self.view.addGestureRecognizer(tap)
    }
    
    func back(){
        self.dismiss(animated: false, completion: nil)
    }
}

//MARK - 分页控制器的数据源方法
extension WBPhotoBrowserController:UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! WBPhotoViewerController).index
        
        //到头
        if(currentIndex == 0){
            return nil
        }
        
        let photoViewer = WBPhotoViewerController(index: currentIndex - 1, pic_urlArr: pic_urlArr)
        return photoViewer
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! WBPhotoViewerController).index
        
        //到尾
        if(currentIndex == pic_urlArr - 1){
            return nil
        }
    
        let photoViewer = WBPhotoViewerController(index: currentIndex + 1, pic_urlArr: pic_urlArr)
        return photoViewer
    }
}
