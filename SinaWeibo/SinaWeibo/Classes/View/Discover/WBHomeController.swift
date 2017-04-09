//
//  WBHomeController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/2.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import SDWebImage

fileprivate let identifer = "homeCell"

class WBHomeController: WBRootController {
    
    var dataSourceArr:[WBStatusViewModel] = []
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WBStatusCell.self, forCellReuseIdentifier: identifer)
        loadData()
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoBrowser(notify:)), name: picViewClickNotification, object: nil)
    }
}

//MARK: - 处理事件
extension WBHomeController{
    func showPhotoBrowser(notify:Notification){
        let photoBrowser = 
    }
}

extension WBHomeController{
    override func loadData(){
        //设置初始id值,since_id 下拉刷新需要的id  max_id 上拉刷新需要的id
        var since_id:Int64 = 0
        var max_id:Int64 = 0
        //定义当前下拉状态
        var isPullDown = true
        
        
        if refreshHeader.isRefreshing(){
            since_id = dataSourceArr.first?.statusModel.id ?? 0
        }else{
            max_id = dataSourceArr.last?.statusModel.id ?? 0
            isPullDown = false
        }
        
        NetworkTool.shared.requestHomeStaus(since_id: since_id, max_id: max_id) { (responseObject) in
            if let statusModelArr = responseObject as? [WBStatusModel]{
                var viewModelArr:[WBStatusViewModel] = []
                for model in statusModelArr{
                    let viewModel = WBStatusViewModel(statusModel: model)
                    viewModelArr.append(viewModel)
                }
                
                if isPullDown == true{
                    self.dataSourceArr = viewModelArr + self.dataSourceArr
                    self.refreshHeader.endRefreshing()
                }else{
                    if viewModelArr.count > 0{
                        viewModelArr.removeFirst()
                    }
                    self.dataSourceArr += viewModelArr
                    self.refreshFooter.endRefreshing()
                }
//                self.tableView.reloadData()
                //刷新数据前需处理好所有图片的下载,以及图片比例的调整
                self.dealWithSinglePic(viewModelArr: viewModelArr, callback: { (isCompletion) in
                    
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func dealWithSinglePic(viewModelArr:[WBStatusViewModel],callback:@escaping (Bool) -> ()){
        //创建调度组
        let group = DispatchGroup()
        //遍历模型数组,异步下载单张图片,并调整比例
        for viewModel in viewModelArr{
            if let pic_urlArr = viewModel.pic_urlArr,pic_urlArr.count == 1{
                group.enter()
                let urlStr = pic_urlArr[0].thumbnail_pic
                let url = URL(string: urlStr!)
                
                //异步下载
                SDWebImageManager.shared().downloadImage(with: url!, options: [], progress: nil, completed: { (singleImage, _, _, _, _) in
                    if let singleImage = singleImage{
                        var imgSize =  singleImage.size
                        
                        //当图片宽度超过屏幕约束宽度
                        if imgSize.width > screenWidth - 20{
                            let newWidth = screenWidth - 60
                            imgSize.height = imgSize.height/imgSize.width * newWidth
                            imgSize.width = newWidth
                        }
                        print(imgSize)
                        viewModel.picViewSize = imgSize
                        
                        group.leave()
                    }
                })
            }
        }
        group.notify(queue: DispatchQueue.main) { 
            callback(true)
        }
    }
    
}


///Mark:- UI相关
extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! WBStatusCell
        let viewModel = dataSourceArr[indexPath.row]
        cell.statusViewModel = viewModel
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
}
