//
//  PaintView.swift
//  fp_ios
//
//  Created by anne on 2017/6/13.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

class PaintView: UIView {

    private var points:Int!
    var paintNum:Int!
    var tfWidth:Float = 0
    var tfHeight:Float = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        tfWidth = Float(frame.size.width)
        tfHeight = Float(frame.size.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func totalPoints(pointNum:Int!){
        self.points = pointNum
        self.initTextFieldStyle()
    }
    func initTextFieldStyle(){
        
        let eachWidth = tfWidth/Float(self.points)
        
        for i in 1...self.points {
            let leftX = eachWidth * Float(i)
            let line = UIView(frame: CGRect(x:CGFloat(leftX), y:0, width:0.2,height:CGFloat(tfHeight)))
            line.backgroundColor = UIColor.gray
            self.addSubview(line)
        }
    }
    
    
    func paintPoints(pointsNum:Int!){
        self.paintNum = pointsNum
        self.draw(self.frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //总共几个原点要画
        let context = UIGraphicsGetCurrentContext()
        
        //设置填充色
        context?.setFillColor(UIColor.lightGray.cgColor)
        
        let pointW = tfWidth/Float(self.paintNum)/Float(2.0)
        let pointH = pointW
        
        let eachWidth = tfWidth/Float(self.paintNum)
        let y = (tfHeight - pointH)/2.0
        
        for i in 0...(self.paintNum-1) {
            //计算原点位置
            let leftX = eachWidth*Float(i) + (eachWidth-pointW)/2.0
            
            context?.fillEllipse(in: CGRect(x:CGFloat(leftX), y:CGFloat(y), width:CGFloat(pointW), height:CGFloat(pointH)))
        }
        
        context?.strokePath()
    }


    
}
