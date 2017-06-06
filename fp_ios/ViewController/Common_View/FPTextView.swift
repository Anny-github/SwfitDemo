//
//  FPTextView.swift
//  
//
//  Created by wss on 15/9/15.
//
//


import UIKit

class FPTextView: UITextView,UITextViewDelegate{

    var placehoderLabel:UILabel!
    var placehoder:String!
    var placehoderColor:UIColor!
    
    override  init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        placehoderLabel = UILabel()
        placehoderLabel.numberOfLines = 0
        placehoderLabel.backgroundColor = SYS_WHITE
        placehoderLabel.textColor =  TITLE_GRAY
        self.addSubview(placehoderLabel)
        // 设置默认的占位文字颜色
        self.placehoderColor = UIColor.lightGray
        
        // 设置默认的字体
        self.font = UIFont.systemFont(ofSize: 14)
        
        // 监听内部文字改变
        NotificationCenter.default.addObserver(self, selector: Selector("textDidChange"), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: 文字改变
    func textDidChange(){
        placehoderLabel.isHidden = self.hasText
    }
   
    func setPlayceHolder(_ placeholder:String){
        self.placehoder = (placeholder as NSString) as String!
        placehoderLabel.text = placeholder
    }
    
    override func  layoutSubviews() {
        self.placehoderLabel.setY(8)
        self.placehoderLabel.setX(5)
        self.placehoderLabel.setWidth(self.width - 2 * self.placehoderLabel.x)
        // 根据文字计算label的高度
        let maxSize:CGSize = CGSize(width: self.placehoderLabel.width, height: 100000.0);
        let placehoderSize:CGSize = self.placehoder.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:self.placehoderLabel.font], context: nil).size
       
        self.placehoderLabel.setHeight(placehoderSize.height)
    }
}
