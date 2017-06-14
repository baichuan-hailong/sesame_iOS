//
//  ZMAllUnderStandDetailView.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderStandDetailView.h"

@implementation ZMAllUnderStandDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.detailTableView];
    
    [self addSubview:self.footView];
    [self.footView addSubview:self.confirmBtn];
    [self.footView addSubview:self.loginBtn];
    [self.footView addSubview:self.unAuthView];
    
    [self addSubview:self.inputView];
    [self.inputView addSubview:self.textView];
    
    
    [self.textView addSubview:self.voiceImgBtn];
    [self.textView addSubview:self.keyBoardImgBtn];
    [self.textView addSubview:self.msgTextField];
    [self.textView addSubview:self.voiceBtn];
    [self.textView addSubview:self.sendBtn];
    
    [self.inputView addSubview:self.startVoiceBtn];
    [self.inputView addSubview:self.stopVoiceBtn];
    [self.inputView addSubview:self.playVoiceBtn];
    [self.inputView addSubview:self.pauseVoiceBtn];
    [self.inputView addSubview:self.repeatVoiceBtn];
    //[self.inputView addSubview:self.gifWebView];
    [self.inputView addSubview:self.gifImage];
    [self.inputView addSubview:self.timeLable];
}



#pragma maek - getter
- (UITableView *)detailTableView {

    if (_detailTableView == nil) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                         64,
                                                                         SCREEN_WIDTH,
                                                                         SCREEN_HEIGHT - 64)
                                                        style:UITableViewStylePlain];
        _detailTableView.backgroundColor = [UIColor colorWithHex:backColor];
        //_detailTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _detailTableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
        _detailTableView.showsVerticalScrollIndicator = NO;
        _detailTableView.separatorColor = [UIColor colorWithHex:@"ededed"];
        
    }
    return _detailTableView;
}


/** inputView */
- (UIView *)inputView {

    if (_inputView == nil) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              SCREEN_HEIGHT - SCREEN_HEIGHT/13.34,
                                                              SCREEN_WIDTH,
                                                              SCREEN_WIDTH/1.36)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.alpha = 0;
    }
    return _inputView;
}






/** textView */
- (UIView *)textView {
    
    if (_textView == nil) {
        _textView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             SCREEN_WIDTH,
                                                             SCREEN_HEIGHT/13.34)];
        _textView.backgroundColor = [UIColor whiteColor];
        
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line1.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/13.34, SCREEN_WIDTH, 0.5)];
        line2.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        [_textView addSubview:line1];
        [_textView addSubview:line2];
        
    }
    return _textView;
}

- (UITextField *)msgTextField {

    if (_msgTextField == nil) {
        _msgTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8.93,
                                                                     (self.textView.height - SCREEN_WIDTH/10.42)/2,
                                                                      SCREEN_WIDTH/1.47,
                                                                      SCREEN_WIDTH/10.42)];
        _msgTextField.backgroundColor = [UIColor colorWithHex:@"ffffff"];
        _msgTextField.layer.cornerRadius = 4;
        _msgTextField.layer.borderWidth = 0.5;
        _msgTextField.layer.borderColor = [[UIColor colorWithHex:@"cccccc"] CGColor];
        _msgTextField.returnKeyType = UIReturnKeySend;
        
        //给_msgContentTextField建立一个左边的视图,让初始光标右移动5个像素
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)];
        _msgTextField.leftView = paddingView;
        _msgTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _msgTextField;
}


- (UIButton *)voiceImgBtn {

    if (_voiceImgBtn == nil) {
        _voiceImgBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/8.93 - SCREEN_WIDTH/13.39)/2,
                                                                  (self.textView.height - SCREEN_WIDTH/13.39)/2,
                                                                   SCREEN_WIDTH/13.39,
                                                                   SCREEN_WIDTH/13.39)];
        [_voiceImgBtn setBackgroundImage:[UIImage imageNamed:@"au_getVoice"] forState:UIControlStateNormal];
        _voiceImgBtn.alpha = 0;
    }
    return _voiceImgBtn;
}

