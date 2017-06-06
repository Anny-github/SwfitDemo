//
//  NavBarView.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/6.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

//导航栏 

import UIKit

class NavBarView: UIView {
    
    var leftButton:UIButton!//左侧按钮
    var backButton:UIButton!//返回按钮
    var rightButton:UIButton! //右侧按钮
    var titleLabel:UILabel!//中间标题
    var backgroundImageView:UIImageView!//导航栏背景图片
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.backgroundColor = SYS_WHITE
        
        //导航栏背景图片
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.width, height: 44))
        //backgroundImageView.image =
        //backgroundImageView.backgroundColor =
        self.addSubview(backgroundImageView)
        
        //左侧按钮
        leftButton = UIButton(type: .custom)
        leftButton.frame = CGRect(x: 10, y: 0, width: 44, height: 44)
        leftButton.setImage(UIImage(named: ""), for: UIControlState())
        self.addSubview(leftButton)
        
        //右侧按钮
        rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: self.width-50, y: 0, width: 44, height: 44)
        self.addSubview(rightButton)
        
        //返回按钮
        backButton = UIButton(type: .custom) 
        backButton.frame = CGRect(x: 5, y: 0, width: 50, height: 44)
        backButton.setImage(NaBar_ReturnImg, for:UIControlState())
        self.addSubview(backButton)
        
        //中间标题
        titleLabel = UILabel(frame: CGRect(x: (self.width-100)/2, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        //设置可见与否
        leftButton.isHidden == true
        rightButton.isHidden = true
        backButton.isHidden = false
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
