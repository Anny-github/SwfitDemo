//
//  PaintView.swift
//  fp_ios
//
//  Created by anne on 2017/6/13.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

class PaintView: UIView {

    private var points:Int = 0
    var paintNum:Int = 0
    
    var tfWidth:Float = 0
    var tfHeight:Float = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        tfWidth = Float(frame.size.width)
        tfHeight = Float(frame.size.height)
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColor.black.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func totalPoints(pointNum:Int){
        self.points = pointNum
    }
    
    func paintPoints(pointsNum:Int){
        self.paintNum = pointsNum
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        //设置填充色
        context?.setFillColor(UIColor.black.cgColor)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(0.5)
        //画分割线
        let eachWidth = tfWidth/Float(self.points)
        
        for i in 1...self.points {
            let leftX = eachWidth * Float(i)
            context?.addLines(between: [CGPoint(x: CGFloat(leftX),y:CGFloat(0)),CGPoint(x: CGFloat(leftX),y:CGFloat(tfHeight))])
            
        }
        context?.strokePath()

        if self.paintNum == 0 {
            return
        }

        //画密码点
        let pointW = tfWidth/Float(self.points)/Float(2.5)
        let pointH = pointW
        
//        let eachWidth = tfWidth/Float(self.points)
        let y = (tfHeight - pointH)/2.0
        
        for i in 0...(self.paintNum-1) {
            //计算原点位置
            let leftX = eachWidth*Float(i) + (eachWidth-pointW)/2.0
            let rect = CGRect(x:CGFloat(leftX), y:CGFloat(y), width:CGFloat(pointW), height:CGFloat(pointH))
            context?.addEllipse(in: rect)
        }
        context?.fillPath()
    }
}
