//
//  Common_StaticValue.swift
//  fp_ios
//
//  Created by wss on 15/8/25.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//

import UIKit

//完善信息标志
let PERFECTINFO:String = "perfectInfo"


//状态栏
let STATUS_BAR_HEIGHT:CGFloat = 20
//导航栏
let NAV_BAR_HEIGHT:CGFloat = 44

let BAIDU_MAPKEY:String = "GUIj1xIxHWMynTduWvjZr7iH"
//搜索栏高度
let SearchViewHeight:CGFloat = 50

let SRC_WIDTH:CGFloat =  UIScreen.main.bounds.size.width
let SRC_HEIGHT:CGFloat =  UIScreen.main.bounds.size.height


//字体颜色
let TITLE_BLUECOLOR:UIColor = Tools.colorFromRGB(0x1ab29c)
let TITLE_YELLOW:UIColor = Tools.colorFromRGB(0x1ff6b08)
let TITLE_GRAY:UIColor = Tools.colorFromRGB(0x666666)

//背景颜色
let SYS_BASECOLOR:UIColor = Tools.colorFromRGB(0xe7efee)
let SYS_BLUE:UIColor = Tools.colorFromRGB(0x29bca7)
let SYS_DARKBLUE:UIColor = Tools.colorFromRGB(0x08544a)
let SYS_LIGHTBLUE:UIColor = Tools.colorFromRGB(0xb0faef)
let SYS_BGCOLOR:UIColor = Tools.colorFromRGB(0xe7efee)


let SYS_RED:UIColor = Tools.colorFromRGB(0xff003c)
let SYS_DARKYELLOW:UIColor = Tools.colorFromRGB(0xff6b08)
let SYS_YELLOW:UIColor = Tools.colorFromRGB(0xffab10)

let SYS_DARKGRAY:UIColor = Tools.colorFromRGB(0xa0a0a0)
let SYS_GARY:UIColor = Tools.colorFromRGB(0xc0c0c0)

let SYS_WHITE:UIColor = UIColor.white
let SYS_CLEAR:UIColor = UIColor.clear
let HEADER_BORDERCOLOR = Tools.colorFromRGB(0xaac7c3)
let IMAGE_BGCOLOR = Tools.colorFromRGB(0xd0d0d0)

//通知
let NOFI_LOGINSUCCESS = "loginSuccess"
let NOFI_CHANGEINFO   = "changeUserInfo"
let NOFI_CHANGEINFO_PRODUCT = "changeProductInfo"

//图片 
//头像
let HeadImage = UIImage(named: "head_icon")
//tabBar
let Tab_OrderImg_NoSelect = UIImage(named: "bill_bottomnav_up_icon")?.withRenderingMode(.alwaysOriginal)

let Tab_OrderImg_Select = UIImage(named: "bill_bottomnav_down_icon")?.withRenderingMode(.alwaysOriginal)
let Tab_MarketImg_Select = UIImage(named: "market_bottomnav_down_icon")?.withRenderingMode(.alwaysOriginal)
let Tab_MarketImg_NoSelect = UIImage(named: "market_bottomnav_up_icon")?.withRenderingMode(.alwaysOriginal)
let Tab_MeImg_NoSelect = UIImage(named: "me_bottomnav_up_icon")?.withRenderingMode(.alwaysOriginal)
let Tab_MeImg_Select = UIImage(named: "me_bottomnav_down_icon")?.withRenderingMode(.alwaysOriginal)

//NavigationBar
let NaBar_ReturnImg = UIImage(named: "replay_icon")


//订单
let Order_ArrowImg = UIImage(named: "arrow_icon")
let Order_RemarkBg = UIImage(named: "bill_remarks_bg")
let Order_Remark_DownBg = UIImage(named: "bill_remarks_down_bg")
let Order_Describ_Icon = UIImage(named: "description_icon")
let Order_Map_Icon = UIImage(named: "map_icon")
let Order_Newmap_Icon = UIImage(named: "newbill_map_icon")
let Order_Photo_Icon = UIImage(named: "photo_icon")
let Order_SaveRemark_Icon = UIImage(named: "save_icon")

let Order_PlaceHolderImage = UIImage(named: "image_loadding_bg")

//个人中心
let Center_TopArrow_Icon = UIImage(named: "arrow_info_bg")
let Center_Bottle_Icon = UIImage(named: "bottle_icon")
let Center_Electric_Icon = UIImage(named: "electric_icon")
let Center_Metal_Icon = UIImage(named: "metal_icon")
let Center_Paper_Icon = UIImage(named: "paper_icon")
let Center_Perfect_Info_Icon = UIImage(named: "perfect_info_up_icon")
let Center_Produce_Down_Icon = UIImage(named: "perfect_product_up_icon")
let Center_Produce_Up_Icon = UIImage(named: "perfect_product_down_icon")
let Center_AboutUS_Icon = UIImage(named: "mancenter_about_icon")
let Center_CommentUS_Icon = UIImage(named: "mancenter_great_icon")
let Center_FeedBack_Icon = UIImage(named: "mancenter_help_icon")
let Center_PersonInfo_Icon = UIImage(named: "mancenter_info_icon")
let Center_ProductInfo_Icon = UIImage(named: "mancenter_product_icon")



//二手市场

let Market_Post_AddPhoto = UIImage(named: "addphoto_icon")
let Market_Post_DeletePhoto = UIImage(named: "del_icon")
let Market_Phone_Icon = UIImage(named: "tel_icon")

let Market_CollecteUp_Icon = UIImage(named: "collection_up_icon")
let Market_CollecteDown_Icon = UIImage(named: "collection_down_icon")
let Market_Report_Icon = UIImage(named: "report_icon")

//登录
let Login_PhoneUp_Icon = UIImage(named: "tel_verification_up_icon@2x.png")!
let Login_PhoneDown_Icon = UIImage(named: "tel_verification_down_icon")
let Login_VerCodeUp_Icon = UIImage(named: "login_disable_icon")
let Login_VerCodeDown_Icon = UIImage(named: "login_down_icon")
let SignOut_Icon = UIImage(named: "sign_out_icon")

//共用
let Selected_RightIcon = UIImage(named: "right_icon")
let NOSelected_RightIcon = UIImage(named: "radio_up_bg")


class Common_StaticValue: NSObject {
   
}
