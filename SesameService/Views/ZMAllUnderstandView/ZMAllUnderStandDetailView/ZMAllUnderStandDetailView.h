//
//  ZMAllUnderStandDetailView.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAllUnderStandDetailView : UIView

@property (nonatomic, strong) UITableView *detailTableView;

/** inputView */
@property (nonatomic, strong) UIView      *inputView;
@property (nonatomic, strong) UIView      *textView;
@property (nonatomic, strong) UIButton    *keyBoardImgBtn;
@property (nonatomic, strong) UIButton    *voiceImgBtn;
@property (nonatomic, strong) UIButton    *voiceBtn;
@property (nonatomic, strong) UIButton    *sendBtn;
@property (nonatomic, strong) UITextField *msgTextField;

/** 不可回答底Bar */
@property (nonatomic, strong) UIView      *footView;
@property (nonatomic, strong) UIButton    *confirmBtn;   //确认答案
@property (nonatomic, strong) UIButton    *loginBtn;     //跳转登录
@property (nonatomic, strong) UIView      *unAuthView;   //未认证

@property (nonatomic, strong) UIButton    *startVoiceBtn;   //开始录音
@property (nonatomic, strong) UIButton    *stopVoiceBtn;    //结束录音
@property (nonatomic, strong) UIButton    *playVoiceBtn;    //试听
@property (nonatomic, strong) UIButton    *pauseVoiceBtn;   //暂停
@property (nonatomic, strong) UIButton    *repeatVoiceBtn;  //重新录音
@property (nonatomic, strong) UIWebView   *gifWebView;      //gif
@property (nonatomic, strong) UIImageView *gifImage;        //gif
@property (nonatomic, strong) UILabel     *timeLable;       //计时













@end
