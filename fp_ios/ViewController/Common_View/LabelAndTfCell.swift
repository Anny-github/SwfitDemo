//
//  LabelAndTfCell.swift
//  fp_ios
//
//  Created by wss on 15/8/26.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit

class LabelAndTfCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var rightTf: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rightTf.clearButtonMode = UITextFieldViewMode.whileEditing
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        // Configure the view for the selected state
    }
    
}
