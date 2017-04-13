//
//  UIImage+draw.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UIImage {
    //图片平铺
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
    
    //绘制圆角头像
    func createCircleImage(color:UIColor = UIColor.white ,size:CGSize = CGSize.zero,callBack:@escaping (UIImage) -> ()){
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
    
    //根据当前上下文裁剪图片,以压缩大小
    func resizeImage(color:UIColor = UIColor.white,size:CGSize = CGSize(width: 1, height: 1),callBack: @escaping (UIImage?) -> ()){
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            UIGraphicsBeginImageContext(size)
            
            color.setFill()
            UIRectFill(rect)
            
            self.draw(in: rect)
            
            let image =  UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
               callBack(image)
            }
        }
    }
    
}
