//
//  ExistLoginView.swift
//  fp_ios
//
//  Created by wss on 15/9/22.
//  Copyright © 2015年 yushuhui. All rights reserved.
//退出登录提示框

import UIKit

class ExistLoginView: UIView {

    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var sureBtnClick: UIButton!
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        self.cancelBtn.layer.borderColor = SYS_BLUE.cgColor
        self.cancelBtn.layer.borderWidth = 1.0
        self.cancelBtn.layer.cornerRadius = 4.0
        self.cancelBtn.layer.masksToBounds = true
        
        self.sureBtnClick.layer.cornerRadius = 4.0
        self.sureBtnClick.layer.masksToBounds = true
    }
    
    
    
    @IBAction func cancelBtnClick(_ sender: AnyObject) {
        
        self.removeFromSuperview()
    }
    
}
