//
//  AppFile.swift
//  fp_ios
//
//  Created by wss on 15/8/28.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import Foundation

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
        //print(NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true).first as! String)
        
        var dic:[String:Any] = AppFile.checkSet()

        let arr:EnumeratedSequence = userInfo.keys.enumerated()
    
        for key in arr
        {
            let value = userInfo[Key ]
            TSLog(value)

            if value as! NSObject == NSNull() || value as! String == "<null>"
            {
                
            }else{
                dic.updateValue(value, forKey: key!)
            }
        }
        
        AppFile.saveSet(dic)

    }
    
//    class func userModel() -> UserMode{
//        
//        let dic:NSDictionary = AppFile.checkSet()
//        var usermode:UserMode = UserMode(JSONString: String.data(JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)))
//        do{
//            usermode = try UserMode(JSONDecoder(dic))
//
//        }catch{
//            
//        }
//        return usermode
//    
//    }
    
    class func saveSet(_ dic :Dictionary<String,Any>)
    {
        let path:String = AppFile.UsrInfoPath()
        let dict:NSDictionary = NSDictionary(dictionary: dic)
        dict.write(toFile: path, atomically: true)
    }
    
    //MARK:取用户信息字典
//    class func getUserInfo()->UserMode{
//        TSLog(AppFile.UsrInfoPath())
//        let dic:NSDictionary = AppFile.checkSet()
//        
//        TSLog(dic)
//        var userInfo:UserMode = UserMode()
//        do{
//            userInfo = try UserMode(JSONDecoder(dic))
//        }catch{
////            xfl
//        }
//        return userInfo
//    }
    
    
}
