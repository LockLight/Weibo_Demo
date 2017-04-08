//
//  WBRootController.swift
//  SinaWeibo
//
//  Created by locklight on 17/4/2.
//  Copyright © 2017年 LockLight. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate let identifier = "identifer"

class WBRootController: UIViewController {
    //下拉刷新控件
    lazy var refreshHeader:MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
    //上拉刷新控件
    lazy var refreshFooter:MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadData))
    
    
    /// tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        //自动行高
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        tableView.backgroundColor = UIColor.white
        //设置tableview离顶部的边距
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
        
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()

    var visitorView: WBVisitorController?
    
    //访客的图片和label 字典
    var visitorInfo:[String:Any]?
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.separatorStyle = .none
        
        self.tableView.mj_header = refreshHeader
        self.tableView.mj_footer = refreshFooter
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: loginSuccessNotification, object: nil)
    }
}

//MARK: - 事件处理
extension WBRootController{
    func loginSuccess(){
        print("登录成功")
        visitorView?.removeFromSuperview()
        visitorView = nil
    }
    
    func loadData(){
        print("hello,world")
    }
}


//MARK: - 设置UI
extension WBRootController {
    func setupUI() {
        setupTableView()
        setVisitorView()
    }
    
    /// 设置tableView
    func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    func setVisitorView(){
        if WBUserAccount.shared.isLogin == false{
            visitorView = WBVisitorController(frame: self.view.bounds)
            visitorView?.visitorInfo = self.visitorInfo
            visitorView?.delegate = self
            self.view.addSubview(visitorView!)
        }
    }
}

//MARK: - 访客视图的代理方法
extension WBRootController:WBVisitorControllerDelegate{
    func login() {
        let loginController = WBLoginController()
        let loginNav = UINavigationController(rootViewController: loginController)
        present(loginNav, animated: true, completion: nil)
    }
}

//MARK: - tableView的数据源
extension WBRootController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}






