//
//  Reg&LoginViewController.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/12.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

// 登录 注册 

import UIKit
import JSONJoy


class RegLoginViewController: BaseViewController,UIScrollViewDelegate{
    var scrollV:UIScrollView!
    var phoneView:PhoneInputView!
    var loginV:LoginView!
    var topView:TopGuideView!

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SYS_BLUE
        self.setStatusBarWithColor(SYS_BLUE)
        setNavigationBar()
        
        
        createSubViews()
        
        //添加通知
        addNotification()
        
    }

    //TODO:添加通知
    func addNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    //TODO:设置导航栏
    func setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = true
        self.navbar.isHidden = true
    }
    
    //TODO:子视图 不显示导航栏
    func createSubViews(){
        //图标
        let loginIconImgV:UIImageView = UIImageView(frame: CGRect(x: 0, y: SRC_HEIGHT/6.0, width: 90, height: 90))
        loginIconImgV.image = UIImage(named: "logo_icon")
        loginIconImgV.setCenterX(self.view.centerX)
        self.view.addSubview(loginIconImgV)
        
        //上方引导图标
        topView = TopGuideView(frame: CGRect(x: 0, y: SRC_HEIGHT/2.0+30, width: SRC_WIDTH, height: 100))
        var imageA:Array<UIImage> = Array()
        imageA.append(UIImage(named: "tel_verification_up_icon")!)
        imageA.append(UIImage(named: "tel_verification_down_icon")!)
        imageA.append(UIImage(named: "login_up_icon")!)
        imageA.append(UIImage(named: "login_down_icon")!)
        
        let image:UIImage = UIImage(named: "onlinearrow_bg")!
        topView.initWithTitleAndImage(image, imageArr: imageA as NSArray)
        self.view.addSubview(topView)

        
        //scrollView
        scrollV = UIScrollView()
        scrollV.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        scrollV.frame = CGRect(x: 0, y: topView.bottom,width: SRC_WIDTH , height: SRC_HEIGHT-topView.bottom)
        scrollV.bounces = false
        scrollV.isPagingEnabled = true
        scrollV.delegate = self
        scrollV.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        scrollV.contentSize = CGSize(width: SRC_WIDTH*2, height: 0)
        self.view.addSubview(scrollV)
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.showsVerticalScrollIndicator = false
        
        phoneView = Bundle.main.loadNibNamed("PhoneInputView", owner: nil, options: nil)?.first as! PhoneInputView
        phoneView.frame = CGRect(x: 0, y: 0, width: SRC_WIDTH, height: scrollV.height)
        
        
        loginV = Bundle.main.loadNibNamed("LoginView", owner: nil, options: nil)?.first as! LoginView
        loginV.frame = CGRect(x: SRC_WIDTH, y: 0, width: SRC_WIDTH, height: scrollV.height)
        scrollV.addSubview(phoneView)
        scrollV.addSubview(loginV)
        
        
        
        
        //MARK: 手机输入视图  点击获取验证码 跳转
        phoneView.getCodeBtnSelect = {
            print(UserDefaults.standard.value(forKey: "UserPhone"))
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.scrollV.contentOffset = CGPoint(x: SRC_WIDTH, y: 0)
                self.topView.scrollViewContentOffSet(self.scrollV.contentOffset)
                if(self.loginV.timer != nil){
                    self.loginV.resetViewLayout()

                }
                
               
            })
            self.loginV.getCodeBtnClick(UIButton())

        }
        
        loginV.loginBtnEnent = {
            
    
            let valueKey:String = self.phoneView.phoneTf.text! + self.loginV.codeTf.text!
            let param:Dictionary<String,String> = ["mobileNumber":self.phoneView.phoneTf.text!,"validateCode":self.loginV.codeTf.text!,"valueKey":valueKey.md5String()]
            
            //向服务器发起请求
        
            Network_Manager.shareInstance().login(param as Dictionary<String, AnyObject>, passValue: { (dic, success) -> Void in
                if(success){
                    print(dic)
                    //登录成功存储信息
//                    SetUtil.saveUserInfo(dic as! [AnyHashable: Any])
//                    
//                    let isComplete = (dic["isComplete"]! as AnyObject).intValue
//                    
//                    if(isComplete == 0){
//                        //登录按钮点击，防止多次点击进入，判断已进入信息页 不在进入
//                        for  viewcontroller in (self.navigationController?.childViewControllers)!{
//                            if(viewcontroller is PerfectInfoVController){
//                                return
//                            }
//                        }
//                        
//                        let infoVC:PerfectInfoVController = PerfectInfoVController()
//                        self.navigationController?.pushViewController(infoVC, animated: true)
//                        
//                    }else{
//
//                        //MARK: 登录通知
//                        NotificationCenter.default.post(name: Notification.Name(rawValue: NOFI_LOGINSUCCESS), object: nil)
//                    }
//                    
                    
                    
                }
                
            })
            
        }
        
        //MARK:topView的闭包的实现{参数 in  方法体}
        topView.buttonSelected = {a in
            if(a == true){
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    self.scrollV.contentOffset = CGPoint(x: 0, y: 0)
                })
                                
            }else{
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    self.scrollV.contentOffset = CGPoint(x: SRC_WIDTH, y: 0)
                    
                })
                
            }
            
        }

        
        
    }
    
    //scrollView滚动 代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(UserDefaults.standard.value(forKey: "UserPhone") == nil){ //还未获取验证码，不能滑动
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            return
        }
        
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        topView.scrollViewContentOffSet(self.scrollV.contentOffset)

        
    }

    #if __CC_PLATFORM_IOS
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
    
    }
    #endif
    

    
    //TODO:键盘通知
    func keyboardShow(_ note:Notification){
    
        let info = note.userInfo!
        let kbSize:CGSize = (info[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size as CGSize
        let duration:Float = (info[UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).floatValue
        UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
            self.view.transform = CGAffineTransform(translationX: 0, y: -kbSize.height);

        })
        
        
    
    }
    
    func keyboardHide(_ note:Notification){
        let info = note.userInfo!
        let duration:Float = (info[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).floatValue
        UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
            self.view.transform = CGAffineTransform.identity;
            
        })
        

    }

}

