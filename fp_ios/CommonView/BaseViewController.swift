//
//  BaseViewController.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/6.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

// baseviewcontroller


import UIKit


class BaseViewController: UIViewController {

    var navbar:NavBarView!
    let define = Tools()
    var statusView:UIView!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //状态栏
        statusView = UIView(frame: CGRect(x: 0, y: 0, width: SRC_WIDTH, height: 20))
        statusView.backgroundColor = SYS_WHITE
        self.view.addSubview(statusView)
        
        
        self.initNavBarView()//初始化导航栏
    }
    
    func setStatusBarWithColor(_ color:UIColor){
        statusView.backgroundColor = color
    }
    
    //初始化导航栏
    func initNavBarView()
    {
        navbar = NavBarView(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: SRC_WIDTH, height: NAV_BAR_HEIGHT))
        
        self.view.addSubview(navbar)
        
        navbar.leftButton.addTarget(self, action:#selector(BaseViewController.leftbtnPressed(_:)),
            for: UIControlEvents.touchUpInside)
        navbar.backButton.addTarget(self, action:#selector(BaseViewController.backbtnPressed(_:)),
            for: UIControlEvents.touchUpInside)
        self.view.addSubview(navbar)
        
    }
    
    // 左侧按钮事件
    func leftbtnPressed (_ btn:UIButton)
    {
        
    }
    
    // 返回按钮事件  特殊情况下可以重写。
    func backbtnPressed (_ btn:UIButton)
    {
     self.navigationController?.popViewController(animated: true)
    }
    
    
}
