//
//  WBPhotoBrowserController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/9.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBPhotoBrowserController: UIViewController {

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
        let photoViewerVC = 
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        self.view.addGestureRecognizer(tap)
    }
    
    func back(){
        self.dismiss(animated: false, completion: nil)
    }
}
