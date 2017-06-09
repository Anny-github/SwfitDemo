//
//  Network_Manager.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/17.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import ObjectMapper


// typealias别名
public typealias Parameters = [String: Any]


//newsmode
typealias ArrayDataBlock = (_ modeArr:Array<Any>,_ success:Bool)->Void

//post
typealias CompletionBlock = (_ result:String,_ success:Bool)->Void


let headers: HTTPHeaders = [
//    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
    "Accept": "application/json"
]

private let networkMgr = Network_Manager()


class Network_Manager {
    
    var request:DataRequest!

    //单例方法
    class func shareInstance()->Network_Manager{
        return networkMgr
    }
    
    //统一的post方法
    func postRequest(_ urlString:String,params:Parameters,passValue: @escaping CompletionBlock)
    {
        SVProgressHUD.show()
        var urlStr = urlString   //请求地址拼接
        if !urlString.contains("http") {
            urlStr = BASE_URL + urlString
        }

         Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.queryString, headers: headers).responseJSON(completionHandler: { (responseData) in
            
            self.parseJsonResponse(responseData, passValue: passValue)
         
        })
    }
    
//    //统一的get方法
    func getRequest(urlString:String,params:Parameters,passValue:@escaping CompletionBlock)
    {
        SVProgressHUD.show()
        var urlStr = urlString   //请求地址拼接
        if !urlString.contains("http") {
            urlStr = BASE_URL + urlString
        }
        
       Alamofire.request(urlStr, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: headers).responseJSON(completionHandler: { (responseData) in
        
        self.parseJsonResponse(responseData, passValue: passValue)
      
        })
    
    }
    
    
    /**
    * 解析返回的data,返回nsdictionary
    */
    
    func parseJsonResponse(_ responseData:DataResponse<Any>,passValue:@escaping CompletionBlock)
    {
        
        if responseData.result.isSuccess{ //请求成功
            let json:JSON = JSON(responseData.data!)
            //if json["code"] == 0  说明有数据
            
            passValue(json["data"].rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)!,true)
            
        }else{
            passValue("",false)
        }
        
        SVProgressHUD.dismiss()

    }
    
    
    
   //TODO: 4.1	获取验证码接口
    
    func getValidateCode(_ params:Dictionary<String,AnyObject>,passValue:CompletionBlock)
    {
        //上行数据
        TSLog("上行数据 \(params)")
        
        
    }
    
    //TODO: 4.2	登录接口
    func login(_ params:Dictionary<String,AnyObject>,passValue:CompletionBlock)
    {
        //上行数据
        print("上行数据",params)
        
    
    }
    
    //TODO: 4.3	设置个人资料接口
    func updateBuyerInfo(_ params:Dictionary<String,AnyObject>,passValue:CompletionBlock)
    {
        
               
    }
    
    
    //TOOD: 取消请求
    func cancle(){

        if self.request != nil
        {
            self.request.cancel()
        }
    }
    
    //TODO: 错误信息处理
    func dealErrorCode(_ code:String,message:String){
        if(code == "10008"){
            SVProgressHUD.showAlertView("", message: message)
        }else if(code == "10009"){
            SVProgressHUD.showAlertView("", message: message)
        }else if(code == "10027"){
            SVProgressHUD.showAlertView("", message: message)
        }else if(code == "10028"){
            SVProgressHUD.showAlertView("", message: message)
        }else if(code == "10025"){
            SVProgressHUD.showAlertView("", message: message)
        }else if(code == "10026"){
            SVProgressHUD.showAlertView("", message: message)
   
        }else if(code == "10023"){
            SVProgressHUD.showAlertView("", message: message)

        }
    }
    
    
}
