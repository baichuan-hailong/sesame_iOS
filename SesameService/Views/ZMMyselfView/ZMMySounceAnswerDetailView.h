//
//  ZMMySounceAnswerDetailView.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/9.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMySounceAnswerDetailView : UIView

@property(nonatomic,strong)UITableView      *sounceDetailableView;

/** inputView */
@property (nonatomic, strong) UIView      *inputView;
@property (nonatomic, strong) UIView      *textView;
@property (nonatomic, strong) UIButton    *keyBoardImgBtn;
@property (nonatomic, strong) UIButton    *voiceImgBtn;
@property (nonatomic, strong) UIButton    *voiceBtn;
@property (nonatomic, strong) UIButton    *sendBtn;
@property (nonatomic, strong) UITextField *msgTextField;

@property (nonatomic, strong) UIButton    *startVoiceBtn;   //开始录音
@property (nonatomic, strong) UIButton    *stopVoiceBtn;    //结束录音
@property (nonatomic, strong) UIButton    *playVoiceBtn;    //试听
@property (nonatomic, strong) UIButton    *pauseVoiceBtn;   //暂停
@property (nonatomic, strong) UIButton    *repeatVoiceBtn;  //重新录音
@property (nonatomic, strong) UIImageView *gifImage;        //gif
@property (nonatomic, strong) UILabel     *timeLable;       //计时
@end
