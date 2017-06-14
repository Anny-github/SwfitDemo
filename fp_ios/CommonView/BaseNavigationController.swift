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
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        self.navigationBar.barTintColor = Tools.colorFromRGB(0x44ced8)
        self.navigationBar.tintColor = UIColor.white //返回按钮
        
        self.interactivePopGestureRecognizer?.delegate = nil

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if self.childViewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true

        }
    }
    
   
}
