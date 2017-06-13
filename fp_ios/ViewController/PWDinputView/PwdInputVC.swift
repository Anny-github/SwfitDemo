//
//  PwdInputVC.swift
//  fp_ios
//
//  Created by anne on 2017/6/13.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

typealias FinishInputPWD = (_ inputText:String) -> Void

class PwdInputVC: UIViewController,UITextFieldDelegate {
    
    var finishInputPwd:FinishInputPWD!
    var pwdTf:PwdTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setPWDView()
        self.pwdTf = PwdTextField.init(frame: CGRect(x:20,y:100,width:SRC_WIDTH-40,height:50))
        self.pwdTf.delegate = self
        self.pwdTf!.pointLimit(numberLmt: 6)
        
        self.view.addSubview(self.pwdTf)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
    }
    private func setPWDView(){
        self.pwdTf = PwdTextField.init(frame: CGRect(x:20,y:100,width:SRC_WIDTH-40,height:50))
        self.pwdTf.delegate = self
        self.pwdTf!.pointLimit(numberLmt: 6)

        self.view.addSubview(self.pwdTf)

        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    func textFieldDidChange(){
        if self.pwdTf.text?.characters.count == self.pwdTf.numberLimit{
            self.finishInputPwd(self.pwdTf.text!)
            self.view.endEditing(true)

        }
    }
    
//MARK: ---------UITextFieldDelegate--
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.characters.count == self.pwdTf.numberLimit{
            return false
        }else if textField.text?.characters.count == self.pwdTf.numberLimit-1{
            return true
        }
        return false
        
    }
   
}
