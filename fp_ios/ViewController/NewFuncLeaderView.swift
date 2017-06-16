//
//  NewFuncLeaderView.swift
//  fp_ios
//
//  Created by anne on 2017/6/16.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import UIKit

enum HoleStyle{
    
    case Ellipse, RoundRect, Rect
}

class NewFuncLeaderView: UIView {

    var images:[UIImage]!
    var imageFrames:[CGRect]!
    var imageOnViews:[UIView]!
    var holesFrames:[CGRect]!
    var holesOnViews:[UIView]!
    var holeStyle:HoleStyle!
    var responseClick:Bool!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show(_ images:[UIImage],_ imageFrames:[CGRect],imageOnViews:[UIView],_ holesFrames:[CGRect],_ holesOnviews:[UIView],_ holeStyle:HoleStyle,_ responseClick:Bool){
        
        let window = UIApplication.shared.delegate?.window!
        self.frame = (window?.bounds)!

        self.images = images
        for i in 0..<imageOnViews.count{ //计算要显示的图片的在window上的frame
            let view = imageOnViews[i]
            let frame = imageFrames[i]
            //计算相对window的frame
           let trueFrame = view.convert(frame, to: window)
            self.imageFrames.append(trueFrame)
            
        }
        for i in 0..<holesOnViews.count{ //计算要显示的按钮的在window上的frame
            let view = holesOnViews[i]
            let frame = holesFrames[i]
            //计算相对window的frame
            let trueFrame = view.convert(frame, to: window)
            self.holesFrames.append(trueFrame)
            
        }
        
        self.holeStyle = holeStyle
        self.responseClick = responseClick
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        let context  = UIGraphicsGetCurrentContext()
        
        //先画 半透明背景
        context?.setStrokeColor(UIColor.blue.withAlphaComponent(0.4).cgColor)
        context?.setFillColor(UIColor.blue.withAlphaComponent(0.4).cgColor)
        context?.addRect(rect)
        
        //画图片
        for i in 0..<self.images.count{
            let imageFrame:CGRect = self.imageFrames[i]
            context?.draw(self.images[i].cgImage!, in: imageFrame)
        }
        
        //画透明区
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.setFillColor(UIColor.clear.cgColor)
        
        switch self.holeStyle{
            
        case :
            print("")

        default:
            break
        }
        
        context?.strokePath()
    }
}
