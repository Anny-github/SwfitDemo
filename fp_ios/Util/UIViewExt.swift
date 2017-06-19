//
//  UIViewExt.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/12.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit
import Foundation

// uiview 扩展
extension UIView {
    
    var x:CGFloat{
        return self.frame.origin.x
    }
    

    var y:CGFloat
    {
        return self.frame.origin.y
    }
    
    var width:CGFloat
    {
        return self.frame.size.width
    }
    
    var height:CGFloat
    {
        return self.frame.size.height
    }
    
    
    var right:CGFloat
    {
        return self.x+self.width
    }
    
    var bottom:CGFloat
    {
        return self.y+self.height
    }
    
    var centerX:CGFloat{
        return self.x + self.width/2.0
    }
    
    var centerY:CGFloat{
        return self.y + self.height/2.0
    }
    
    func setX(_ x:CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setY(_ y:CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setRight(_ right:CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = right - self.width
        self.frame = rect

    }

    
    func setBottom(_ bottom:CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = bottom - self.height
        self.frame = rect
    }
    
    func setWidth(_ width:CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(_ height:CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    
    func setCenterX(_ centerX:CGFloat){
        var rect:CGRect = self.frame
        rect.origin.x = centerX - self.width/2.0
        self.frame = rect
    }
    
    func setCenterY(_ centerY:CGFloat){
        var rect:CGRect = self.frame
        rect.origin.y = centerY - self.height/2.0
        self.frame = rect
    }
    
    func setCenterPoint(_ center:CGPoint){
        var rect:CGRect = self.frame
        rect.origin.x = center.x - self.width/2.0
        rect.origin.y = center.y - self.height/2.0
        self.frame = rect
    }
    
    
    //类方法 
    class func showAlertView(_ title:String,message:String) {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message;
        alert.addButton(withTitle: "确定")
        alert.show()
    }
    
    
    
}
