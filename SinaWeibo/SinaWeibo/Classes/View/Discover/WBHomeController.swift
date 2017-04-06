//
//  WBHomeController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/2.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit

fileprivate let identifer = "homeCell"

class WBHomeController: WBRootController {
    
    var dataSourceArr:[WBStatusModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifer)
        loadData()
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
            since_id = dataSourceArr.first?.id ?? 0
        }else{
            max_id = dataSourceArr.last?.id ?? 0
            isPullDown = false
        }
        
        NetworkTool.shared.requestHomeStaus(since_id: since_id, max_id: max_id) { (responseObject) in
            if var statusModelArr = responseObject as? [WBStatusModel]{
                if isPullDown == true{
                    self.dataSourceArr = statusModelArr + self.dataSourceArr
                    self.refreshHeader.endRefreshing()
                }else{
                    statusModelArr.removeFirst()
                    self.dataSourceArr += statusModelArr
                    self.refreshFooter.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }
    }
}


//Mark:- UI相关

extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        cell.textLabel?.text = dataSourceArr[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
}
