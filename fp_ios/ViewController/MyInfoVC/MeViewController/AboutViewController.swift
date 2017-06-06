//
//  AboutViewController.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/12.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

// 关于我们
import UIKit

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    
    //MARK:重写init方法，走xib初始化方法
    
    convenience  init(){
        
        let nibNameStr = String?("AboutViewCotroller")
        
        
        
        //        if(NSBundle.mainBundle().pathForResource(nibNameStr, ofType: "xib") == nil){
        
        //            nibNameStr = nil
        
        //        }
        
        
        
        self.init(nibName:nibNameStr, bundle:Bundle.main)
        
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SYS_BGCOLOR
        self.navbar.titleLabel.text = "关于我们"
        
        //版本
        let versionDic = Bundle.main.infoDictionary!
        let version = versionDic["CFBundleShortVersionString"] as! String
        self.versionLabel.text =  self.versionLabel.text! + version
        
        
    }
    
    
}
