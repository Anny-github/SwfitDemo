//
//  MyInfoViewController.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/12.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

// 我（1、有个人资料和产品资料入口  2、关于我们 3、帮助反馈  4、鼓励（appStore））
import UIKit
import ObjectMapper

let TestGetUrl = "http://www.xiaohongshu.com/api/sns/v1/system_service/config?build=421018&deviceId=4BDA1423-0084-4D19-8696-B570B3DBF43B&lang=zh&launchtimes=4&package=com.xingin.discover&platform=iOS&sid=session.1181171505858585505&sign=3e3ef0c177e7cf91a3e6e3856a97dc23&t=1496820966&version=4.21"


class MyInfoViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    var centerView: UIView!
    var headImgV: UIImageView!
//    lazy var usermode:UserMode = {
//        return try UserMode(JSONDecoder(SetUtil.checkSet()))
//        }()
    
    @IBOutlet weak var tableView: UITableView!
    
     //title数组
    var titleArr:Array<String>!
    var imageArr:Array<UIImage?>
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        titleArr = ["关于我们","帮助与反馈","喜欢，鼓励一下"]
        imageArr = [Center_AboutUS_Icon,Center_FeedBack_Icon,Center_CommentUS_Icon]
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    //MARK:重写init方法，走xib初始化方法
    convenience  init(){
        let nibNameStr = String?("MyInfoViewController")
        self.init(nibName:nibNameStr, bundle:Bundle.main)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //修改资料
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserInfo()

//        let dic = SetUtil.checkSet()
//        headImgV.kf_setImageWithURL(URL(string: (dic["buyerIcon"] as! String))!, placeholderImage: HeadImage!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SYS_BGCOLOR
        self.navbar.isHidden = true
        self.statusView.isHidden = true
//        self.statusView.backgroundColor = SYS_BLUE
        UIApplication.shared.setStatusBarHidden(true, with: .none)

        setSubViews()

    }
    
    func getUserInfo(){
        
        let param = ["phone":"15910615632","userPass":"E10ADC3949BA59ABBE56E057F20F883E"]
//        let jsonStr = "{\"phone\" : \"15910615632\",\"userPass\" : \"E10ADC3949BA59ABBE56E057F20F883E\"}"
//        
//        let data = jsonStr.data(using: .utf8)
//        let dict = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        Network_Manager.shareInstance().postRequest("userSession/loginByPhonePass", params: param) { (result, success) in
            if success {
                if result.characters.count > 0{ //证明有data字段
                    //解析
                    
                }else{
                    TSLog("请求成功")
                }
                
            }else{
                TSLog("请求失败")
                if result.characters.count > 0{
                    AppStatusPop.showErrorWithStatus(result)

                }
            }
            
        }
        
        /*Network_Manager.shareInstance().getRequest(urlString: TestGetUrl, params: [:]) { (result, success) in
            if success{
                let testmodel = Mapper<TestModel>().map(JSONString:result)
                
                TSLog("api_ssl ======= \(testmodel?.api_ssl)" )
                
                TSLog("testmodel?.store ====== \(testmodel?.store)")
                TSLog("testmodel?.tabbar?.tabtitlecolor==========\(testmodel?.tabbar?.tabtitlecolor)")
                for dic in (testmodel?.tabbar?.tabs?.enumerated())!{
                    
                    TSLog(dic)
                }


            }else{

            }
        }*/
        

        
        let urlString = "advertisement/getAdList"
        let dic = ["examType":"3"]
//        Network_Manager.shareInstance().postRequest(urlString, params: dic) { (dictionary, success) in
//            
//        }
//        Alamofire.request("http://api.yingshibao.com/advertisement/getAdList", method: .post, parameters: strParams).responseJSON { (responseData) in
//            
//        }
//        
////        Alamofire.request("http://api.yingshibao.com/advertisement/getAdList", method: .post, parameters: strParams).response { (responseData) in
////            
////            TSLog( try?  JSONSerialization.jsonObject(with: responseData.data!, options: JSONSerialization.ReadingOptions.allowFragments))
////        }
        

        
    }
    func setSubViews(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SRC_WIDTH, height: 160+115+40))
        headerView.backgroundColor = SYS_BGCOLOR;
        
        //头像视图
        let headImgBgV = UIView(frame: CGRect(x: 0, y: 0, width: SRC_WIDTH, height: 160))
        headImgBgV.backgroundColor = SYS_BLUE
        headerView.addSubview(headImgBgV)
        
        //头像
        headImgV = UIImageView(frame: CGRect(x: SRC_WIDTH/2.0-50, y: 20, width: 100, height: 100))
        headImgV.isUserInteractionEnabled = true
        headImgV.layer.cornerRadius = 50
        headImgV.layer.masksToBounds = true
        headImgV.image = HeadImage
