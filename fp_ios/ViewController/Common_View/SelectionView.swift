//
//  SelectionView.swift
//  fp_ios
//
//  Created by wss on 15/8/26.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//
/*
    用法：var vi:SelectionView = SelectionView()
    vi.setDataArray(title数组，一个闭包回调）（传出高度和选中的index数组）
}


*/
import UIKit
let NumOfEachRow:CGFloat = 3
typealias BlockOfNewHeightAndSelctedIndex = (_ height:CGFloat,_ selectedIndex:Int) -> Void

class SelectionView: UIView {

    var newHeightAndSelctedIndex:BlockOfNewHeightAndSelctedIndex!
    var conditionArr:NSArray!
    var selectedImg:UIImageView!
    
    var selectedDic:NSMutableDictionary! //记录选中的数据
    var selectedIndexArr:Array<String>! //选中的下标
    var newHeight:CGFloat!
    
    var btnArr:Array<UIButton>! //存放按钮的数组
    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.setX(0)
        self.setWidth(SRC_WIDTH)
        self.backgroundColor = Tools.RGB(231,g: 239,b: 238)
        btnArr = Array()
        
        selectedIndexArr = Array()
        selectedDic = NSMutableDictionary()
        

    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    func setDataArray(_ dataArray:NSArray,newHeightBlock:BlockOfNewHeightAndSelctedIndex){
        
//        self.newHeightAndSelctedIndex = newHeightBlock
        
        self.conditionArr = dataArray
        let edgeW:CGFloat = 20
        let btnWidth:CGFloat = (SRC_WIDTH - edgeW*(NumOfEachRow+1))/NumOfEachRow
        let edgeH:CGFloat = 15
        let btnHeight:CGFloat = 35
        
        var i:Int = 0
        
        for i in 0 ..< dataArray.count{
            
            let button:UIButton = UIButton()
            
            let row:CGFloat = CGFloat(i).truncatingRemainder(dividingBy: NumOfEachRow)
            
            let x:CGFloat = edgeW + (edgeW + btnWidth) * row
            
            let column:Int = i / Int(NumOfEachRow)
            
            let y:CGFloat = (edgeH + btnHeight) * CGFloat(column)
            
            
            button.frame = CGRect( x: x, y: y, width: btnWidth, height: btnHeight)
            button.tag = 1000 + i
            
            button.titleLabel?.textAlignment = NSTextAlignment.center
            button.setTitle(dataArray[i] as? String, for: UIControlState())
            button.setTitleColor(UIColor.black, for: UIControlState())
            button.addTarget(self, action: Selector("CondiButtonClick:"), for: UIControlEvents.touchUpInside)
            button.backgroundColor = SYS_WHITE
            
            button.setTitleColor(Tools.RGB(26,g: 178,b: 156), for: UIControlState())
            button.layer.cornerRadius = 1.0
            button.layer.masksToBounds = true
            button.layer.borderColor = Tools.RGB(26,g: 178,b: 156).cgColor
            button.layer.borderWidth = 1.0
            
            //放btn的view
            let bgV:UIView = UIView(frame: CGRect( x: x, y: y-10, width: btnWidth+10, height: btnHeight+10));
            bgV.backgroundColor = UIColor.clear
            button.frame = CGRect(x: 0, y: 10, width: btnWidth, height: btnHeight)
            
            bgV.addSubview(button)
            self.addSubview(bgV)
            
            btnArr.append(button)
            
        }
        
        let columnNum:Int!
        if((dataArray.count) % Int(NumOfEachRow)  != 0){
            columnNum = (dataArray.count) / Int(NumOfEachRow) + 1
            
        }else{
            columnNum = (dataArray.count) / Int(NumOfEachRow)
        }
        let newHeigh:CGFloat = (edgeH + btnHeight) * CGFloat(columnNum)
        newHeight = newHeigh
        
        self.setHeight(newHeigh)
        
        //调用闭包,重置高度，刷新约束
        self.newHeightAndSelctedIndex(newHeight,0)
        
        //初始化选中字典
        selectedDic.setValue("0", forKey: String(format: "\(i)"))
        
        CondiButtonClick(btnArr.first!)
    }
    
    
    //条件按钮点击,选中的tag是10000+index，没选中的是1000+index
    func CondiButtonClick(_ btn:UIButton){
        
        //此btn没选中
        if(btn.tag < 10000){
            btn.tag = btn.tag - 1000 + 10000
            let selectedImgV = UIImageView(frame: CGRect(x: btn.width-10, y: 0, width: 20, height: 20))
            selectedImgV.image = Selected_RightIcon
            btn.superview?.addSubview(selectedImgV)
        }//else 已经是选中状态，什么也不做
        
        for button in btnArr{  //取消其他按钮的选中
            
            if(button != btn){
                if(button.tag >= 10000){ //表示选中的
                    button.tag = button.tag - 10000 + 1000
                
                }
                let superV:UIView = button.superview!
                let subVArr:Array = superV.subviews
                for subV in subVArr {
                    if subV is UIImageView{
                        subV.removeFromSuperview()
                    }
                }
            }
        }
        
        
//        if(btn.tag < 10000){ //没选中的
//            
//            var selectedImgV = UIImageView(frame: CGRectMake(btn.width-10, 0, 20, 20))
//            selectedImgV.image = UIImage(named: "tab")
//            btn.superview?.addSubview(selectedImgV)
//            
//            let index:Int =  btn.tag - 1000
//            btn.tag = index + 10000
//            
//            selectedDic.setValue("1", forKey: String(format:"\(index)"))
//            
//        }
        
//        self.newHeightAndSelctedIndex(height:newHeight,selectedIndex:(btn.tag-10000))

        
    }
}
