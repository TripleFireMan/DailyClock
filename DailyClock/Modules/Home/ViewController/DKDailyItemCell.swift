//
//  DKDailyItemCell.swift
//  DailyClock
//
//  Created by 成焱 on 2020/9/30.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

@objcMembers
class DKDailyItemCell: UITableViewCell {
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var messageLabel = UILabel()
    var img = UIImageView()
    var line = UIView()
    var sign : DKSignModel?{
        willSet(model){
            self.nameLabel.text = model?.text
            self.dateLabel.text = ((model?.date ?? Date()) as NSDate).string(withFormat: "MM-dd hh:mm")
            self.messageLabel.text = model?.text
        }
    }
    
    var model:DKTargetModel?{
        willSet(newobj){
            self.nameLabel.text = newobj!.title
            self.img.image = UIImage.init(named: newobj!.icon)
        }
    }
    
    func setup(){
        self.img = UIImageView.init()
        
        self.nameLabel = UILabel.init()
        self.nameLabel.font = DKThemeFont(15)
        if #available(iOS 13.0, *) {
            self.nameLabel.textColor = UIColor.label
        } else {
            self.nameLabel.textColor = UIColor.black
        }

        self.dateLabel = UILabel.init()
        self.dateLabel.font = DKThemeFont(14)
        if #available(iOS 13.0, *) {
            self.dateLabel.textColor = UIColor.tertiaryLabel
        } else {
            // Fallback on earlier versions
            self.dateLabel.textColor = UIColor.lightText
        }
        self.messageLabel = UILabel.init()
        self.messageLabel.numberOfLines = 0
        self.messageLabel.font = DKThemeFont(13)
        
        self.messageLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        if #available(iOS 13.0, *) {
            self.messageLabel.textColor = UIColor.secondaryLabel
        } else {
            self.messageLabel.textColor = UIColor.gray
        }
        self.line = UIView()
        self.line.backgroundColor = DKIOS13ContainerColor()
        
        self.contentView.addSubview(self.img)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.line)
        
        self.img.snp.makeConstraints { (maker) in
            maker.left.equalTo(15)
            maker.top.equalTo(30)
            maker.width.height.equalTo(30)
            maker.bottom.lessThanOrEqualTo(-30)
        }
        self.nameLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(self.img.snp_right).offset(15)
            ConstraintMaker.top.equalToSuperview().offset(20)
        }
        
        self.dateLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-15)
            maker.centerY.equalTo(self.nameLabel)
        }
        
        self.messageLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.nameLabel.snp_bottom).offset(10)
            maker.left.equalTo(self.nameLabel)
            maker.right.equalTo(-15)
            maker.bottom.lessThanOrEqualTo(-15)
        }
        self.line.snp.makeConstraints { (maker) in
            maker.right.bottom.equalToSuperview()
            maker.left.equalTo(15)
            maker.height.equalTo(1/UIScreen.main.scale)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DKDailyItemCell{
    
}
