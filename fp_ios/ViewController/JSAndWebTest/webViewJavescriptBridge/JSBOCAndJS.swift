//
//  JSBOCCallJS.swift
//  fp_ios
//
//  Created by anne on 2017/6/16.
//  Copyright © 2017年 yushuhui. All rights reserved.

/*  关键是html文件中，相关webViewJavaScriptBridge的相关配置 */
/*  共同协商好，函数名称和参数及参数类型  */

import UIKit
import WebKit
import WebViewJavascriptBridge

class JSBOCAndJS: BaseViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler {
    
    var webBridge:WKWebViewJavascriptBridge!
    var webView:WKWebView!
    var progress:UIProgressView!
    //懒加载leftBarbuttonItems
    lazy var leftBarbuttonItems:Array<UIBarButtonItem> = {
        let image = UIImage.init(named: "back_icon")
        
        let leftBtn = UIButton(frame: CGRect(x:0, y:0, width:(image?.size.width)!, height:44))
        leftBtn.setImage(image, for: .normal)
        leftBtn.addTarget(self, action: #selector(self.backBtnClick(backBtn:)), for: .touchUpInside)
        let leftBtnItem = UIBarButtonItem.init(customView: leftBtn)
        
        let closeBtn:UIButton = UIButton(frame: CGRect(x:0, y:0, width:60, height:44))
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.addTarget(self, action: #selector(self.closeBtnClick), for: .touchUpInside)
        let closeBtnItem = UIBarButtonItem.init(customView: closeBtn)
        return [leftBtnItem,closeBtnItem]
        
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        
    }
    func setUpSubviews(){
        
        webView = WKWebView.init(frame: self.view.bounds)
        
//        webView.navigationDelegate = self //设置后影响JS与OC交互
        webView.uiDelegate = self
        self.view.addSubview(webView)
        setWebViewBridge()
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "JSBhtml", ofType: "html")!)
        webView.load(URLRequest.init(url: url))
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        
        progress = UIProgressView.init(frame: CGRect(x:0, y:64, width: SRC_WIDTH, height:1))
        progress.transform = CGAffineTransform.init(scaleX: 1, y: 0.5)
        progress.progressViewStyle = .bar
        self.view.addSubview(progress)
        progress.progressTintColor = UIColor.blue
        progress.trackTintColor = UIColor.white
        progress.progress = 0
      
    }
    
    func setWebViewBridge(){
        self.webBridge = WKWebViewJavascriptBridge.init(for: self.webView)
        self.webBridge.setWebViewDelegate(self)//webView.navigationDelegate = self //设置后影响JS与OC交互

        
        //JS 调 OC
        self.webBridge.registerHandler("shareClick") { (data, callBack) in
            //             var params = {'title':'测试分享的标题','content':'测试分享的内容','url':'http://www.baidu.com'};
            
            let param:[String:String] = data as! Dictionary
            //分享
            let alertController = UIAlertController(title: param["title"], message: (param["content"]! + param["url"]!), preferredStyle:.alert)
            let okAction = UIAlertAction(title:"确定分享" , style: .default) { (UIAlertAction) in
                callBack!("分享成功")
            }
            alertController.addAction(okAction)
            // 弹出
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        //OC 调 JS
        self.webBridge.callHandler("testJSFunction", data: "533") { (responseData) in
            AppStatusPop.showInfoWithStatus(status: responseData as! String)
        }

    }
    
    //MARK: 进度条
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progress.progress = Float(webView.estimatedProgress)
        }
        //加载完成隐藏进度条
        if progress.progress == 1{
            let afterTime:DispatchTime = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
                UIView.animate(withDuration: 0.5, animations: {
                    self.progress.isHidden = true
                    
                }, completion: { (result) in
                    self.progress.progress = 0
                })
            })
            
        }
        
    }
    
    //MARK: 返回按钮
    override func backBtnClick(backBtn:UIButton){
        if self.webView.canGoBack {
            self.webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func closeBtnClick(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //MARK:WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progress.isHidden = false
        
        TSLog("didStart")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        TSLog("didCommit")
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = "JSB" + webView.title!
        
        if webView.canGoBack {
            self.navigationItem.leftBarButtonItems = self.leftBarbuttonItems
        }else{
            self.navigationItem.leftBarButtonItem = self.leftBarbuttonItems[0]
        }
        
        
    }
    
    //拦截
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString
        if url == ""{
            decisionHandler(WKNavigationActionPolicy.cancel)
        }
        decisionHandler(WKNavigationActionPolicy.allow);
    }
    
    
    //MARK: WKUIDelegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?{
        let url = navigationAction.request.url?.absoluteString
        if url == "" {
            let newWebV = WKWebView.init(frame: self.view.bounds, configuration: configuration)
            return newWebV
        }
        return nil
    }
    //JS 要弹出警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
        
        TSLog("alert=====\(message)")
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
        }
        alertController.addAction(okAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
        completionHandler()
        
    }
    
    //JS 要弹出确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
        completionHandler(true)
    }
    
    //JS 要弹出输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Swift.Void){
        completionHandler(defaultText)
    }
    
    //MARK: WKScriptMessageHandler JS调OC
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
        
    }

    
}
