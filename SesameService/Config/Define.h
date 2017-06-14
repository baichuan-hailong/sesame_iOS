//
//  Define.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/15.
//  Copyright © 2017年 anju. All rights reserved.
//

#ifndef Define_h
#define Define_h

//*** 屏幕尺寸 ***//
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

//*** 色调值 ***//
#define tonalColor      @"00BF8F"
#define backColor       @"f7f7f7"
#define backGroundColor @"f7f7f7"


//API地址
//#define APIDev               @"http://api.brands500.cn"
#define APIDev               @"http://api1.zhimashangfu.com"
//#define APIDev               @"http://api.zhimashangfu.com"
//#define h5Dev                @"http://m.brands500.cn"
#define h5Dev                @"http://m1.zhimashangfu.com"
//#define h5Dev                @"http://m.zhimashangfu.com"

//邀请好友
#define InviteFriends        @"http://m1.zhimashangfu.com/invite.html"

#define AgreementUrl         @"http://m1.zhimashangfu.com/member_agreement.html"
//阿里云
#define AliBucket            @"sesame-dev"


//Outside the network path
#define OutsideNetWorkPath   @"http://zm-dn.wanbangbang.cn/"



//OSS
#define PrefixAVATAR         @"avatar"
#define PrefixATTACHMENTS    @"attachments"
#define PrefixResource       @"resource"




//用户头像
#define AVATAR               @"avatar/"
//信息附件
#define INFO                 @"attachments/info/"
//问题附件
#define QUESTION             @"attachments/question/"
//答案附件
#define Answer               @"attachments/answer/"
//用户身份证、奖项荣誉等附件
#define ResourceUser         @"resource/user/"



//pro 59151dea99f0c706fb001fdd

//#define UM_APPKEY       @"59151dea99f0c706fb001fdd"

//dev 59151dc3677baa402a0017e9
#define UM_APPKEY       @"59151dc3677baa402a0017e9"


//wechat
#define WechatAppID     @"wxd7e440b513ecc397"
#define wechatAppSecret @"1014de0f0f90348bf561bd2296ce4073"

//QQ
#define QQAppID        @"1106086020"
#define QQAppKey       @"4SGmkJqTen6yQNm4"

//sina
#define SinaAppKey     @""
#define SinaAppSecret  @""








//pro
#define API                  @""
//版本
#define VERSION              @"1.0"


//用户信息
#define USER_ID              @"user_ID"        //用户ID
#define TOKEN                @"user_TOKEN"     //TOKEN
#define USER_TYPE            @"user_type"      //用户Type
#define IS_LOGIN             @"is_login"       //是否登录
#define IS_First             @"is_first"       //是否第一次启动程序

//person
#define Person_avatar        @"person_avatar"   //个人头像
#define Person_auth          @"person_auth"     //个人是否认证
#define Person_level         @"person_level"    //个人等级
#define Person_name          @"person_name"     //个人姓名
#define Person_main_biz      @"person_main_biz"     //个人主营业务

#define Person_gender         @"person_gender"     //个人性别
#define Person_telphone       @"person_telphone"   //个人联系电话
#define Person_email          @"person_email"      //个人邮箱
#define Person_corp_name      @"person_corp_name"  //个人公司名称
#define Person_title          @"person_title"      //个人现任职务
#define Person_city           @"person_city"       //个人所在城市
#define Person_main_biz       @"person_main_biz"   //个人主营业务


//company
#define Com_avatar          @"Com_avatar"          //公司头像
#define Com_auth            @"Com_auth"            //公司是否认证
#define Com_level           @"Com_level"           //公司等级
#define Com_name            @"Com_name"            //公司姓名
#define Com_main_biz        @"Com_main_biz"     //公司主营业务


#define Com_property         @"Com_property"        //公司性质
#define Com_city             @"Com_city"            //公司城市
#define Com_contact_name     @"Com_contact_name"    //公司-联系人姓名
#define Com_contact_position @"Com_contact_position"//公司-联系人职务
#define Com_contact_tel      @"Com_contact_tel"     //公司-联系人电话




//notification
#define NOLoginMyserlNoti    @"nologinmyserlnoti"//未登录->我的

#define HaveSelectNoti       @"haveSelectnoti"   //指定会员

//MJRefresh
#define mj_footTitle         @"已经全部加载完毕"


//Devices
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080,1920), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)


//nslog
#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif

//#ifdef DEBUG
//#define CITYLog(FORMAT, ...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
//#else
//#define NSLog(...)
//#endif

//umeng_ios_social_sdk_6.4.3_arm64_custom

#endif /* Define_h */
