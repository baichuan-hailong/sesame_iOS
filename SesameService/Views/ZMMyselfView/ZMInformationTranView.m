//
//  ZMInformationTranView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInformationTranView.h"

@interface ZMInformationTranView ()
@property(nonatomic,strong)UIView *line;
@end


@implementation ZMInformationTranView

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
              title:@"我卖的"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self addSubview:self.lefrButton];
    
    //right
    [self setButton:self.rightButton
              title:@"我买的"
              color:[UIColor colorWithHex:@"999999"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    //self.rightButton.backgroundColor = [UIColor redColor];
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
    self.leftTableView.tag            = 1026;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomScrollView addSubview:self.leftTableView];
    
    //right table
    self.rightTableView.backgroundColor= [UIColor colorWithHex:backGroundColor];
    self.rightTableView.tag             = 1027;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomScrollView addSubview:self.rightTableView];
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
        _tipLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            CGRectGetMaxY(self.lefrButton.frame),
                                                            SCREEN_WIDTH/2,
                                                            SCREEN_WIDTH/375*3)];
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

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         CGRectGetMaxY(self.lefrButton.frame)+SCREEN_WIDTH/375*2.7,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.3)];
        
        
        if (iPhone5) {
            _line.frame = CGRectMake(0,
                                     CGRectGetMaxY(self.lefrButton.frame)+SCREEN_WIDTH/375*2.5,
                                     SCREEN_WIDTH,
                                     SCREEN_WIDTH/375*0.3);
        }
    }
    return _line;
}

@end
