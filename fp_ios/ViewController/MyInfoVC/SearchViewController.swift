//
//  SearchViewController.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/19.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

/**
*  地址检索视图：1.输入地址检索 2.在地图上点击检索 3.定位
1.输入地址检索，加载检索结果列表，用户点击某地址获取并返回
2.在地图上点击检索，会将地址显示在列表中首个地址上（当前位置）
3.如果为传入地址参数，则先定位当前位置，反编码再检索当前位置
4、反编码再检索是因为POI检索需要keyword关键字，若只有经纬度检索不到结果
*/

import UIKit

/**
*  根据预约页面传过来的地址字串，如果为空则是只能选择的地址列表，否则是搜索地图
*/
typealias didSelectAddress = (_ info:BMKPoiInfo)->Void

class SearchViewController: BaseViewController,BMKMapViewDelegate,BMKLocationServiceDelegate, BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate ,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var mapView:BMKMapView!
    var searchTf:UITextField!
    var seachTableView:UITableView!
    var addressArray:Array<Any>!
    var poiInfo:BMKPoiInfo!
    var userLocation:BMKUserLocation!
    var nowPosition:String!
    var param:BMKLocationViewDisplayParam! // 精度圈
    
    var searchKeyword:String!
    var searcher:BMKPoiSearch!
    var option:BMKNearbySearchOption!
    var geoCodeSearch:BMKGeoCodeSearch!
    var reverseGeoCodeOption:BMKReverseGeoCodeOption!
    var locService:BMKLocationService!
    
    var myCoordinate:CLLocationCoordinate2D!
    var searchTfHeight:CGFloat!
    
    var selectedAddress:didSelectAddress!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if(self.locService != nil){
            self.locService.stopUserLocationService()
            self.locService = nil

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchKeyword = ""
        self.navbar.backButton.isHidden = false
        self.navbar.titleLabel.text = "地图"
        
        createTableView()
        createSearchView()
        startLocation()
        createSearchObj()//初始化检索对象
        createGeoCode()//反编码对象

        addView()

        
    }
    
    //初始化检索对象
    func createSearchObj()
    {
        searcher = BMKPoiSearch()
        searcher.delegate = self
        
        //发起检索
        option = BMKNearbySearchOption()
        option.pageIndex = 0
        option.pageCapacity = 100
        myCoordinate = CLLocationCoordinate2D(latitude: 30.0, longitude: 100)
        
        option.location = myCoordinate
        option.radius = 1000 //检索范围 m
    }
    
    //反编码对象
    func createGeoCode()
    {
        //反编码
        //根据定位到的经纬度获取城市
        geoCodeSearch = BMKGeoCodeSearch()
        geoCodeSearch.delegate = self
        
         //初始化逆地理编码类
        reverseGeoCodeOption = BMKReverseGeoCodeOption()
        
    }
    
    // 创建搜索输入
    func createSearchView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: SearchViewHeight))
        view.backgroundColor = SYS_BLUE
        let image = UIImage(named: "search_icon")
        
        let textField = UITextField(frame: CGRect(x: 10, y: 10, width: WIDTH-20, height: image!.size.height))
        textField.placeholder = "地点信息输入"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.delegate = self
        if searchKeyword != nil
        {
            textField.text = searchKeyword
        }
        view.addSubview(textField)
        self.view.addSubview(view)
        searchTf = textField
        
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0,width: image!.size.width,height: image!.size.height))
        searchBtn.contentMode = .scaleToFill
        searchBtn.setImage(image, for: UIControlState())
        searchBtn.addTarget(self, action: Selector("searchBegin"), for: .touchUpInside)
        textField.rightView = searchBtn
        textField.rightViewMode = .always
        
    }
    // 创建tableView
    func createTableView()
    {
        mapView = BMKMapView(frame: CGRect(x: 0, y: 64+SearchViewHeight, width: WIDTH, height: WIDTH/3.0*2))
        self.view.addSubview(mapView)
        
        seachTableView = UITableView(frame: CGRect(x: 0, y: 64+SearchViewHeight+WIDTH/3.0*2, width: WIDTH, height: HEIGHT-(64+SearchViewHeight+WIDTH/3.0*2)), style: .plain)
        seachTableView.delegate = self
        seachTableView.dataSource = self
        seachTableView.backgroundColor = UIColor.white
        seachTableView.keyboardDismissMode = .onDrag
//        seachTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "iden")
        self.view.addSubview(seachTableView)
        
    }
    
    //搜索按钮
    func searchBegin()
    {
        UIApplication.shared.sendAction(Selector("resignFirstResponder"), to: nil, from: nil, for: nil)
        
        if searchTf.text?.characters.count == 0
        {
            // 地址不能为空
            return
        }else{
            option.keyword = searchTf.text
        }
        
        let flag:Bool = searcher.poiSearchNear(by: option)
        if flag
        {
            NSLog("周边检索发送成功")
        }else{
            NSLog("周边检索发送失败");
        }
    }
    
    
    
    func addView()
    {
        param = BMKLocationViewDisplayParam()
        param.locationViewOffsetX = 0
        param.locationViewOffsetY = 0 //偏移量
        param.isAccuracyCircleShow = false //设置是否显示定位的那个精度圈
        param.isRotateAngleValid = false
        
        userLocation = BMKUserLocation()
        
        poiInfo = BMKPoiInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.viewWillAppear()
        mapView.delegate = self  // 此处记得不用的时候需要置nil，否则影响内存的释放
        locService.delegate = self
        geoCodeSearch.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil  // 不用时，置nil
        searcher.delegate = nil
        locService.delegate = nil
        geoCodeSearch.delegate = nil
        mapView = nil
        searcher = nil
        locService = nil
        geoCodeSearch = nil
        
    }
    
    // textField delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UIApplication.shared.sendAction(Selector("resignFirstResponder"), to: nil, from: nil, for: nil)
        searchBegin()
        
        return true
    }
    
    
    // 定位操作
    
    func startLocation()
    {
        NSLog("进入普通定位态");
        locService = BMKLocationService()
        
        BMKLocationService.setLocationDesiredAccuracy(10)
        BMKLocationService.setLocationDistanceFilter(10)
        locService.delegate = self
        
        //启动LocationService
        locService.startUserLocationService()
        mapView.showsUserLocation = false //先关闭显示的定位图层
        mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        mapView.showsUserLocation = true //显示定位图层
        
    }
    
    // 定位代理方法，更新当前位置
    func didUpdate(_ userLocation: BMKUserLocation!) {
//        NSLog("didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        
        myCoordinate = userLocation.location.coordinate
        
        //用户位置类
        mapView.updateLocationView(with: param)
        mapView.updateLocationData(userLocation)
        
        var coloac:CLLocationCoordinate2D! = CLLocationCoordinate2D()
        
        coloac.latitude = userLocation.location.coordinate.latitude
        coloac.longitude = userLocation.location.coordinate.longitude
        
        let span = BMKCoordinateSpan(latitudeDelta: 0.001,longitudeDelta: 0.001)
        let region = BMKCoordinateRegion(center: coloac,span: span)
        mapView.setRegion(region, animated: false)
        
        //需要反地理编码的坐标位置
        reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate
        
        geoCodeSearch.reverseGeoCode(reverseGeoCodeOption)
        
    }
    
    // 反地理编码 获取 当前位置
    
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        NSLog("province-%@city-%@ distreat%@--------",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district)
        
        //不能出现null  当前位置反编码获取地址字串
        let city:String = result.addressDetail.city
        let region:String = result.addressDetail.district
        let street:String = result.addressDetail.streetName
        
        poiInfo.pt = result.location
        poiInfo.name = city+region+street
        nowPosition = poiInfo.name
        searchForLocation()
    }
    
    //发起POI检索
    func searchForLocation()
    {
        if searchKeyword.characters.count != 0
        {
            option.keyword = searchKeyword
        }else{
            option.keyword = nowPosition
        }
        
        option.location = myCoordinate;
        option.radius = 1000; //检索范围 m
        
        let flag:Bool = searcher.poiSearchNear(by: option)
        if flag
        {
            NSLog("周边检索发送成功")
        }else{
            NSLog("周边检索发送失败");
        }
        
    }
    
    // 检测用户定位是否打开，没有打开则提示用户
    
    func didFailToLocateUserWithError(_ error: NSError!) {
        
        NSLog("Error: %@",error.localizedDescription);
        
    }
    
    
    // 实现PoiSearchDeleage处理回调结果
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        
        if poiResult == nil{
            print("周边检索失败") //继续检索
            searchForLocation()

            return
        }
        
        for i in 0 ..< poiResult.poiInfoList.count
        {
            let poi:BMKPoiInfo = poiResult.poiInfoList[i] as! BMKPoiInfo
            let item = BMKPointAnnotation()
            item.coordinate = poi.pt;
            item.title = poi.name;
            NSLog("%@",item.title);
            if i == 0
            {
                //地图重新定位
                let location = CLLocation(latitude: poi.pt.latitude, longitude: poi.pt.longitude)
                userLocation.setValue(location, forKey: "location")
                mapView.updateLocationData(userLocation)
                
                var coloac:CLLocationCoordinate2D! = CLLocationCoordinate2D()
                coloac.latitude = self.userLocation.location.coordinate.latitude;
                coloac.longitude = self.userLocation.location.coordinate.longitude;
                
                let span = BMKCoordinateSpan(latitudeDelta: 0.003,longitudeDelta: 0.003)
                let region = BMKCoordinateRegion(center: coloac,span: span)
                mapView.setRegion(region, animated: false)
                
                //当前位置更新
                poiInfo.pt = userLocation.location.coordinate;
                poiInfo.name = poi.name;
                
            }
        }
        self.addressArray = poiResult.poiInfoList;
        self.seachTableView.reloadData()
        
    }
    
    // TABLEVIEWDELEGATE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addressArray.count < 10
        {
            return addressArray.count + 1
        }else{
            return 11
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 10))
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "iden") as UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "iden")
        }
        if indexPath.row == 0
        {
            
            cell!.textLabel!.text = "当前位置"
            cell!.detailTextLabel!.text = poiInfo.name
        }else{
            let poi:BMKPoiInfo = addressArray[indexPath.row-1] as! BMKPoiInfo
            cell!.textLabel!.text = poi.name
            cell!.detailTextLabel!.text = nil
        }
        cell!.textLabel!.font = UIFont.systemFont(ofSize: 14);
        cell!.detailTextLabel!.textColor = UIColor.red;
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            self.selectedAddress(poiInfo)
            
            
        }else{
            self.selectedAddress(addressArray[indexPath.row-1] as! BMKPoiInfo)


            
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
//MARK:地图点击 手势操作
    
    /**
    *点中底图标注后会回调此接口
    *@param mapview 地图View
    *@param mapPoi 标注点信息
    */
    
    func mapView(_ mapView: BMKMapView!, onClickedMapPoi mapPoi: BMKMapPoi!) {
        UIApplication.shared.sendAction(Selector("resignFirstResponder"), to: nil, from: nil, for: nil)
        NSLog("onClickedMapPoi-%@",mapPoi.text);
        
        let location:CLLocation = CLLocation(latitude: mapPoi.pt.latitude, longitude: mapPoi.pt.longitude)
        userLocation.setValue(location, forKey: "location")
        mapView.updateLocationData(userLocation)
        
        //更新当前位置
        self.poiInfo.pt = mapPoi.pt;
        self.poiInfo.name = mapPoi.text;
        self.seachTableView.reloadData()
        searchTf.text = mapPoi.text;
        
    }
    
    #if __CC_PLATFORM_IOS
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
    
    }
    #endif
    
        
}
