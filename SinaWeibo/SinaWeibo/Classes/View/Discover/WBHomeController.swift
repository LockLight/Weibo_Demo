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
    //模型数据源
    var statusListViewModel:WBStatusListViewModel = WBStatusListViewModel()
    
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
        let userInfo = notify.userInfo
        
        let index = userInfo?["index"] as! Int
        let picUrlArr = userInfo?["picUrlArr"] as! [String]
        
        let photoBrowser = WBPhotoBrowserController(index: index, pic_urlArr: picUrlArr)
        present(photoBrowser, animated: false, completion: nil)
    }
}

extension WBHomeController{
    override func loadData(){

        //定义当前下拉状态
        var isPullDown = true
        
        //根据刷新状态设定bool值
        if refreshHeader.isRefreshing(){
            isPullDown = true
        }else{
            isPullDown = false
        }
        
//        let updateUIClousure = {
//            (isSuccess:Bool) in
//            if isSuccess{
//                self.tableView.reloadData()
//                if isPullDown == true {
//                    self.refreshHeader.endRefreshing()
//                }else{
//                    self.refreshFooter.endRefreshing()
//                }
//            }else{
//                if isPullDown == true {
//                    self.refreshHeader.endRefreshing()
//                }else{
//                    self.refreshFooter.endRefreshing()
//                }
//            }
//        }
//        self.statusListViewModel.loadData(isPullDown: isPullDown, callBack: updateUIClousure)
        self.statusListViewModel.loadData(isPullDown: isPullDown) { (isSuccess) in
            if isSuccess{
                self.tableView.reloadData()
                if isPullDown == true {
                    self.refreshHeader.endRefreshing()
                }else{
                    self.refreshFooter.endRefreshing()
                }
            }else{
                if isPullDown == true {
                    self.refreshHeader.endRefreshing()
                }else{
                    self.refreshFooter.endRefreshing()
                }
            }
       }
    }
}


///Mark:- UI相关
extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! WBStatusCell
        let viewModel = statusListViewModel.dataSourceArr[indexPath.row]
        cell.statusViewModel = viewModel
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.dataSourceArr.count
    }
}
