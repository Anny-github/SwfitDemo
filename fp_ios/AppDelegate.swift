//
//  AppDelegate.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/6.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
       
//        self.addLoginController()
        self.addTabBarController()
        
        //MARK: 注册登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(addTabBarController), name: NSNotification.Name(rawValue:NOFI_LOGINSUCCESS), object: nil)
        //MARK: 网络监听
        SystemHelper.shared().networkMonitor()
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
//TODO: 根视图控制器
    func addTabBarController()
    {
        // tabBarItem上是一个navcontroller
        
        let vc3 = MyInfoViewController()
        let nav3 = BaseNavigationController(rootViewController: vc3)
        nav3.tabBarItem = self.initTabBarItem("", image: Tab_MeImg_NoSelect!, selectImage: Tab_MeImg_Select!)
        
        
        let arr = [nav3]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = arr
        tabBarController.selectedIndex = 0
        self.window?.rootViewController = tabBarController
        
    }
    
    func initTabBarItem(_ titleStr:String,image:UIImage,selectImage:UIImage)->UITabBarItem{
        
        let tabbarItem:UITabBarItem = UITabBarItem(title: titleStr, image: image, selectedImage: selectImage)
        tabbarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        return tabbarItem
        
    }
    
    
    //  登录
    func addLoginController()
    {
        let loginVC = RegLoginViewController()
        let navi:UINavigationController = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = navi
    }
    
    
//TODO: ApplicationDelegate function
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UIScreen.main.brightness = 1.0

        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

