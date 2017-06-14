//
//  ZMVipView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMVipView.h"

@interface ZMVipView ()
@property(nonatomic,strong)UIView *line;
@end

@implementation ZMVipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    //left
    [self setButton:self.lefrButton
              title:@"企业会员"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self addSubview:self.lefrButton];
    
    //right
    [self setButton:self.rightButton
              title:@"个人会员"
              color:[UIColor colorWithHex:@"999999"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self addSubview:self.rightButton];
    
    //tip line
    self.tipLine.backgroundColor = [UIColor colorWithHex:tonalColor];
    [self addSubview:self.tipLine];
    
    self.line.backgroundColor = [UIColor colorWithHex:@"DFDFDF"];
    [self addSubview:self.line];
    

    
    //scroll
    self.bottomScrollView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    [self addSubview:self.bottomScrollView];
    
    //left table
    self.leftTableView.backgroundColor= [UIColor colorWithHex:backGroundColor];
    self.leftTableView.tag            = 1010;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomScrollView addSubview:self.leftTableView];
    
    //right table
    self.rightTableView.backgroundColor= [UIColor colorWithHex:backGroundColor];
    self.rightTableView.tag             = 1011;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomScrollView addSubview:self.rightTableView];
    
    
    
    self.pickView.backgroundColor = [UIColor whiteColor];
    //UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    self.pickBackView.backgroundColor = [UIColor colorWithHex:@"000000"];
    self.pickBackView.alpha = 0.2;
    [self addSubview:self.pickBackView];
    [self addSubview:self.pickView];
    
    self.pickView.alpha = 0;
    self.pickBackView.alpha = 0;
}

- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font    = textFond;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*5;
    }
}


//left
-(UIButton *)lefrButton{
    if (!_lefrButton) {
        _lefrButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                 64,
                                                                 SCREEN_WIDTH/2,
                                                                 SCREEN_WIDTH/375*37)];
    }
    return _lefrButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,
                                                                  64,
                                                                  SCREEN_WIDTH/2,
                                                                  SCREEN_WIDTH/375*37)];
    }
    return _rightButton;
}

-(UIView *)tipLine{
    if (!_tipLine) {
        _tipLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3)];
    }
    return _tipLine;
}

//scroll
-(UIScrollView *)bottomScrollView{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           CGRectGetMaxY(self.tipLine.frame),
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame))];
        _bottomScrollView.pagingEnabled   = YES;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.bounces = NO;
        _bottomScrollView.contentSize     = CGSizeMake(SCREEN_WIDTH*2,
                                                       SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame));
    }
    return _bottomScrollView;
}

//left table
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame))];
    }
    return _leftTableView;
}
//right table
-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,
                                                                        0,
                                                                        SCREEN_WIDTH,
                                                                        SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame))];
        
    }
    return _rightTableView;
}

//pick
-(UIView *)pickBackView{
    if (!_pickBackView) {
        _pickBackView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
    }
    return _pickBackView;
}

-(UIPickerView *)pickView{
    if (_pickView==nil) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH/375*100)/2, SCREEN_WIDTH, SCREEN_WIDTH/375*100)];
    }
    return _pickView;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         CGRectGetMaxY(self.lefrButton.frame)+SCREEN_WIDTH/375*2.7,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.3)];
    }
    return _line;
}


@end
