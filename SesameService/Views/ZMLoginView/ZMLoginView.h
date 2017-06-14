//
//  ZMLoginView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMLoginView : UIView
@property(nonatomic,strong)UIImageView *logoImageView;
//tel
@property(nonatomic,strong)UITextField *telTextField;
//sms
@property(nonatomic,strong)UITextField *coderTextField;
//request
@property(nonatomic,strong)UIButton    *requestButton;
//login
@property(nonatomic,strong)UIButton    *loginButton;
//server
@property(nonatomic,strong)UIButton    *serverButton;


@property (nonatomic , strong) UIView *thirdLine;
@property (nonatomic , strong) UILabel *thirdLabel;

//wechat
@property(nonatomic,strong)UIButton    *wechatButton;
@property (nonatomic,strong)UILabel    *wechatLabel;
//qq
@property(nonatomic,strong)UIButton    *QQButton;
@property (nonatomic,strong)UILabel    *qqLabel;
//webo
@property (nonatomic,strong)UIButton *weboButton;
@property (nonatomic,strong)UILabel  *weiboLabel;




@end
