//
//  Network_Manager.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/17.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit
import Alamofire
import JSONJoy
import SVProgressHUD


public typealias Parameters = [String: Any]


//newsmode
typealias ArrayDataBlock = (_ modeArr:NSArray,_ success:Bool)->Void

//post
typealias DictionaryBlock = (_ dic:NSDictionary,_ success:Bool)->Void

private let networkMgr = Network_Manager()

class Network_Manager {
    
    var request:DataRequest!

    //单例方法
    class func shareInstance()->Network_Manager{
        return networkMgr
    }
    
    //统一的post方法
    func postRequest(_ urlString:String,params:Parameters,passValueDictionary:DictionaryBlock)
    {
        let urlStr = BASE_URL+urlString   //请求地址拼接
        SVProgressHUD.show()
    
        self.request = Alamofire.request(urlStr, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (result) in
            let data = result.data
            var dic:[String:AnyObject] = Dictionary<String, AnyObject>()
            do{
                dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            }catch{
                TSLog("解析失败")
            }
            
            TSLog(dic)
            
            SVProgressHUD.dismiss()


        })
   
    }
    
//    //统一的get方法
    func getRequest(urlString:String,params:Parameters,passValue:DictionaryBlock)
    {
        SVProgressHUD.show()
        let urlStr = BASE_URL+urlString   //请求地址拼接
        
        self.request = Alamofire.request(urlStr, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (result) in
            
            let data = result.data
            var dic:[String:AnyObject] = Dictionary<String, AnyObject>()
            do{
                dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            }catch{
                TSLog("解析失败")
            }
            
            TSLog(result)
            
            SVProgressHUD.dismiss()
            
        })
        
    }
    
    
    /**
    * 解析返回的data,返回nsdictionary
    */
    
    func parseJsonResponse(_ data:AnyObject)
    {

    }
    
    
    
//    func test(a:Int,b:CGFloat,passVlue:ArrayDataBlock)
//    {
//        
//        println(a)
//        println(b)
//        
//        Alamofire.request(.GET, "http://api.zhigu.bjzzcb.com/v1/article/list")
//            .responseJSON {(request, response, JSON, error) in
//                //                println(JSON)
//                let dict:NSDictionary = JSON as! NSDictionary
//                println(dict)
//                
//                var aArray:Array<NewsMode>?  //数组
//                aArray = Array<NewsMode>()
//                
//                if let aStatus1 = dict["result"] as? NSMutableArray{
//                    
//                    //  print(aStatus1)
//                    
//                    for a in aStatus1
//                    {
//                        let news = NewsMode(JSONDecoder(a))
////                        println(news)
////                        println("title is: \(news.title!)")
//                        aArray?.append(news)
//                        
//                    }
//                    passVlue(modeArr:aArray,success:true)
//                    
//                }
//        }
//        
//        
//    }
//    
    
    // TODO: 4.1	获取验证码接口
    
    func getValidateCode(_ params:Dictionary<String,AnyObject>,passValue:DictionaryBlock)
    {
        //上行数据
        TSLog("上行数据 \(params)")
        
        
    }
    
    //TODO: 4.2	登录接口
    func login(_ params:Dictionary<String,AnyObject>,passValue:DictionaryBlock)
    {
        //上行数据
        print("上行数据",params)
        
    
    }
    
    //TODO: 4.3	设置个人资料接口
    func updateBuyerInfo(_ params:Dictionary<String,AnyObject>,passValue:DictionaryBlock)
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
