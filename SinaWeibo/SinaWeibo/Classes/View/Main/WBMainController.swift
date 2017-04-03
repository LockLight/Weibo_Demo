//
//  WBMainController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/2.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

class WBMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - 设置UI
extension WBMainController{
    func setupUI (){
        self.view.backgroundColor = UIColor.white
        //添加子控制器
        addViewControllers()
        //添加发布按钮
        
    }
    func setComposeBtn(){
        let btn = UIButton()
    }
    
    
    //添加子控制器
    func addViewControllers (){
        if let url = Bundle.main.url(forResource:"main.json", withExtension: nil),
            let jsonData = try? Data(contentsOf: url),
            let data = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let dictArr = data as? [[String:Any]]{
            
            //创建空数组
            var controllers:[UINavigationController] = []
            //遍历字典数组创建控制器
            for dic in dictArr{
                let nav = createSingleController(dict: dic)
                controllers.append(nav!)
            }
            self.viewControllers = controllers
        }
    }
    
    func createSingleController(dict: [String: Any]) -> UINavigationController? {
        if let clsName = dict["clsName"]{
            print(clsName)
            //拼接完整类名
            let className = "SinaWeibo." + "\(clsName as! String)"
            if let cls = NSClassFromString(className) as? WBRootController.Type{
                //创建控制器
                let controller = cls.init()
    
                //设置标题 tabbaritem图片
                let title = dict["title"] as? String
                controller.title = title
                controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.darkGray], for: .normal)
                controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
                
                if let imageName = dict["imageName"] {
                    let image = UIImage(named:"tabbar_\(imageName)")?.withRenderingMode(.alwaysOriginal)
                    let selectedImage = UIImage(named:"tabbar_\(imageName)_selected")?.withRenderingMode(.alwaysOriginal)
                    
                    controller.tabBarItem.image = image
                    controller.tabBarItem.selectedImage = selectedImage
                
                    print(controller)
                }
                let nav = UINavigationController(rootViewController: controller)
                return nav
            }
        }
        return nil
    }
}
