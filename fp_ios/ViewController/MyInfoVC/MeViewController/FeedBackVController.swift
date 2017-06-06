//
//  FeedBackVController.swift
//  
//
//  Created by wss on 15/9/15.
//
//反馈页

import UIKit
import JSONJoy
import SVProgressHUD

class FeedBackVController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView!
    var textView:FPTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SYS_BGCOLOR
        createSubViews()

    }

    //TODO: 创建子视图
    func createSubViews(){
        let bgVIew = UIView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: (WIDTH-20)/2.0 + 40))
        bgVIew.backgroundColor = SYS_BGCOLOR
        //输入栏
        textView = FPTextView(frame: CGRect(x: 10,y: 10, width: WIDTH-20, height: (WIDTH-20)/2.0))
        textView.setPlayceHolder("请输入您的宝贵意见...")
        bgVIew.addSubview(textView)
        textView.layer.cornerRadius = 5.0
        textView.layer.masksToBounds = true
        textView.layer.borderColor = SYS_BLUE.cgColor
        textView.layer.borderWidth = 1.0
        //保存按钮
        let btn:UIButton = UIButton(frame: CGRect(x: textView.right - 50, y: textView.bottom-20, width: 40, height: 40))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle("提交", for: UIControlState())
        btn.backgroundColor = SYS_BLUE
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        bgVIew.addSubview(btn)
        btn.addTarget(self, action: Selector("commitFeedback"), for: UIControlEvents.touchUpInside)
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: HEIGHT-64))
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.tableHeaderView = bgVIew
        tableView.keyboardDismissMode = .onDrag
        
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 100))
        footView.backgroundColor = SYS_WHITE
        tableView.tableFooterView = footView
        
    }
    
    //TODO :TableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        var cell = tableView.dequeueReusableCell(withIdentifier: "feedBackCell")
        if cell == nil{
            cell =  UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "feedBackCell")
        }
        cell?.imageView?.image = UIImage(named: "ap_icon")
        cell?.textLabel?.text = "新用户注册流程"
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell?.textLabel?.textColor = TITLE_GRAY
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
        
    }
   
    //TODO: 提交反馈
    func commitFeedback(){
        
        if textView.text.characters.count == 0
        {
            return
        }
        
            
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.sendAction(Selector("resignFirstResponder"), to: nil, from: nil, for: nil)
    }
        
    

}
