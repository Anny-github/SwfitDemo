//
//  Tools.swift
//  fp_ios
//
//  Created by anne on 2017/6/6.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import Foundation
import UIKit

func TSLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(messsage)")
        
    #endif
}


class Tools:NSObject {
    
    
    //16进制色值
    class func colorFromRGB(_ rgbValue:UInt)->UIColor
    {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0));
        
    }
    
    //RGB 色值
    
    class func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat)->UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0);
    }
    
    //long类型时间转换成date 字符串类型
    class func dateStringFromTimeStamp(_ timeStamp:String)->String
    {
        let time:Double = Double(timeStamp)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        let date = Date(timeIntervalSince1970: time)
        return formatter.string(from: date)
        
    }
    //TODO: 手机号码正则校验
    class func checkoutPhoneNumer(_ phoneStr:String)->Bool{
        let range = phoneStr.range(of: phoneStr)
        let mobile:String = phoneStr.replacingOccurrences(of: " ", with: "", options: String.CompareOptions.literal, range: range)
        
        let validMobilePredicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@","^(13[0-9]|15[0-9]|17[0-9]|18[0-9]|14[0-9])[0-9]{8}$" )
        
        if ( validMobilePredicate.evaluate(with: mobile) == true){
            return  true
        }else{
            return false
        }
        
    }
    //TODO: 小数正则校验
    class func checkoutNumer(_ numStr:String)->Bool{
        let range = numStr.range(of: numStr)
        
        let numString:String = numStr.replacingOccurrences(of: " ", with:"", options: NSString.CompareOptions.literal, range: range)
        
        let validMobilePredicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@","^[0-9]+(.[0-9]{1,3})?$" )
        
        if ( validMobilePredicate.evaluate(with: numString) == true){
            return  true
        }else{
            return false
        }
        
    }
    
    //字典转json
    class func toJsonString(_ dic:NSDictionary)->NSString{
        
        var jsonStr:NSString = NSString()
        
        do {
            let data:Data = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if(data.count > 0 ){
                jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
            }
            
            // use jsonData
        } catch {
            // report error
        }
        
        
        return jsonStr
    }
    
    
}
