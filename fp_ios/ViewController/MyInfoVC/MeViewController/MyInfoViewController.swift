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


class MyInfoViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate {
    var centerView: UIView!
    var headImgV: UIImageView!
//    lazy var usermode:UserMode = {
//        return try UserMode(JSONDecoder(SetUtil.checkSet()))
//        }()
    @IBOutlet weak var tableView: UITableView!
    
     //title数组
    var titleArr:Array<String>!
    var imageArr:Array<UIImage?>
    var newFuncView:NewFuncLeaderView!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        titleArr = ["关于我们","常见帮助测试WebKit","喜欢，鼓励一下","密码页测试","JS调OC","OC调JS","WebViewJavaScriptBridge"]
        imageArr = [Center_AboutUS_Icon,Center_FeedBack_Icon,Center_CommentUS_Icon,Center_FeedBack_Icon,Center_AboutUS_Icon,Center_AboutUS_Icon,Center_AboutUS_Icon]
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
//        getUserInfo()

//        let dic = SetUtil.checkSet()
//        headImgV.kf_setImageWithURL(URL(string: (dic["buyerIcon"] as! String))!, placeholderImage: HeadImage!)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = SYS_BGCOLOR
        self.navigationController?.delegate = self
        setSubViews()
        
        let testNewFuncBtn = UIButton.init(frame: CGRect(x:0,y:20,width:110,height:40))
        testNewFuncBtn.setTitle("测试新功能引导", for: .normal)
        testNewFuncBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.tableView.tableHeaderView?.addSubview(testNewFuncBtn)
        testNewFuncBtn.addTarget(self, action: #selector(self.showNewFuncLeaderView), for: .touchUpInside)
        
        showNewFuncLeaderView()
       
    }
    
    func showNewFuncLeaderView(){

        self.newFuncView = NewFuncLeaderView()
        
        //第三个cell的frame
        let cellFrame = tableView.rectForRow(at: IndexPath.init(row: 1, section: 0))
        let cellViewFrame = tableView.convert(cellFrame, to: self.view)
        
        //一个页面显示所有引导
//        newFuncView.show([UIImage(named:"好课推荐")!,UIImage(named:"考研切图")!], imageFrames: [CGRect(x:SRC_WIDTH/4.0,y:self.centerView.y - 70,width:120,height:50),CGRect(x:50,y:cellFrame.origin.y+cellFrame.size.height + 5,width:120,height:60)], holesFrames: [CGRect(x:0,y:self.centerView.y,width:self.centerView.width/2.0,height:self.centerView.height),cellViewFrame], holesOnviews: [self.tableView.tableHeaderView!,self.view], holeStyle: .roundRect, responseClick: true)

        //两个引导的做法
        self.newFuncView.reactClick = {
            self.newFuncView = NewFuncLeaderView()
            self.newFuncView.show([UIImage(named:"考研切图")!], imageFrames: [CGRect(x:50,y:cellFrame.origin.y+cellFrame.size.height + 5,width:120,height:60)], holesFrames: [cellViewFrame], holesOnviews: [self.view], holeStyle: .rect, responseClick: false)
            
        }
        
        self.newFuncView.show([UIImage(named:"好课推荐")!], imageFrames: [CGRect(x:SRC_WIDTH/4.0,y:self.centerView.y - 70,width:120,height:50)], holesFrames: [CGRect(x:0,y:self.centerView.y,width:self.centerView.width/2.0,height:self.centerView.height)], holesOnviews: [self.tableView.tableHeaderView!], holeStyle: .roundRect, responseClick: false)
        
    }
    
    func getUserInfo(){
        
        let param = ["phone":"15910615632","userPass":"E10ADC3949BA59ABBE56E057F20F883E"]
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
                TSLog(result)
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
        personBtn.addTarget(self, action: #selector(self.personInfoBtn), for: .touchUpInside)
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
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SRC_WIDTH, height: 10))
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
        //帮助与反馈
        let helpVC:HelpH5Controller = HelpH5Controller()
//        //喜欢，鼓励
        
        //密码页
        
        
        //JS OC
        
//
        switch(indexPath.row){
        case 0:
            self.navigationController?.pushViewController(aboutVC, animated: true)
        
        case 1:
            self.navigationController?.pushViewController(helpVC, animated: true)
//        case 2: //跳转appStore
//            let str = "http://itunes.apple.com/us/app/id" + "12344"
//            UIApplication.shared.openURL(URL(string: str)!)
//            break
        case 3: //密码
            self.navigationController?.pushViewController(PwdInputVC(), animated: true)
            
        case 4:
            self.navigationController?.pushViewController(JSCallOC(), animated: true)
            
        case 5:
            self.navigationController?.pushViewController(OCCallJS(), animated: true)
            
        case 6:
            self.navigationController?.pushViewController(JSBOCAndJS(), animated: true)
            
        default:print("")
            
        }
//
        
    }
    
    //MARK: personInfoBtn
    func personInfoBtn(){
    
        self.navigationController?.pushViewController(PersionInfoVC(), animated: true)
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
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        var isSelf = false
        if viewController is MyInfoViewController{
            isSelf = true
        }
        self.navigationController?.setNavigationBarHidden(isSelf, animated: true)
    }    // 将要显示控制器
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}
