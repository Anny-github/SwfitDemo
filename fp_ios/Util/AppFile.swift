//
//  AppFile.swift
//  fp_ios
//
//  Created by wss on 15/8/28.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import Foundation
import ObjectMapper

class AppFile: NSObject {

    class func UsrInfoPath() -> String{
        let documentDirc:String = (NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first as String?)!
        let infoPath:String = documentDirc + "/UserInfo.plist"
        return infoPath
    }
    
    class func checkSet() -> [String:Any]{
        let path:String = AppFile.UsrInfoPath()
        let fileMgr:FileManager = FileManager.default
        if(!fileMgr.fileExists(atPath: path)){
            let dic:NSDictionary = ["default":"FP"]
            dic.write(toFile: path, atomically: true)
        }
        let mutableDic:[String:Any] = Dictionary()
        
        return mutableDic
    }
    
    //MARK:存储用户信息字典
    class func saveUserInfo(_ userInfo:Dictionary<String, Any>){
        var dic:[String:Any] = AppFile.checkSet()
    
        for (key,value) in userInfo{
            if value as! NSObject == NSNull() || value as! String == "<null>"
            {
                
            }else{
                dic.updateValue(value, forKey: key)
            }
        }
        
        AppFile.saveSet(dic)
    }
    
    class func userModel() -> UserMode{
        
        let dic:Dictionary = AppFile.checkSet()
        let data = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        let jsonStr = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        let usermode = Mapper<UserMode>().map(JSONString: jsonStr as! String)
        return usermode!
    
    }
    
    class func saveSet(_ dic :Dictionary<String,Any>)
    {
        let path:String = AppFile.UsrInfoPath()
        let dict:NSDictionary = NSDictionary(dictionary: dic)
        dict.write(toFile: path, atomically: true)
    }
    
}
