//
//  PwdInputView.swift
//  fp_ios
//
//  Created by anne on 2017/6/13.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

typealias FinishInputPWD = (_ inputText:String) -> Void


class PwdInputView: UIView ,UITextFieldDelegate{
    var finishInputPwd:FinishInputPWD!
    var numberLimit: Int!
    var shadeView:PaintView!
    var pwdTf:UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.pwdTf = UITextField(frame:self.bounds)
        self.pwdTf.keyboardType = UIKeyboardType.numberPad
        self.pwdTf.textColor = UIColor.clear;
        self.addSubview(self.pwdTf)
        self.pwdTf.delegate = self
        self.shadeView = PaintView(frame:self.bounds)
        self.shadeView.backgroundColor = UIColor.white
        self.shadeView.isUserInteractionEnabled = false
        self.addSubview(self.shadeView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pointLimit(numberLmt: Int){
        self.numberLimit = numberLmt
        self.shadeView!.totalPoints(pointNum: numberLmt)
    }
    
    func addCircle(){
        self.shadeView.paintPoints(pointsNum: self.pwdTf.text!.characters.count)
    }

    func textFieldDidChange(){
        self.shadeView.paintPoints(pointsNum: self.pwdTf.text!.characters.count)

        if self.pwdTf.text?.characters.count == self.numberLimit{
            self.finishInputPwd(self.pwdTf.text!)
            self.endEditing(true)
            
        }
    }
    
    //MARK: ---------UITextFieldDelegate--
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = textField.text!.characters.count - range.length + string.characters.count
        return length <= self.numberLimit
        
    }


}
