//
//  TopGuideView.swift
//  fp_ios
//
//  Created by wss on 15/8/13.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit

//类似于typedef
typealias btnSelected = (_ left:Bool)->Void

class TopGuideView: UIView {
    
    //宏定义
    var buttonSelected:btnSelected!
    var sliderImageV:UIImageView!
    var leftBtn:IconButton!
    var rightBtn:IconButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
 
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func scrollViewContentOffSet(_ point:CGPoint){
        let beiX:CGFloat = point.x/SRC_WIDTH
        let x:Int = Int(beiX+0.5)
        if(x == 0){ //左
            sliderToLeft()

            
        }else if(x==1){ //右

            sliderToRight()

        }
    }
    
    
    //public 用title和image初始化
    func initWithTitleAndImage(_ sliderImage:UIImage,imageArr:NSArray) -> TopGuideView{
        self.backgroundColor = SYS_BLUE
        
        //两个btn
        leftBtn = IconButton(frame: CGRect(x: 0, y: 0, width: self.width/2.0, height: self.height))
        leftBtn.setImage(imageArr.firstObject as? UIImage, for: UIControlState())
        leftBtn.setImage(imageArr[1] as? UIImage, for: UIControlState.selected)
        
        leftBtn.addTarget(self, action: Selector("leftBtnClick:") as Selector, for: UIControlEvents.touchUpInside)
        self.addSubview(leftBtn)
        leftBtn.contentMode = UIViewContentMode.center
        leftBtn.isSelected = true
        
        rightBtn = IconButton(frame: CGRect(x: self.width/2.0, y: 0, width: self.width/2.0, height: self.height))
        rightBtn.setImage(imageArr[2] as? UIImage, for: UIControlState())
        rightBtn.setImage(imageArr[3] as? UIImage, for: UIControlState.selected)
        rightBtn.setImage(UIImage(named: "login_disable_icon"), for: UIControlState.disabled)
        if(UserDefaults.standard.value(forKey: "UserPhone") == nil){
            rightBtn.isEnabled = false
        }

        rightBtn.addTarget(self, action: #selector(rightBtnClick(_:)) as Selector, for: UIControlEvents.touchUpInside)
        self.addSubview(rightBtn)
        
        //线
        let line = UIView(frame: CGRect(x: 0, y: self.height-1, width: SRC_WIDTH, height: 1))
        line.backgroundColor = Tools.RGB(154,g: 240,b: 228)
        self.addSubview(line)

        //滑块image
        sliderImageV = UIImageView(frame: CGRect(x: 0, y: self.height-11, width: 15, height: 12))
        sliderImageV.image = sliderImage
        self.addSubview(sliderImageV)
        sliderImageV.setCenterX(leftBtn.centerX)
        sliderImageV.contentMode = UIViewContentMode.center
        return self
    }
  
    //按钮点击，调用闭包
    func leftBtnClick(_ leftBtn:UIButton){
        leftBtn.isSelected = true
        rightBtn.isSelected = false
        
        sliderToLeft()
        self.buttonSelected(true)
    }
    
    func rightBtnClick(_ rightBtn:UIButton){
        leftBtn.isSelected = false
        rightBtn.isSelected = true
        
        sliderToRight()
        self.buttonSelected(false)
    }

    //滑块动画
    func sliderToLeft(){
        leftBtn.isSelected = true
        rightBtn.isSelected = false
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.sliderImageV.setCenterX(self.leftBtn.centerX)

        })
    }
    func sliderToRight(){
        
        rightBtn.isEnabled = true

        leftBtn.isSelected = false
        rightBtn.isSelected = true
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.sliderImageV.setCenterX(self.rightBtn.centerX)
            
        })
    }
    
}