//        headImgV.
        
        //边框
        headImgV.layer.borderColor = HEADER_BORDERCOLOR.cgColor
        headImgV.layer.borderWidth = 2
        headImgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headImgChangeBtnClick)))
        headImgBgV.addSubview(headImgV)
        //点击修改btn
//        let btn = UIButton(frame: CGRectMake(-20, headImgV.bottom - 20, headImgV.width+20, 25))
//        btn.setTitle("点击修改", forState: UIControlState.Normal)
//        btn.titleLabel?.font = UIFont.systemFontOfSize(16)
//        btn.layer.cornerRadius = 15
//        btn.setTitleColor(Common_define.RGB(82,g: 128,b: 118), forState: UIControlState.Normal)
//        btn.backgroundColor = Common_define.RGB(185,g: 191,b: 190).colorWithAlphaComponent(0.8)
//        
//        btn.addTarget(self, action: Selector("headImgChangeBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
//        headImgBgV.addSubview(btn)
//        btn.setCenterX(headImgV.centerX)
        let nameL = UILabel(frame: CGRect(x: 0, y: headImgV.bottom+5, width: SRC_WIDTH, height: 30))
        nameL.setCenterX(headImgBgV.centerX)
        nameL.textColor = SYS_WHITE
        nameL.textAlignment = NSTextAlignment.center
        nameL.text = "用户名"
        headImgBgV.addSubview(nameL)
        
        
        //
        centerView = UIView(frame: CGRect(x: 0, y: headImgBgV.bottom+20, width: SRC_WIDTH, height: 115))
        centerView.backgroundColor = UIColor.white
        headerView.addSubview(centerView)
        //MARK: 个人和产品资料按钮
        let personBtn:IconButton = IconButton(frame: CGRect(x: 10, y: 0, width: self.centerView.width/2.0-10, height: self.centerView.height))
        personBtn.setImage(Center_PersonInfo_Icon, for:UIControlState())
        personBtn.setTitle("个人资料", for: UIControlState())
        personBtn.setTitleColor(TITLE_GRAY, for: UIControlState())
//        personBtn.addTarget(self, action: Selector("personInfoBtn:"), for: UIControlEvents.touchUpInside)
        let produceBtn:IconButton = IconButton(frame: CGRect(x: centerView.width/2.0, y: 0, width: centerView.width/2.0-10, height: centerView.height))
        produceBtn.setImage(Center_ProductInfo_Icon, for:UIControlState())
        produceBtn.setTitle("产品资料", for: UIControlState())
        produceBtn.setTitleColor(TITLE_GRAY, for: UIControlState())
//        produceBtn.addTarget(self, action: Selector("produceInfoBtn:"), for: UIControlEvents.touchUpInside)
        self.centerView.addSubview(personBtn)
        self.centerView.addSubview(produceBtn)
        
        //MARK:tableView列表
        tableView.backgroundColor = SYS_BGCOLOR
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableHeaderView = headerView
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SRC_WIDTH, height: SRC_HEIGHT - headerView.height - 100))
        view.backgroundColor = SYS_BGCOLOR
        self.tableView.tableFooterView = view
        self.tableView.isScrollEnabled = true
        
    }
    
    //TODO: UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = titleArr[indexPath.row] as String
        cell.textLabel?.textColor = TITLE_GRAY
        cell.imageView?.image = imageArr[indexPath.row] as UIImage!
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //关于
        let aboutVC:AboutViewController = AboutViewController()
//        //帮助与反馈
//        let feedVC:FeedBackVController = FeedBackVController()
//        feedVC.hidesBottomBarWhenPushed = true
//        //喜欢，鼓励
//        
        switch(indexPath.row){
        case 0:
            self.navigationController?.pushViewController(aboutVC, animated: true)
            break
//        case 1:
//            self.navigationController?.pushViewController(feedVC, animated: true)
//            break
//        case 2: //跳转appStore
//            let str = "http://itunes.apple.com/us/app/id" + "12344"
//            UIApplication.shared.openURL(URL(string: str)!)
//            break
            
        default:print("")
            
        }
//
        
    }
    
    
    
    //TODO:修改头像
    func headImgChangeBtnClick(){
        let cameraV:CameraView = CameraView()
        
        
        cameraV.showCamera { (selectImg, imgName, imgPath) -> Void in
             self.headImgV.image = selectImg

            //上传头像
            //用户id
//            let imgParams = ["uploaderId":buyerId,"uploaderType":"1","uploadFrom":"1","file":imgPath,"fileName":imgName]
//            
//            var buyerIcon:String = String()
//            Network_Manager.shareInstance().uploadFile(imgParams, passValue: { (dic, success) -> Void in
//                if(success){
//                    buyerIcon = dic["fileUrl"] as! String
//                    SetUtil.changeUserHeader(buyerIcon)
//                    self.headImgV.image = selectImg
//                }
//            })

        }
       
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
