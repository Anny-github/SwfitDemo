//
//  NSStringExt.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/17.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import Foundation


extension String{
    
    func md5String() -> String{
    
        //拼接上AppKey
        let passStr = NSMutableString(string: self)
        let cStr = (passStr as NSString).utf8String
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr,(CC_LONG)(strlen(cStr)), buffer)
        let md5String = NSMutableString()
        for i in 0 ..< 16{
            md5String.appendFormat("%02X", buffer[i])
            
        }
        
        return  md5String.lowercased as String

    }
    
}
