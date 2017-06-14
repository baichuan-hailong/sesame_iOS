//
//  ZMFeedBackSignView.m
//  SesameService
//
//  Created by 杜海龙 on 17/6/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMFeedBackSignView.h"

@interface ZMFeedBackSignView ()
@property (nonatomic , strong)UIView      *heaView;
@property (nonatomic , strong)UIImageView *heaImageView;
@property (nonatomic , strong)UILabel     *heaTipLabel;


@property (nonatomic , strong)UIView      *fooView;
@property (nonatomic , strong)UILabel     *fooTipLabel;
@property (nonatomic , strong)UILabel     *fooBottomTipLabel;
@end


@implementation ZMFeedBackSignView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.feedBackTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.feedBackTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.feedBackTableView];
    
    
    /******header******/
    self.feedBackHeaderView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.heaView.backgroundColor = [UIColor whiteColor];
    [self.feedBackHeaderView addSubview:self.heaView];
    
    //feedBackSignResultSuccessful
    self.heaImageView.image = [UIImage imageNamed:@"feedBackSignResultSuccessful"];
    [self.heaView addSubview:self.heaImageView];
    
    [ZMLabelAttributeMange setLabel:self.heaTipLabel
                               text:@"您已反馈项目双方签约结果"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [self.heaView addSubview:self.heaTipLabel];
    
    
    /******footer******/
    self.feedBackFooterView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.fooView.backgroundColor            = [UIColor whiteColor];
    [self.feedBackFooterView addSubview:self.fooView];
    
    [ZMLabelAttributeMange setLabel:self.fooTipLabel
                               text:@"请填写项目签约时间："
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.fooView addSubview:self.fooTipLabel];
    
    
    [self text:self.feedBackTimeTextField];
    [self.fooView addSubview:self.feedBackTimeTextField];
    
    [self setButton:self.feedBackCommit title:@"提交"
              color:[UIColor whiteColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    self.feedBackCommit.backgroundColor = [UIColor colorWithHex:tonalColor];
    [self.fooView addSubview:self.feedBackCommit];
    
    [ZMLabelAttributeMange setLabel:self.fooBottomTipLabel
                               text:@"* 备注：该信息提交后不可更改。\n在您提交了项目签约时间后，平台将督促接单方向您支付约定的推介费，请您务必如实填写，以免带来不必要的纠纷。"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    self.fooBottomTipLabel.numberOfLines = 0;
    [ZMLabelAttributeMange setLineSpacing:self.fooBottomTipLabel str:self.fooBottomTipLabel.text];
    [ZMLabelAttributeMange attributeLabel:self.fooBottomTipLabel range:NSMakeRange(0, 1)];
    [self.fooView addSubview:self.fooBottomTipLabel];
    
    
    
    
    /***********time pick************/
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    
    [self.topView addSubview:self.cancleBtn];
    [self.topView addSubview:self.sureBtn];
    
    self.cancleBtn.backgroundColor= [UIColor whiteColor];
    self.sureBtn.backgroundColor  = [UIColor whiteColor];
    
    self.myDatePicker.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:self.myDatePicker];
    
    
    [self setButton:self.cancleBtn
              title:@"取消"
              color:[UIColor blueColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self setButton:self.sureBtn
              title:@"确定"
              color:[UIColor blueColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
}


- (void)text:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor     = [UIColor colorWithHex:@"666666"];
    textField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    textField.layer.borderColor = [UIColor colorWithHex:@"BCBCBC"].CGColor;
    textField.layer.borderWidth = SCREEN_WIDTH/375*1;
    textField.layer.cornerRadius= SCREEN_WIDTH/375*4;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/375*13, SCREEN_WIDTH/375*40)];
    textField.leftView.backgroundColor = [UIColor clearColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    button.layer.cornerRadius = SCREEN_WIDTH/375*4;
}





//lazy
-(UITableView *)feedBackTableView{
    if (_feedBackTableView==nil) {
        _feedBackTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                       64,
                                                       SCREEN_WIDTH,
                                                       SCREEN_HEIGHT-64)];
    }
    return _feedBackTableView;
}


/******header******/
-(UIView *)feedBackHeaderView{
    if (_feedBackHeaderView==nil) {
        _feedBackHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                 SCREEN_WIDTH/375*0,
                                                 SCREEN_WIDTH,
                                                 SCREEN_WIDTH/375*168)];
    }
    return _feedBackHeaderView;
}

-(UIView *)heaView{
    if (_heaView==nil) {
        _heaView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                       SCREEN_WIDTH/375*0,
                                       SCREEN_WIDTH,
                                       SCREEN_WIDTH/375*154)];
    }
    return _heaView;
}


-(UIImageView *)heaImageView{
    if (_heaImageView==nil) {
        _heaImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*44)/2,
                                                    SCREEN_WIDTH/375*30,
                                                    SCREEN_WIDTH/375*44,
                                                    SCREEN_WIDTH/375*48)];
    }
    return _heaImageView;
}


-(UILabel *)heaTipLabel{
    if (_heaTipLabel==nil) {
        _heaTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                              SCREEN_WIDTH/375*88,
                              SCREEN_WIDTH,
                              SCREEN_WIDTH/375*22)];
    }
    return _heaTipLabel;
}


/******footer******/
-(UIView *)feedBackFooterView{
    if (_feedBackFooterView==nil) {
        _feedBackFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                       SCREEN_WIDTH/375*0,
                                                       SCREEN_WIDTH,
                                                       SCREEN_HEIGHT)];
    }
    return _feedBackFooterView;
}

-(UIView *)fooView{
    if (_fooView==nil) {
        _fooView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                               SCREEN_WIDTH/375*0,
                                               SCREEN_WIDTH,
                                               SCREEN_HEIGHT)];
    }
    return _fooView;
}

-(UILabel *)fooTipLabel{
    if (_fooTipLabel==nil) {
        _fooTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                 SCREEN_WIDTH/375*22,
                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _fooTipLabel;
}


-(UITextField *)feedBackTimeTextField{
    if (_feedBackTimeTextField==nil) {
        _feedBackTimeTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                         SCREEN_WIDTH/375*49,
                                                         SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                         SCREEN_WIDTH/375*40)];
    }
    return _feedBackTimeTextField;
}


-(UIButton *)feedBackCommit{
    if (_feedBackCommit == nil) {
        _feedBackCommit = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                            SCREEN_WIDTH/375*109,
                                            SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                            SCREEN_WIDTH/375*40)];
    }
    return _feedBackCommit;
}


-(UILabel *)fooBottomTipLabel{
    if (_fooBottomTipLabel==nil) {
        _fooBottomTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                 SCREEN_WIDTH/375*157,
                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                 SCREEN_WIDTH/375*60)];
    }
    return _fooBottomTipLabel;
}



/******time pick****/
-(UIDatePicker *)myDatePicker{
    if (_myDatePicker==nil) {
        _myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,
                                                                       SCREEN_WIDTH/375*25,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_WIDTH/375*200)];
        
        _myDatePicker.maximumDate= [NSDate date];//today
    }
    return _myDatePicker;
}


-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_HEIGHT,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25)];
    }
    return _topView;
}

-(UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                SCREEN_WIDTH/375*80,
                                                                SCREEN_WIDTH/375*25)];
    }
    return _cancleBtn;
}

-(UIButton *)sureBtn{
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*80,
                                                              0,
                                                              SCREEN_WIDTH/375*80,
                                                              SCREEN_WIDTH/375*25)];
    }
    return _sureBtn;
}


@end
