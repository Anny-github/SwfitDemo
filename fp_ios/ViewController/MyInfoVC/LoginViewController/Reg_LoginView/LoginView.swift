//
//  LoginView.swift
//  fp_ios
//
//  Created by wss on 15/8/13.
//  Copyright (c) 2015年 yushuhui. All rights reserved.

//获取验证码登录view

import UIKit
import SVProgressHUD
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


typealias loginButtonClick = ()->Void

class LoginView: UIView {

    //闭包
    var loginBtnEnent:loginButtonClick!
    
    @IBOutlet weak var codeTf: UITextField!
    
    @IBOutlet weak var getCodeBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    var timer:Timer!
    var second:Int!
    
    
    
    override func awakeFromNib() {
       super.awakeFromNib()
        self.frame = CGRect(x: 0, y: 0, width: SRC_WIDTH, height: SRC_HEIGHT)
        self.backgroundColor = SYS_BLUE
        
        codeTf.keyboardType = UIKeyboardType.numberPad
        codeTf.clearButtonMode = UITextFieldViewMode.whileEditing

        loginBtn.backgroundColor = Tools.RGB(8,g: 84,b: 74)
        getCodeBtn.backgroundColor = Tools.RGB(8,g: 84,b: 74)
        loginBtn.layer.cornerRadius = 3.0
        loginBtn.layer.masksToBounds = true
        getCodeBtn.layer.cornerRadius = 1.0
        getCodeBtn.layer.masksToBounds = true
        loginBtn.backgroundColor = Tools.colorFromRGB(0xfff04c)
        
    }
    
    @IBAction func getCodeBtnClick(_ sender: UIButton) {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)

        //MARK: 判断手机格式
        let phone:String = UserDefaults.standard.value(forKey: "UserPhone") as! String
        
        if(Tools.checkoutPhoneNumer(phone) == false){
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        second = 60
        getCodeBtn.setTitle(String(format:"%d",second), for: UIControlState())
        getCodeBtn.isUserInteractionEnabled = false
    }
    
    
    //获取验证码倒计时
    func timerStart(){
        if(second == 0){
          
            resetViewLayout() //恢复

        }else{
            second = second - 1
            getCodeBtn.setTitle(String(format:"%d",second), for: UIControlState())
        }
    }
    
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
        
        UIApplication.shared.sendAction(Selector("resignFirstResponder"), to: nil, from: nil, for: nil)
        if(timer != nil){
            resetViewLayout()

        }
        
        //MARK:检验
        if((codeTf.text?.characters.count) < 6 || codeTf.text == nil){
           SVProgressHUD.showInfo(withStatus: "验证码错误", maskType: .black)
           return
        }
        
        
        self.loginBtnEnent()
        
    }

    //TODO:重置页面显示
    func resetViewLayout(){
        getCodeBtn.setTitle("重新获取", for: UIControlState())
        second = 60
        timer.invalidate()
        timer = nil
        getCodeBtn.isUserInteractionEnabled = true


    }
    //TODO:点击收回键盘
    
    #if __CC_PLATFORM_IOS
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
    
    }
    #endif

}