- (UIButton *)keyBoardImgBtn {
    
    if (_keyBoardImgBtn == nil) {
        _keyBoardImgBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/8.93 - SCREEN_WIDTH/13.39)/2,
                                                                     (self.textView.height - SCREEN_WIDTH/13.39)/2,
                                                                      SCREEN_WIDTH/13.39,
                                                                      SCREEN_WIDTH/13.39)];
        [_keyBoardImgBtn setBackgroundImage:[UIImage imageNamed:@"au_keyboard"] forState:UIControlStateNormal];
    }
    return _keyBoardImgBtn;
}

- (UIButton *)voiceBtn {
    
    if (_voiceBtn == nil) {
        _voiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8.93,
                                                              (self.textView.height - SCREEN_WIDTH/10.42)/2,
                                                               SCREEN_WIDTH/1.47,
                                                               SCREEN_WIDTH/10.42)];
        [_voiceBtn setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:_voiceBtn.size] forState:UIControlStateNormal];
        [_voiceBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_voiceBtn.size] forState:UIControlStateHighlighted];
        _voiceBtn.layer.cornerRadius = 4;
        _voiceBtn.layer.borderWidth = 0.5;
        _voiceBtn.layer.borderColor = [[UIColor colorWithHex:@"979797"] CGColor];
        
        _voiceBtn.layer.masksToBounds = YES;
        [_voiceBtn setTitle:@"回答" forState:UIControlStateNormal];
        [_voiceBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_voiceBtn setTitleColor:[UIColor colorWithHex:@"666666"] forState:UIControlStateNormal];
    }
    return _voiceBtn;
}

- (UIButton *)sendBtn {
    
    if (_sendBtn == nil) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/6.25 - SCREEN_WIDTH/37.5,
                                                             (self.textView.height - SCREEN_WIDTH/10.42)/2,
                                                              SCREEN_WIDTH/6.25,
                                                              SCREEN_WIDTH/10.42)];
        [_sendBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_sendBtn.size] forState:UIControlStateNormal];
        
        _sendBtn.layer.cornerRadius = 4;
        _sendBtn.layer.masksToBounds = YES;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sendBtn;
}


/** 录音按钮 */
- (UIButton *)startVoiceBtn {

    if (_startVoiceBtn == nil) {
        UIImage *img = [UIImage imageNamed:@"au_点击说话"];
        _startVoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - img.size.width)/2,
                                                                     self.textView.bottom + SCREEN_WIDTH/5.95,
                                                                     img.size.width,
                                                                     img.size.height)];
        [_startVoiceBtn setBackgroundImage:img forState:UIControlStateNormal];
        
        
        UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       -SCREEN_WIDTH/23.43 - SCREEN_WIDTH/31.25,
                                                                       _startVoiceBtn.width,
                                                                       SCREEN_WIDTH/23.43)];
        tipsLable.textColor = [UIColor colorWithHex:@"888888"];
        tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43];
        tipsLable.textAlignment = NSTextAlignmentCenter;
        tipsLable.text = @"点击说话";
        [_startVoiceBtn addSubview:tipsLable];
    }
    return _startVoiceBtn;
}

- (UIButton *)stopVoiceBtn {
    
    if (_stopVoiceBtn == nil) {
        UIImage *img = [UIImage imageNamed:@"au_结束录制"];
        _stopVoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - img.size.width)/2,
                                                                    self.textView.bottom + SCREEN_WIDTH/5.95,
                                                                    img.size.width,
                                                                    img.size.height)];
        [_stopVoiceBtn setBackgroundImage:img forState:UIControlStateNormal];
        _stopVoiceBtn.alpha = 0;
    }
    return _stopVoiceBtn;
}

- (UIButton *)playVoiceBtn {
    
    if (_playVoiceBtn == nil) {
        
        UIImage *img = [UIImage imageNamed:@"au_点击试听"];
        _playVoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - img.size.width - SCREEN_WIDTH/13.89,
                                                                   self.textView.bottom + SCREEN_WIDTH/5.95,
                                                                   img.size.width,
                                                                   img.size.height)];
        [_playVoiceBtn setBackgroundImage:img forState:UIControlStateNormal];
        _playVoiceBtn.alpha = 0;
        
        UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       _playVoiceBtn.height + SCREEN_WIDTH/31.25,
                                                                       _playVoiceBtn.width,
                                                                       SCREEN_WIDTH/31.25)];
        tipsLable.textColor = [UIColor colorWithHex:@"aaaaaa"];
        tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tipsLable.textAlignment = NSTextAlignmentCenter;
        tipsLable.text = @"点击试听";
        [_playVoiceBtn addSubview:tipsLable];
    }
    return _playVoiceBtn;
}

