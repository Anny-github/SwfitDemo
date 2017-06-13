//
//  PwdTextField.swift
//  fp_ios
//
//  Created by anne on 2017/6/13.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

class PwdTextField: UITextField {

    var numberLimit: Int!
    var shadeView:PaintView!
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
        self.keyboardType = UIKeyboardType.numberPad
        self.textColor = UIColor.clear;
        
        self.shadeView = PaintView(frame:self.bounds)
        self.shadeView.backgroundColor = UIColor.white
        self.shadeView.isUserInteractionEnabled = false
        self.addSubview(self.shadeView)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pointLimit(numberLmt: Int){
        self.numberLimit = numberLmt
        self.shadeView!.totalPoints(pointNum: numberLmt)
    }
    
    func addCircle(){
        self.shadeView.paintPoints(pointsNum: self.text!.characters.count)
    }

}
