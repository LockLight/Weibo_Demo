//
//  WBPhotoViewerController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/9.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import SDWebImage

class WBPhotoViewerController: UIViewController {
    //大图为scrollView
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: screenBounds)
        return scrollView
    }()
    
    lazy var imageView:UIImageView = UIImageView()
    
    
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
        self.view.backgroundColor = UIColor.white

        print("第\(index)张图片,url地址是\(pic_urlArr[index])")
        setupUI()
    }
}

extension WBPhotoViewerController{
    func setupUI(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        //异步下载展示图片
        let url = URL(string: pic_urlArr[index])
        print("----\(url!)----")
        SDWebImageManager.shared().downloadImage(with: url!, options: [], progress: nil) { (middelImg, _,_, _, _) in
            if let middelImg = middelImg{
                //下载完成后设置给当前的imageView
                self.imageView.image = middelImg
                
                let imgSize = middelImg.size
                
                //调整比例: 新高/新宽 = 原高/原宽
                let newWidth = screenWidth
                let newHeight = imgSize.height/imgSize.width * newWidth
                
                let newSize = CGSize(width: newWidth, height: newHeight)
                
                //设置调整后的imageView的frame 
                let frame = CGRect(origin: CGPoint.zero, size: newSize)
                self.imageView.frame = frame
                
                //当图片的高度小于当前屏幕高度
                if newHeight <= screenHeight{
                    self.imageView.center = self.scrollView.center
                }else{
                    self.scrollView.contentSize = newSize
                }
            }
        }
    }
}
