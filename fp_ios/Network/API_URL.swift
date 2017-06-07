//
//  API_URL.swift
//  fp_ios
//
//  Created by yushuhui on 15/8/17.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//http://123.56.112.131:8080/fpx-mobile-war/
//http://wechat.98daijia.com/fpx-mobile-war

let TEST_BASE_URL:String  = "http://192.168.0.170:8080/fpx-mobile-war/"    //      测试地址
//http://ec2-54-254-202-112.ap-southeast-1.compute.amazonaws.com
//http://api.yingshibao.com/
let BASE_URL:String = "http://api.yingshibao.com/"  //      正式地址

let HTTP_METHOD:String    = "POST"              //      客户端与服务器端交互接口，均使用POST方法。
let APPKEY:String         = "FPX_2015_KEY"      //      客户端与服务器端交互接口，均使用POST方法。
let VALIDATE_CODE:String  = "common/getValidateCode.action"   //4.1	获取验证码接口
let LOGIN:String          = "buyer/login.action"             //4.2	登录接口
let UPDATE_INFO:String    = "buyer/updateBuyerInfo.action"   //4.3	设置个人资料接口
let CATEGORY_LIST:String  = "buyer/getCategoryList.action"   //4.4	获取系统回收分类列表接口
let SUBMIT_LIST:String    = "buyer/submitCategoryList.action"//4.5	提交设置后的回收分类信息接口
let UNORDER_LIST:String   = "buyer/getUnOrderList.action"    //4.6	获取未接订单接口
let ORDER_LIST:String     = "buyer/getOrderList.action"      //4.7	获取已接订单接口
let ACCEPT_ORDER:String   = "buyer/acceptOrder.action"       //4.8	接收订单接口
let REJECT_ORDER:String   = "buyer/rejectOrder.action"       //4.9	拒绝订单接口
let CLODSE_ORDER:String   = "buyer/closeOrder.action"        //4.10	结束订单接口
let ORDER_REMARK:String   = "buyer/submitOrderRemark.action" //4.11	提交订单备注接口
let CONTACT_RECORD:String = "common/submitContactRecord.action"//4.12	提交拨打电话记录接口
let TOPIC_LIST:String     = "common/getAllUsedTopicList.action"//4.13	获取二手市场信息列表接口
let MYTOPIC_LIST:String   = "common/getUsedTopicListBySenderId.action"//4.14	获取我发布的二手市场信息列表接口
let SUBMIT_TOPIC:String   = "common/submitUsedTopic.action"   //4.15	发布二手消息接口
let COLLECTION:String     = "common/collectionTopic.action"   //4.16	收藏帖子接口
let CANCEL_TOPIC:String   = "common/cancelCollectionTopic.action"//4.17	取消收藏帖子接口
let MY_COLLECTION:String  = "common/getCollectionTopicListByCollectorId.action"//4.18	获取我收藏的帖子列表接口
let SUBMIT_REPORT:String  = "common/submitReport.action"      //4.19	举报接口
let OPTION_LIST:String    = "common/getCloseOptionList.action"//4.20	获取帖子关闭时选项接口
let CLOSE_TOPIC:String    = "common/submitCloseTopic.action"  //4.21	关闭帖子接口
let FEED_BACK:String      = "common/submitFeedback.action"    //4.22	反馈接口
let UPLOAD_FILE:String    = "common/uploadFile.action"        //4.23	上传照片接口
let GET_USRINFO:String    = "buyer/getBuyerInfo.action" //4.24 获取个人资料
let GET_COMMUNITYLIST:String = "common/getCommunityList.action"  //4.25获取周围小区列表
let TOPIC_UPDATE:String   = "common/updateUsedTopic.action"  //4.26 修改帖子



