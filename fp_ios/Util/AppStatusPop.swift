//
//  AppStatusPop.swift
//  fp_ios
//
//  Created by anne on 2017/6/12.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit
import SVProgressHUD

class AppStatusPop: NSObject {

    
    class func show() {
        SVProgressHUD.show(withStatus: nil)
    }
    
    class func showWithMaskType(_ maskType:SVProgressHUDMaskType) {
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.show()
    }
    
    class func showWithStatus(status:String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showWithStatus(status:String,maskType:SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showProgress(progress:Float) {
        SVProgressHUD.showProgress(progress, status: nil)
    }
    
    class func showProgress(progress:Float,maskType:SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.showProgress(progress, status: nil)
    }
    
    class func showProgress(progress:Float,status:String){
        SVProgressHUD.showProgress(progress, status: status)
    }
    
    class func showProgress(progress:Float,status:String,maskType:SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(maskType)

        SVProgressHUD.showProgress(progress, status: status)
    }
    
    
//MARK:  ---- Show, then automatically dismiss methods
    
    class func showInfoWithStatus(status:String) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    class func showInfoWithStatus(status:String,maskType:SVProgressHUDMaskType) {
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    class func showSuccessWithStatus(status:String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    class func showSuccessWithStatus(status:String,maskType:SVProgressHUDMaskType) {
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.showSuccess(withStatus: status)

    }
    
    class func showErrorWithStatus(_ status:String) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    class func showErrorWithStatus(status:String,maskType:SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.showError(withStatus: status)
    }
    
    class func showImage(image:UIImage,status:String){
        SVProgressHUD.show(image, status: status)
    }
    
    class func showImage(image:UIImage,status:String,maskType:SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.show(image, status: status)
    }
    
    
//MARK  --- Dismiss Methods
    
    class func popActivity() {
       SVProgressHUD.popActivity()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func dismissWithCompletion(completion:@escaping SVProgressHUDDismissCompletion) {
        SVProgressHUD.dismiss(completion: completion)
    }
    
    class func dismissWithDelay(delay:TimeInterval) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    class func dismissWithDelay(delay:TimeInterval,completion:@escaping SVProgressHUDDismissCompletion){
        SVProgressHUD.dismiss(withDelay: delay, completion: completion)
    }
    

    
}
