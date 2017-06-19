//
//  NewFuncLeaderView.swift
//  fp_ios
//
//  Created by anne on 2017/6/16.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

enum HoleStyle:Int{
    case ellipse, roundRect, rect
}

typealias ReactClick = ( )->Void

class NewFuncLeaderView: UIView {

    var reactClick:ReactClick!
    var images:[UIImage]!
    var imageFrames:[CGRect]!
    var holesFrames:[CGRect]!
    var holeStyle:HoleStyle = .rect
    var responseClick:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.imageFrames = Array()
        self.holesFrames = Array()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        images: 要显示的图片
        imageFrams： 图片要显示的位置
        holesFrames: 透明区域，诸如按钮等的frame
        holesOnViews：透明区域，诸如按钮的frame， 根据所在view计算相对于window的frame
        holeStyle：透明区域样式，圆形，矩形，圆角矩形
        responseClick：响应按钮事件点击
     */
    func show(_ images:[UIImage],imageFrames:[CGRect],holesFrames:[CGRect],holesOnviews:[UIView],holeStyle:HoleStyle,responseClick:Bool){
        let window = UIApplication.shared.delegate?.window!
        self.frame = (window?.bounds)!
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.images = images
        self.imageFrames = imageFrames
        
        for i in 0..<holesOnviews.count{ //计算要显示的按钮的在window上的frame
            let view = holesOnviews[i]
            let frame = holesFrames[i]
            //计算相对window的frame
            let trueFrame = view.convert(frame, to: window)
            self.holesFrames.append(trueFrame)
        }
        
        self.holeStyle = holeStyle
        self.responseClick = responseClick
        window?.addSubview(self)
        self.setNeedsDisplay()
        
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        let context  = UIGraphicsGetCurrentContext()
        
//        //先画 半透明背景
//        let color = UIColor.white.withAlphaComponent(0.3)
//        context?.setStrokeColor(color.cgColor)
//        context?.setFillColor(color.cgColor)
//        context?.addRect(CGRect(x:0,y:0,width:rect.size.width,height:rect.size.height))
//        context?.fillPath()
        
        
//        //画图片
        for i in 0..<self.images.count{
            let imageFrame:CGRect = self.imageFrames[i]
            self.images[i].draw(in: imageFrame)
        }
//
//        //画透明区
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.setFillColor(UIColor.clear.cgColor)
        context?.setBlendMode(.clear)
        switch self.holeStyle{
        case .ellipse:
            for i in 0..<self.holesFrames.count{
                context?.addEllipse(in: self.holesFrames[i])

            }
        case .roundRect:
            for i in 0..<self.holesFrames.count{
                let rect = self.holesFrames[i]
                let bezierPath = UIBezierPath.init(roundedRect: rect, cornerRadius: 5)
                context?.addPath(bezierPath.cgPath)
                
            }
        case .rect:
            for i in 0..<self.holesFrames.count{
                context?.addRect(self.holesFrames[i])
            }
            
        default:
            break
         
        }
        context?.fillPath()

    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.responseClick{  //响应点击事件，遮罩就不能拦截点击
            self.removeFromSuperview()
            return false
        }
    
        return true //不响应按钮事件，拦截点击
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //override func point(inside point: CGPoint, with event: UIEvent?) -> Bool  如果返回YES 才会走到这里，说明是点击消失遮罩
        let point = touches.first?.location(in: self)
        for frame in self.holesFrames{
            if frame.contains(point!){
                if self.reactClick != nil {
                    self.reactClick()

                }
                self.removeFromSuperview()
            }
        }
    }
}


