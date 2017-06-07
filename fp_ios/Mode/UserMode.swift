//
//  UserMode.swift
//  fp_ios
//
//  Created by wss on 15/8/28.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 
 //@property (nonatomic,strong) UIImage *photoImage;  // UIImage 类型
 
 @property (nonatomic,copy) NSString *grade;
 
 @property (nonatomic,copy) NSString *searchWord;
 @property (nonatomic,copy) NSString *titleNav;
 */
struct UserMode: Mappable{
    
    var userId:String!
    var userName:String!
    var userImage:String!
    var loginState:String!
    var loginType:String!
    var userSex:String!
    var phoneNum:String!
    var code:String!
    var sessionId:String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userId 	 <- map["userId"]
        userName <- map["userName"]
    }

}
