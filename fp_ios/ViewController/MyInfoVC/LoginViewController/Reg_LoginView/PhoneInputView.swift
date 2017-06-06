//
//  PhoneInputView.swift
//  fp_ios
//
//  Created by wss on 15/8/12.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//输入手机号view

import UIKit
import SVProgressHUD

typealias getCodeButton = ()->Void

class PhoneInputView: UIView {
    
    @IBOutlet weak var phoneTf: UITextField!
    
    @IBOutlet weak var geyCodeBtn: UIButton!
    
    
    //闭包变量
    var getCodeBtnSelect:getCodeButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame = CGRect(x: 0, y: 0, width: SRC_WIDTH, height: SRC_HEIGHT)
        self.backgroundColor = SYS_BLUE
        geyCodeBtn.backgroundColor = Tools.RGB(8,g: 84,b: 74)
        geyCodeBtn.layer.cornerRadius = 3.0
        geyCodeBtn.layer.masksToBounds = true
        geyCodeBtn.backgroundColor = Tools.colorFromRGB(0xfff04c)

        phoneTf.keyboardType = UIKeyboardType.numberPad
        phoneTf.clearButtonMode = UITextFieldViewMode.whileEditing
    }
   
    
    //TODO:获取验证码
    @IBAction func getCodeBtnClick(_ sender: UIButton) {
        
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        let result:Bool = Tools.checkoutPhoneNumer(phoneTf.text!)
        
        if(result == false){
            SVProgressHUD.showInfo(withStatus:"请输入正确的手机号")
            return
        }
        //存入NSUserDefault
        UserDefaults.standard.setValue(phoneTf.text, forKey: "UserPhone")
        
        let valueKey:String = phoneTf.text! + "1"
        let param:Dictionary<String,String> = ["mobileNumber":phoneTf.text!,"clientType":"1","valueKey":valueKey.md5String()]
        
        //手机正确 向服务器发起请求
        
//        Network_Manager.shareInstance().getValidateCode(param, passValue: { (dic, success) -> Void in
//            if(success){
//                print("获取验证码成功:",dic)
//            }
//        })
        
        self.getCodeBtnSelect()
        
    }
    
    //TODO: 点击收起键盘

    #if __CC_PLATFORM_IOS
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
    
    }
    #endif
    

}
