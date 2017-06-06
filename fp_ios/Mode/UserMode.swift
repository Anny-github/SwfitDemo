//
//  UserMode.swift
//  fp_ios
//
//  Created by wss on 15/8/28.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import Foundation
import JSONJoy
/*
 
 //@property (nonatomic,strong) UIImage *photoImage;  // UIImage 类型
 
 @property (nonatomic,copy) NSString *grade;
 
 @property (nonatomic,copy) NSString *searchWord;
 @property (nonatomic,copy) NSString *titleNav;
 */
struct UserMode: JSONJoy {
    
    var userId:String!
    var userName:String?
    var userImage:String?
    var loginState:String?
    var loginType:String?
    var userSex:String?
    var phoneNum:String?
    var code:String?
    var sessionId:String!
    
    init() {
        
    }
    
    init(_ decoder: JSONDecoder) throws {
        
        self.userId = try decoder["userId"].get()
        self.userName = decoder["userName"].getOptional()
        self.userImage = decoder["userImage"].getOptional()
        self.loginState = decoder["loginState"].getOptional()
        self.loginType = decoder["loginType"].getOptional()
        self.userSex = decoder["userSex"].getOptional()
        self.phoneNum = decoder["phoneNum"].getOptional()
        self.code = decoder["code"].getOptional()
        self.sessionId = try decoder["sessionId"].get()
        
    }

}