- (UIButton *)pauseVoiceBtn {
    
    if (_pauseVoiceBtn == nil) {
        UIImage *img = [UIImage imageNamed:@"au_暂停播放"];
        _pauseVoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - img.size.width - SCREEN_WIDTH/13.89,
                                                                    self.textView.bottom + SCREEN_WIDTH/5.95,
                                                                    img.size.width,
                                                                    img.size.height)];
        [_pauseVoiceBtn setBackgroundImage:img forState:UIControlStateNormal];
        _pauseVoiceBtn.alpha = 0;
        
        UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       _pauseVoiceBtn.height + SCREEN_WIDTH/31.25,
                                                                       _pauseVoiceBtn.width,
                                                                       SCREEN_WIDTH/31.25)];
        tipsLable.textColor = [UIColor colorWithHex:@"aaaaaa"];
        tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tipsLable.textAlignment = NSTextAlignmentCenter;
        tipsLable.text = @"正在播放";
        [_pauseVoiceBtn addSubview:tipsLable];
    }
    return _pauseVoiceBtn;
}

- (UIButton *)repeatVoiceBtn {
    
    if (_repeatVoiceBtn == nil) {
        
        UIImage *img = [UIImage imageNamed:@"au_重新录制"];
        _repeatVoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + SCREEN_WIDTH/13.89,
                                                                     self.textView.bottom + SCREEN_WIDTH/5.95,
                                                                     img.size.width,
                                                                     img.size.height)];
        [_repeatVoiceBtn setBackgroundImage:img forState:UIControlStateNormal];
        _repeatVoiceBtn.alpha = 0;
        
        UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       _repeatVoiceBtn.height + SCREEN_WIDTH/31.25,
                                                                       _repeatVoiceBtn.width,
                                                                       SCREEN_WIDTH/31.25)];
        tipsLable.textColor = [UIColor colorWithHex:@"aaaaaa"];
        tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tipsLable.textAlignment = NSTextAlignmentCenter;
        tipsLable.text = @"重新录制";
        [_repeatVoiceBtn addSubview:tipsLable];
    }
    return _repeatVoiceBtn;
}

- (UIWebView *)gifWebView {

    if (_gifWebView == nil) {

        // 设定位置和大小
        CGRect frame = CGRectMake((SCREEN_WIDTH - 150)/2,
                                  self.startVoiceBtn.top - 10 - SCREEN_WIDTH/20.83,
                                  150,
                                  10);
        frame.size = [UIImage imageNamed:@"yuyin.gif"].size;
        // 读取gif图片数据
        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"yuyin" ofType:@"gif"]];

        _gifWebView = [[UIWebView alloc] initWithFrame:frame];
        _gifWebView.userInteractionEnabled = NO;//用户不可交互
        _gifWebView.scalesPageToFit = YES;
        [_gifWebView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        _gifWebView.alpha = 0;
    }
    return _gifWebView;
}

- (UIImageView *)gifImage {

    if (_gifImage == nil) {
        _gifImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2,
                                                                  self.startVoiceBtn.top - 10 - SCREEN_WIDTH/20.83,
                                                                  150,
                                                                  10)];
        NSURL * url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"yuyin2.gif" ofType:nil]];
        [_gifImage yh_setImage:url];
        _gifImage.alpha = 0;
    }
    return _gifImage;
}

- (UILabel *)timeLable {

    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.width   = SCREEN_WIDTH/8;
        _timeLable.height  = SCREEN_WIDTH/26.78;
        _timeLable.centerX = SCREEN_WIDTH/2;
        _timeLable.centerY = self.gifImage.centerY;
        _timeLable.alpha = 0;
        _timeLable.text = @"00:00";

        _timeLable.textColor = [UIColor colorWithHex:@"888888"];
        _timeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _timeLable.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLable;
}






