//
//  WBPicViewCell.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/12.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

protocol WBPicViewCellDelegate :NSObjectProtocol{
    func addOrReplacePicView(cell:WBPicViewCell)
    func deletePic(cell:WBPicViewCell)
}


class WBPicViewCell: UICollectionViewCell {
    //代理属性
    weak var delegate:WBPicViewCellDelegate?
    
    //图片属性
    var image:UIImage?{
        didSet{
            if let image = image {
                addOrReplaceBtn.setBackgroundImage(image, for: .normal)
                addOrReplaceBtn.setBackgroundImage(image, for: .highlighted)
            }else{
                addOrReplaceBtn.setBackgroundImage(UIImage(named:"compose_pic_add"), for: .normal)
             addOrReplaceBtn.setBackgroundImage(UIImage(named:"compose_pic_add_highlighted"),for: .highlighted  )
            }
            deleteBtn.isHidden = image == nil
        }
    }
    
    //添加或替换图片的btn
    lazy var addOrReplaceBtn:UIButton = UIButton(title: nil,  bgImage: "compose_pic_add", target: self, action: #selector(addOrReplacePicView))
    
    //删除图片的btn
    lazy var deleteBtn:UIButton = UIButton(title: nil,  bgImage: "compose_photo_close", target: self, action: #selector(deletePic))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBPicViewCell{
    func addOrReplacePicView(){
        self.delegate?.addOrReplacePicView(cell: self)
    }
    
    func deletePic(){
        self.delegate?.deletePic(cell: self)
    }
}



extension WBPicViewCell{
    func setupUI(){
        addSubview(addOrReplaceBtn)
        addSubview(deleteBtn)
        
        addOrReplaceBtn.snp.makeConstraints { (make ) in
            make.top.left.equalTo(self.contentView).offset(10)
            make.right.bottom.equalTo(self.contentView).offset(-10)
        }
        
        deleteBtn.snp.makeConstraints { (make ) in
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.snp.right).offset(-3)
        }
    }
}

