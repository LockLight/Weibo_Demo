//
//  WBStatusPictureView.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/6.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

let baseTag = 777

class WBStatusPictureView: UIView {
    
    var statusViewModel:WBStatusViewModel?{
        didSet{
            //先全部隐藏
            for i in 0..<9{
                let imageView = self.viewWithTag(i+baseTag)
                imageView?.isHidden = true
            }
            //根据数据展示ImageView
            if let pic_urlArr = statusViewModel?.pic_urlArr,pic_urlArr.count > 0{
                var index = 0
                
                for picModel in pic_urlArr{
                    let imageView = self.viewWithTag(index + baseTag) as? UIImageView
                    imageView?.isHidden = false
                    imageView?.wb_setImageView(urlStr: picModel.thumbnail_pic!, placehoder: "avatar_default_big")
                    
                    //有且只有一张图片,等比显示
                    if index == 0 && pic_urlArr.count == 1{
                       imageView?.frame = CGRect(origin: CGPoint.zero, size: (statusViewModel?.picViewSize)!)
                    //多张图片
                    }else if index == 0 && pic_urlArr.count != 1{
                       let imageWH = wbStatusStruct.imageHeight
                       imageView?.frame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
                    }
                    //四张图片的处理
                    if pic_urlArr.count == 4 && index == 1 {
                        index += 1
                    }
                    
                    index += 1
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBStatusPictureView{
    func setupUI(){
        self.clipsToBounds = true
        self.backgroundColor = UIColor.yellow
        //创建9个imageView
        let imageWH = wbStatusStruct.imageHeight
        //下一个imageVIew的偏移量
        let offset = imageWH + wbStatusStruct.margin
        
        for i in 0..<9{
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.yellow
            addSubview(imageView)
            
            imageView.tag = i + baseTag
            
            //行号与列号
            let row = i/3
            let col = i%3
            //原型imageView的frame
            let prototypeFrame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
            let frame = prototypeFrame.offsetBy(dx:CGFloat(row) * offset, dy: CGFloat(col) * offset)
            imageView.frame = frame
            //图片填充模式
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            //添加手势
            imageView.isUserInteractionEnabled = true
            let tap = UIGestureRecognizer(target: self, action: #selector(imgClicked(tap:)))
            imageView.addGestureRecognizer(tap)
        }
    }
}

//MARK: - 事件处理
extension WBStatusPictureView{
    func imgClicked(tap:UIGestureRecognizer){
        let notification = Notification(name: picViewClickNotification)
        NotificationCenter.default.post(notification)
    }
}



