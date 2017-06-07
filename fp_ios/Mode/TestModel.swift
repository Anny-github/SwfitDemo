//
//  TestModel.swift
//  fp_ios
//
//  Created by anne on 2017/6/7.
//  Copyright © 2017年 yushuhui. All rights reserved.
//

import Foundation
import ObjectMapper


struct TabBar:Mappable {
    var tabtitlecolor:String?
    var tabselectitlecolor:String?
    var tabbar_expire_time:Double?
    var tabbarbackimage:String?
    var tabs:[[String:Any]]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        tabtitlecolor 	     <- map["tabtitlecolor"]
        tabselectitlecolor   <- map["tabselectitlecolor"]
        tabbar_expire_time   <- map["tabbar_expire_time"]
        tabbarbackimage      <- map["tabbarbackimage"]
        tabs                 <- map["tabs"]
    }
    
}

struct TestModel: Mappable {
    
    var api_ssl:Bool?
    var store:[String:Any]? = [:]
    var tabbar:TabBar?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        api_ssl 	<- map["api_ssl"]
        store       <- map["store"]
        tabbar       <- map["tabbar"]
    }
}
