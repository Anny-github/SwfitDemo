//
//  PwdInputVC.swift
//  fp_ios
//
//  Created by anne on 2017/6/13.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

class PwdInputVC: BaseViewController {
    
    var pwdView:PwdInputView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "密码验证"
        self.setPWDView()
    }
    private func setPWDView(){
        self.pwdView = PwdInputView.init(frame: CGRect(x:20,y:100,width:SRC_WIDTH-40,height:50))
        self.pwdView!.pointLimit(numberLmt: 6)
        self.view.addSubview(self.pwdView)
        self.pwdView.finishInputPwd = { (inputText:String) -> Void in
            AppStatusPop.showInfoWithStatus(status: inputText)
            TSLog("输入的密码========\(inputText)")
        }
    }
    
       
}
