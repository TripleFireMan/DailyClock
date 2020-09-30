//
//  DKDailyListViewController.swift
//  DailyClock
//
//  Created by 成焱 on 2020/9/30.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class DKDailyListViewController: CYBaseViewController {
    
    lazy var tableView = UITableView()
    lazy var data = DKTargetModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "日志列表"
        self.setupUI()
        self.shouldShowBottomLine = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DKDailyListViewController{
    func setupUI() {
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let statusBarHeigth = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        tableView.frame = CGRect.init(x: 0, y: statusBarHeigth, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - statusBarHeigth)
    }
}

extension DKDailyListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pre = NSPredicate.init(format: "text!=nil")
        let result = data.signModels.filtered(using: pre)
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "DKDailyItemCell"
        var cell:DKDailyItemCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as?
            DKDailyItemCell
        
        let pre = NSPredicate.init(format: "text!=nil")
        let result:NSArray = data.signModels.filtered(using: pre) as NSArray
        
        let item:DKSignModel? = result.object(at: indexPath.row) as? DKSignModel
        if cell == nil {
            cell = DKDailyItemCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellId)
        }
        cell?.sign = item
        cell?.model = self.data
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ss选择了\(indexPath.row)行")
    }
    
}
