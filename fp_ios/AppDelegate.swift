//
//  AppDelegate.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/6.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit
import ObjectMapper
import  UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
       
//        self.addLoginController()
        self.addTabBarController()
        
        self.registRemoteNotification()
        self.addLocationNotification()
        //MARK: 注册登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(addTabBarController), name: NSNotification.Name(rawValue:NOFI_LOGINSUCCESS), object: nil)
        //MARK: 网络监听
        SystemHelper.shared().networkMonitor()
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
//TODO: =======推送
    func registRemoteNotification() {
            if #available(iOS 10.0, *) {
                
                let notifiCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
                notifiCenter.delegate = self
                let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
                notifiCenter.requestAuthorization(options: types) { (flag, error) in
                    if flag {
                        print("ios request notification success")
                    }else{
                        print(" iOS 10 request notification fail")
                    }
                }
                
                
            } else {
                let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(setting)
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(userSettings)
                }
            }
            
    }
    
    func addLocationNotification(){
        
        if #available(iOS 10.0, *) {
            
            let notifiCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
            notifiCenter.delegate = self
            let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
            notifiCenter.requestAuthorization(options: types) { (flag, error) in
                if flag {
                    let attachment = try? UNNotificationAttachment.init(identifier: "LocalTFImg", url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "shibai", ofType: "png")!), options: nil)
                    let notificationContent:UNMutableNotificationContent = UNMutableNotificationContent.init()
                    notificationContent.attachments = [attachment!]
                    notificationContent.body = "测试iOS10本地推送";
                    notificationContent.categoryIdentifier = "local_Nf";
                    notificationContent.title = "应试宝";
                    //本地通知想推送不同内容  只能重新添加
                    notificationContent.subtitle = "每次通知能不能刷新显示数据---\(arc4random())";
                    notificationContent.launchImageName = "shibai.png";
                    //content.sound = [UNNotificationSound defaultSound];
                    notificationContent.sound = nil;
                    var dateComponent = DateComponents.init()
                    dateComponent.second = 10
                    let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponent, repeats: true)
                    
                    let request = UNNotificationRequest.init(identifier: "localTf", content: notificationContent, trigger: trigger)
                    notifiCenter.add(request, withCompletionHandler: { (error) in
                        if error == nil {
                            TSLog("本地推送 添加成功")
                        }else{
                            TSLog("本地推送 添加失败")
                            
                        }
                    })
                }else{
                    print(" iOS 10 request notification fail")
                }
            }
            
            
        } else {
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(userSettings)
            }
        }

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