/** footView */
- (UIView *)footView {

    if (_footView == nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             SCREEN_HEIGHT - SCREEN_WIDTH/6.25,
                                                             SCREEN_WIDTH,
                                                             SCREEN_WIDTH/6.25)];
        _footView.backgroundColor = [UIColor whiteColor];
        [_footView.layer setShadowOffset:CGSizeMake(3, 3)];
        [_footView.layer setShadowRadius:3];
        [_footView.layer setShadowOpacity:0.6];
        [_footView.layer setShadowColor:[UIColor grayColor].CGColor];
        _footView.alpha = 0;
    }
    return _footView;
}


/** 确认答案 */
- (UIButton *)confirmBtn {
    
    if (_confirmBtn == nil) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                (self.footView.height - SCREEN_WIDTH/9.375)/2,
                                                                 SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                 SCREEN_WIDTH/9.375)];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_confirmBtn setTitle:@"确认答案" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 4;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_confirmBtn.frame.size] forState:UIControlStateNormal];
        _confirmBtn.alpha = 0;
    }
    return _confirmBtn;
}

/** 跳转登录 */
- (UIButton *)loginBtn {
    
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                              (self.footView.height - SCREEN_WIDTH/9.375)/2,
                                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                              SCREEN_WIDTH/9.375)];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_loginBtn setTitle:@"回答" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 4;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_loginBtn.frame.size] forState:UIControlStateNormal];
        _loginBtn.alpha = 0;
    }
    return _loginBtn;
}

- (UIView *)unAuthView {

    if (_unAuthView == nil) {
        _unAuthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.footView.height)];
        _unAuthView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                            (self.footView.height - SCREEN_WIDTH/8.33)/2,
                                                                            SCREEN_WIDTH/8.33,
                                                                            SCREEN_WIDTH/8.33)];
        avatar.image = [UIImage imageNamed:@"placeHeaderGrayImage"];
        avatar.layer.masksToBounds = YES;
        avatar.layer.cornerRadius = (SCREEN_WIDTH/8.33)/2;
        
        UIImageView *tipsImage = [[UIImageView alloc] initWithFrame:CGRectMake(avatar.right + SCREEN_WIDTH/18.75,
                                                                               avatar.centerY - SCREEN_WIDTH/22.05,
                                                                               SCREEN_WIDTH/2.6,
                                                                              (SCREEN_WIDTH/2.6)/7.7)];
        tipsImage.image = [UIImage imageNamed:@"au_unAuth"];

        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + SCREEN_WIDTH/18.75,
                                                                   avatar.centerY - SCREEN_WIDTH/22.05,
                                                                   SCREEN_WIDTH/2.6,
                                                                   SCREEN_WIDTH/22.05)];
        tips1.text = @"仅个人会员可回答问题";
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/37.5];
        tips1.textColor = [UIColor whiteColor];
        tips1.backgroundColor = [UIColor lightGrayColor];
        tips1.textAlignment = NSTextAlignmentCenter;
        tips1.layer.cornerRadius = 3;
        tips1.layer.masksToBounds = YES;
        
        
        UILabel *tips2 = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + SCREEN_WIDTH/18.75,
                                                                   tips1.bottom + 5,
                                                                   SCREEN_WIDTH/2.6,
                                                                   SCREEN_WIDTH/31.25)];
        tips2.text = @"回答被选中者可获得赏金";
        tips2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tips2.textColor = [UIColor colorWithHex:@"333333"];
        tips2.textAlignment = NSTextAlignmentCenter;
        
        UIButton *answerBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/3.75 - SCREEN_WIDTH/25,
                                                                        (self.footView.height - SCREEN_WIDTH/9.375)/2,
                                                                         SCREEN_WIDTH/3.75,
                                                                         SCREEN_WIDTH/9.375)];
        [answerBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [answerBtn setTitle:@"回答" forState:UIControlStateNormal];
        [answerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        answerBtn.layer.cornerRadius = 4;
        answerBtn.layer.masksToBounds = YES;
        answerBtn.backgroundColor = [UIColor colorWithHex:@"aaaaaa"];
        
        
        [_unAuthView addSubview:avatar];
        [_unAuthView addSubview:tipsImage];
        [_unAuthView addSubview:tips2];
        [_unAuthView addSubview:answerBtn];

        _unAuthView.alpha = 0;
    }
    return _unAuthView;
}


@end
