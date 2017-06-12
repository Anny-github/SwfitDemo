//
//  SystemHelper.swift
//  SwiftTool
//
//  Created by wss on 15/10/12.
//  Copyright © 2015年 WSS. All rights reserved.

//Reachability https://github.com/tonymillion/Reachability


import Foundation
import UIKit
import SVProgressHUD
import ReachabilitySwift


/** 设备名称 */
let deviceName = UIDevice.current.name
/** 设备系统名称*/
let deviceSystemName = UIDevice.current.systemName
/** 设备系统版本*/
let systemVersion = UIDevice.current.systemVersion
/** 设备模型*/
let deviceModel = UIDevice.current.model
/** 设备本地模型 */
let deviceLocalModel = UIDevice.current.localizedModel


private let systemInstance: SystemHelper = SystemHelper()



class SystemHelper:NSObject {
    var reach:Reachability!
    
    override init() {
        super.init()
        self.reach = Reachability()
    }
    
    class func shared() -> SystemHelper {
        return systemInstance
    }
    
    //MARK: /** app版本 */
    var appVersion:String{
        let info = Bundle.main.infoDictionary!
        return info["CFBundleShortVersionString"] as! String
    }
    
    // 获取系统版本
    class func systemVersion()->Int{
        let current = UIDevice.current
        let version = current.systemVersion
        let arr = version.components(separatedBy: ".")
        let systemV: String = arr[0]
        let x:Int = Int(systemV)!
        
        // let num:Int = systemV.intValue // int32 is not convertible to int
        return x
    }
    
    //TODO: 网络监听
    func networkMonitor(){
//        self.reach = Reachability()!
        // 1、设置网络状态消息监听 2、获得网络Reachability对象
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification, object: self.reach)
        do{
            // 3、开启网络状态消息监听
            try self.reach.startNotifier()
        }catch{
            TSLog("could not start reachability notifier")
        }
    }
    //    // 移除消息通知
    //    deinit {
    //        // 关闭网络状态消息监听
    //        self.reach.stopNotifier()
    //        // 移除网络状态消息通知
    //        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: self.reach)
    //    }
    
    // 主动检测网络状态
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability // 准备获取网络连接信息
        
        if reachability.isReachable { // 判断网络连接状态
            TSLog("网络连接：可用")
            if reachability.isReachableViaWiFi { // 判断网络连接类型
                TSLog("连接类型：WiFi")
            } else {
                TSLog("连接类型：移动网络")
            }
        } else {
            TSLog("网络连接：不可用")
            DispatchQueue.main.async { // 不加这句导致界面还没初始化完成就打开警告框，这样不行
//                self.alert_noNetwrok() // 警告框，提示没有网络
            }
        }
    }
    func isNetReachable() -> Bool{
        return self.reach.isReachable
    }
    

    // 警告框，提示没有连接网络 *********************
    func alert_noNetwrok() -> Void {
        let alert = UIAlertController(title: "系统提示", message: "请打开网络连接", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(cancelAction)
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController?.present(alert, animated: true, completion: nil)
    }

    
}
