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
    
    var dataSourceArr:[WBStatusViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.register(WBStatusCell.self, forCellReuseIdentifier: identifer)
        self.tableView.rowHeight = 200
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
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
                self.tableView.reloadData()
            }
        }
    }
}


///Mark:- UI相关

extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! WBStatusCell
        let viewModel = dataSourceArr[indexPath.row]
        cell.statusViewModel = viewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
}
