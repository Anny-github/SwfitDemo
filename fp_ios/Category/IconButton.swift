//
//  IconButton.swift
//  fp_ios
//
//  Created by wss on 15/8/13.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit
import Foundation

class IconButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustsImageWhenHighlighted = false
        self.titleLabel!.textAlignment = NSTextAlignment.center
        self.imageView!.contentMode = UIViewContentMode.center
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageX:CGFloat = 0
        let imageY:CGFloat = 0
        let imageW:CGFloat = self.width
        let imageH:CGFloat = self.height-20
        
        return CGRect(x: imageX, y: imageY, width: imageW, height: imageH)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX:CGFloat = 0
        let titleY:CGFloat = self.height * 2.0/3.0
        let titleW:CGFloat = self.width
        let titleH:CGFloat = self.height - titleY
        
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    
    

}
