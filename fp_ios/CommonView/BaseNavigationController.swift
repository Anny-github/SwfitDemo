//
//  BaseNavigationController.swift
//  fp_ios
//
//  Created by anne on 2017/6/9.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.isHidden = true //隐藏系统导航栏
        self.interactivePopGestureRecognizer?.delegate = nil
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if self.childViewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true
        }
    }
   
}
