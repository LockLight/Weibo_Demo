//
//  WBComposeController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/11.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import SVProgressHUD

private let identifier = "identifier"
private let maxPictureCount = 7

class WBComposeController: WBRootController {
    
    //数据源数组
    var dataSourceArr:[UIImage] = []
    
    //选中配图cell的Index
    var selectedIndex:Int = 0
    
    //发布微博按钮
    lazy var composeBtn:UIButton = {
        let composeBtn = UIButton(title: "发布", titleColor: UIColor.white, fontSize: 14, bgImage: "new_feature_finish_button", target: self, action: #selector(compose))
        composeBtn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .disabled)
        composeBtn.setTitleColor(UIColor.gray, for: .disabled)
        
        composeBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        return composeBtn
    }()
    
    //输入微博的textView
    var textView:WBTextView = WBTextView()
    
    //底部的toolBar
    lazy var toolBar:UIToolbar = {
        let toolBar = UIToolbar()
        //设置toolBar的背景图片,和阴影图片
        toolBar.setShadowImage(UIImage.pureImage(color: UIColor(white: 0.9, alpha: 0.9)), forToolbarPosition: .any)
        toolBar.setBackgroundImage(UIImage(named: "compose_toolbar_background"), forToolbarPosition: .any, barMetrics: .default)
        
        //设置toolBar的items
        let dictArr:[[String:Any]] = [["image":"compose_mentionbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_trendbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_camerabutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_emoticonbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_keyboardbutton_background", "selector": #selector(changeKeyBoard)]]
        
        var items:[UIBarButtonItem] = []
        //遍历字典创建items
        for dict in dictArr{
            //toolBar图标
            let button = UIButton(title: nil, image: dict["image"] as? String, target: self, action: dict["selector"] as? Selector)
            let btnItem = UIBarButtonItem(customView: button)
            button.sizeToFit()
            
            //分隔图标
            let blankBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            items.append(btnItem)
            items.append(blankBtn)
        }
        
        items.removeLast()
        toolBar.items = items
        
        return toolBar
    }()
    
    //添加图片的视图
    lazy var picView:UICollectionView = {
        //设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: wbStatusStruct.imageHeight, height: wbStatusStruct.imageHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        collectionView.register(WBPicViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
    
        return collectionView
    }()
    
    //记录键盘类型,0-系统键盘  1-自定义键盘
    var keyboardType:Int = 0
    
    //自定义键盘
    lazy var customKeyboard:WBCustomKeyBoard = {
        let myKeyboard = WBCustomKeyBoard(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        myKeyboard.backgroundColor = UIColor(patternImage:UIImage(named:"emoticon_keyboard_background")!)
        return myKeyboard
    }()
    
    //toolBar是否执行动画
    var isAnimation:Bool = true
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.randomColor()
        
        //监听键盘frame变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(notificantion:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}


//MARK: - 事件处理
extension WBComposeController{
    //返回
    func back(){
        dismiss(animated: false, completion: nil)
    }
    
    //发微博
    func compose(){
        SVProgressHUD.show()
        //初始化图片二进制数据
        var imageData:Data?
        
        if(dataSourceArr.count > 0){
            imageData = UIImagePNGRepresentation(dataSourceArr[0])
        }
        
        NetworkTool.shared.uploadStatus(status: (textView.text)!, imageData: imageData) { (response) in
        
            SVProgressHUD.dismiss()
            //收起键盘
            self.textView.resignFirstResponder()
            //延迟一秒弹出
            let deadLineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadLineTime, execute: { 
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    //切换键盘
    func changeKeyBoard(){
        print("点击键盘")
        
        isAnimation = false
        //取消第一响应者,在text输入框使用为隐藏键盘
        textView.resignFirstResponder()
        isAnimation = true
        
        if keyboardType == 0{
            textView.inputView = self.customKeyboard
            keyboardType = 1
        }else{
            textView.inputView = nil
            keyboardType = 0
        }
        
        textView.becomeFirstResponder() //弹出键盘
    }
    
    
    //键盘frame变化通知事件
    func keyboardWillChanged(notificantion:Notification){
        if isAnimation == true {
            if let userInfo = notificantion.userInfo,
                let rect = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval{
                
                let frameEndY = rect.cgRectValue.origin.y
                let offset = frameEndY - screenHeight
                
                //调整toolBar布局
                toolBar.snp.updateConstraints({ (make) in
                    make.bottom.equalTo(self.view).offset(offset)
                })

                //动画强制更新
                UIView.animate(withDuration: duration, animations: { 
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}

extension WBComposeController{
    override func setupUI() {
        //设置导航栏
        setNavigationBar()
        //设置输入微博的textView
        setTextView()
        //设置底部toolBar
        setToolBar()
        //设置添加微博配图的collectionView
        setpicView()
    }
    
    func setpicView(){
        textView.addSubview(picView)
        picView.backgroundColor = UIColor.yellow
        
        picView.snp.makeConstraints { (make ) in
            make.left.equalTo(self.textView.snp.left).offset(10)
            make.top.equalTo(textView.snp.top).offset(100)
            make.size.equalTo(CGSize(width: screenWidth - 20, height:screenWidth - 20))
        }
    }
    
    func setToolBar(){
        view.addSubview(toolBar)
        
        //toolBar自带高度
        toolBar.snp.makeConstraints { (make ) in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setTextView(){
        view.addSubview(textView)
        textView.placeHoder = "Hello,World"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.delegate = self
        textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    func setNavigationBar(){
        //取消按钮
        let cancelBtn = UIButton(title: "取消", titleColor: UIColor.white, fontSize: 14,bgImage: "new_feature_finish_button",target: self, action: #selector(back))
        cancelBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let leftBtn = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem = leftBtn
        
        //发布按钮
        let rightBtn = UIBarButtonItem(customView: composeBtn)
        navigationItem.rightBarButtonItem = rightBtn
        
        composeBtn.isEnabled = false
        
        //设置titleView
        let titleLabel = UILabel(title: nil,alignment: .center)
        let titleText = NSMutableAttributedString(string: "发布微博\n", attributes: [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 16)])
        let userText = NSMutableAttributedString(string: "\(WBUserAccount.shared.screen_name!)", attributes: [NSForegroundColorAttributeName:UIColor.lightGray,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 12)])
        titleText.append(userText)
        titleLabel.attributedText = titleText
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
}

//MARK:- colleciontView的数据源方法
extension WBComposeController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArr.count == maxPictureCount ? maxPictureCount :dataSourceArr.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:identifier, for: indexPath) as! WBPicViewCell
        cell.backgroundColor = UIColor.randomColor()
        cell.delegate = self
        
        if indexPath.item == dataSourceArr.count{
            cell.image = nil
        }else{
            cell.image = dataSourceArr[indexPath.item]
        }
        
        return cell
    }
}

//MARK:- imagePickerController的代理方法
extension WBComposeController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originPic = info[UIImagePickerControllerOriginalImage] as!UIImage
        
        originPic.resizeImage(size:CGSize(width:100,height:100)) { (image) in
            if self.selectedIndex == self.dataSourceArr.count{
                self.dataSourceArr.append(image!)
            }else{
                self.dataSourceArr[self.selectedIndex] = image!
            }
            self.picView.reloadData()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK:- WBPicviewCell的代理方法
extension WBComposeController:WBPicViewCellDelegate{
    func addOrReplacePicView(cell: WBPicViewCell) {
        selectedIndex = (picView.indexPath(for: cell)?.item)!
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func deletePic(cell: WBPicViewCell) {
        let index = (picView.indexPath(for: cell)?.item)!
        
        dataSourceArr.remove(at: index)
        picView.reloadData()
    }
}

//MARK:- textView的代理方法
extension WBComposeController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        composeBtn.isEnabled = textView.text.characters.count > 0
    }
}






