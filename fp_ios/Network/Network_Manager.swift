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
//    "Accept": "application/json",
    "Content-Type":"text/plain"
]

private let networkMgr = Network_Manager()


class Network_Manager {
    
    var request:DataRequest!
    var downloadRequest:DownloadRequest!

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

        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseData) in
            
            self.parseJsonResponse(responseData, passValue: passValue)
            
        })
    }
    
    //统一的get方法
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
        SVProgressHUD.dismiss()

        if responseData.result.isSuccess{ //请求成功
            let json:JSON = JSON(responseData.data!)
            if json["resultCode"] == 0 { //说明有数据
                if json["data"].rawString() != nil{
                    passValue(json["data"].rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)!,true)

                }else{
                    passValue("",true)
                }

            }else{
                passValue(json["resultMessage"].rawString()!,false)
 
            }
            
            
        }else{
            if SystemHelper.shared().isNetReachable() == false{
                SVProgressHUD.showError(withStatus: "请检查网络连接")
            }
            passValue("",false)
        }
        

    }
    
    
    //TODO: 取消请求
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
    
//MARK: 下载功能,单任务下载
    func downloadFile(_ downUrl:String,savePathURL:URL, result:@escaping CompletionBlock){
        let downloadUrl = downUrl

        let fileURL = savePathURL
        
        if FileManager.default.fileExists(atPath: savePathURL.absoluteString) { //下载文件已存在，直接返回
            result("",true)
        }
        
        //缓存路径 根据 downLoadUrl 识别
        var resumeData:Data

        let cacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(downloadUrl.replacingOccurrences(of: "/", with: ""))
        if !FileManager.default.fileExists(atPath: cacheUrl.absoluteString) {
            FileManager.default.createFile(atPath:  cacheUrl.absoluteString, contents: Data(), attributes: nil)
        }
        do{
           resumeData =  try Data.init(contentsOf: cacheUrl)
        }catch{
            resumeData = Data()
            TSLog("resumeData==Error:\(error)")
        }

        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        if resumeData.count != 0{
            self.downloadRequest = Alamofire.download(resumingWith: resumeData, to: destination).downloadProgress(closure: { (progress) in
                TSLog("下载进度-----\(progress)")
                if Double(progress.completedUnitCount)/Double(progress.totalUnitCount) > 0.5{
//                    self.pauseDownLoad()
                }

            }).responseData(completionHandler: { (responseData) in
                TSLog("接着resumeData下载=====\(responseData)")
                switch responseData.result {
                    case .success:
                        TSLog("下载成功")
                        //移除缓存数据
                        try? FileManager.default.removeItem(atPath: cacheUrl.absoluteString)
                        result("",true)
                        
                    case .failure:
                        try? responseData.resumeData?.write(to: cacheUrl, options: Data.WritingOptions.atomicWrite)
                        TSLog("下载失败")
                        result("",false)
                }

            })
        
        }else{
             self.downloadRequest = Alamofire.download(URL(string:downloadUrl)!, to: destination).downloadProgress(closure: { (progress) in
                TSLog("下载进度-----\(progress)")
                if Double(progress.completedUnitCount)/Double(progress.totalUnitCount) > 0.5{
                    self.pauseDownLoad()
                }

            }).responseData(completionHandler: { (responseData) in
                TSLog("新建下载=====\(responseData)")

                switch responseData.result {
                    case .success:
                        TSLog("下载成功")
                        //移除缓存数据
                        try? FileManager.default.removeItem(atPath: cacheUrl.absoluteString)
                        result("",true)
                        
                    case .failure:
                        do{
                            try responseData.resumeData?.write(to: cacheUrl, options: Data.WritingOptions.atomicWrite)
                        }catch{
                            
                            TSLog("中断下载写入文件 Error:===\(error)")
                        }

                        TSLog("下载失败")
                        result("",false)
                }

            })
        }
        
    }
    
    //暂停下载
    func pauseDownLoad(){
        self.downloadRequest.cancel()
    }
 
    
//MARK: 上传图片
    func uploadImage(_ images:[UIImage]!,imageNames:[String], toUrl:String ,result:@escaping CompletionBlock){
        
        AppStatusPop.showWithStatus(status: "上传中...")
        
        let url = "http://api.yingshibao.com/user/index/changeUserIcon"
        
        Alamofire.upload(multipartFormData: { (data) in
            for i in 0..<images.count{
                data.append(UIImagePNGRepresentation(images[i])!, withName: imageNames[i])
            }
        }, to: url) { (encodingResult) in //case success(request: UploadRequest, streamingFromDisk: Bool, streamFileURL: URL?)        case failure(Error)

            AppStatusPop.dismiss()
            switch encodingResult {
            case .success(let uploadRequest, _, _):
                uploadRequest.responseJSON { response in
                    if response.result.isSuccess{
                        result("",true)
                    }else{
                        result("",false)
                        AppStatusPop.showErrorWithStatus("上传失败")

                    }
                }

            case .failure(let encodingError):
                AppStatusPop.showErrorWithStatus("上传失败")
                TSLog("头像上传失败---\(encodingError)")
                result("",false)
                break
            }
        }
        
    }
    
    
}
