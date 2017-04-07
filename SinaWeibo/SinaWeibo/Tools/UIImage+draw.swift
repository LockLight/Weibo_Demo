//
//  UIImage+draw.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UIImage {
    class func pureImage(color: UIColor = UIColor.white, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        //1. 开始图形上下文
        UIGraphicsBeginImageContext(size)
        
        //2. 设置颜色
        color.setFill()
        
        //3. 颜色填充
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        
        //4. 从图形上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //5. 关闭图形上下文
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func createCircleImage(color:UIColor = UIColor.yellow ,size:CGSize = CGSize.zero,callBack:@escaping (UIImage) -> ()){
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            //开始图形上下文
            UIGraphicsBeginImageContext(size)
            
            //设置填充颜色
            color.setFill()
            UIRectFill(rect)
            
            //绘制圆形
            let path = UIBezierPath(ovalIn: rect)
            path.addClip()
            
            self.draw(in: rect)
            
            //从上下文获取图像
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //关闭上下文
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
               callBack(image!)
            }
        }
    }
}
