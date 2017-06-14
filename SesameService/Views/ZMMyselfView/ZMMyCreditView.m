//
//  ZMMyCreditView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditView.h"

@interface ZMMyCreditView ()

@property(nonatomic,strong)UIImageView *scoreImgaeView;

@property(nonatomic,strong)UIView      *bottomSelectView;

@end

@implementation ZMMyCreditView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //top
    self.backgroundColor         = [UIColor whiteColor];
    self.topView.backgroundColor = [UIColor colorWithHex:tonalColor];
    //self.topView.backgroundColor = [UIColor lightGrayColor];
    //[self addSubview:self.topView];
    
    //scoretachometer
    self.scoreImgaeView.image = [UIImage imageNamed:@"scoretachometer1"];
    //self.scoreImgaeView.backgroundColor = [UIColor blackColor];
    [self.topView addSubview:self.scoreImgaeView];
    
    //223x143   111.5
    //self.tipView.backgroundColor = [UIColor yellowColor];
    [self.scoreImgaeView addSubview:self.tipView];
    
    
    //point
    self.creditPointImgaeView.image = [UIImage imageNamed:@"jinduWhitePoint"];
    //self.creditPointImgaeView.backgroundColor = [UIColor redColor];
    [self.tipView addSubview:self.creditPointImgaeView];
    
    
    
    
    [self setButton:self.understandButton
              title:@"了解信用分"
              color:[UIColor whiteColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:YES];
    [self.understandButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.topView addSubview:self.understandButton];
    
    
    [ZMLabelAttributeMange setLabel:self.scoreLabel
                               text:@"99.9"
                                hex:@"FFFFFF"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*36]];
    [self.topView addSubview:self.scoreLabel];
    
    [ZMLabelAttributeMange setLabel:self.levelLabel
                               text:@"信用良好"
                                hex:@"FFFFFF"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self.topView addSubview:self.levelLabel];
    
    [ZMLabelAttributeMange setLabel:self.timeLabel
                               text:@"评估于2016.12.01"
                                hex:@"FFFFFF"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
    [self.topView addSubview:self.timeLabel];
    
    
    
    
    self.bottomSelectView.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:self.bottomSelectView];
    
    //left
    [self setButton:self.lefrButton
              title:@"信用权益"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self.bottomSelectView addSubview:self.lefrButton];
    
    //right
    [self setButton:self.rightButton
              title:@"提升信用"
              color:[UIColor colorWithHex:@"999999"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self.bottomSelectView addSubview:self.rightButton];
    
    
    
    //tip line
    self.tipLine.backgroundColor = [UIColor colorWithHex:tonalColor];
    [self.bottomSelectView addSubview:self.tipLine];
    
    //scroll
    self.bottomScrollView.backgroundColor = [UIColor yellowColor];
    //[self addSubview:self.bottomScrollView];
    
    //left table
    self.leftTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.leftTableView.tag = 1030;
    self.leftTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.leftTableView];
    
    self.leftTableView.tableHeaderView = self.topView;
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

//lazy
-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*64,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*255+SCREEN_WIDTH/375*40)];
    }
    return _topView;
}

-(UIView *)bottomSelectView{
    if (_bottomSelectView==nil) {
        _bottomSelectView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*255,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*40)];
    }
    return _bottomSelectView;
}

-(UIImageView *)scoreImgaeView{
    if (!_scoreImgaeView) {
        _scoreImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*223)/2,
                                                                        SCREEN_WIDTH/375*40,
                                                                        SCREEN_WIDTH/375*223,
                                                                        SCREEN_WIDTH/375*143)];
    }
    return _scoreImgaeView;
}

-(UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*111,
                                                            SCREEN_WIDTH/375*223,
                                                            SCREEN_WIDTH/375*1)];
    }
    return _tipView;
}

-(UIImageView *)creditPointImgaeView{
    if (!_creditPointImgaeView) {
        _creditPointImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH/375*2.35,
                                                                              -SCREEN_WIDTH/375*2.5,
                                                                              SCREEN_WIDTH/375*6,
                                                                              SCREEN_WIDTH/375*6)];
    }
    return _creditPointImgaeView;
}


//score level time
-(UILabel *)scoreLabel{
    if (_scoreLabel==nil) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*100)/2,
                                                                SCREEN_WIDTH/375*85,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*50)];
    }
    return _scoreLabel;
}

-(UILabel *)levelLabel{
    if (_levelLabel==nil) {
        _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*100)/2,
                                                                SCREEN_WIDTH/375*127,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _levelLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*100)/2,
                                                               SCREEN_WIDTH/375*157,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*14)];
    }
    return _timeLabel;
}


-(UIButton *)understandButton{
    if (!_understandButton) {
        _understandButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*105)/2, CGRectGetMaxY(self.scoreImgaeView.frame)+SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*105, SCREEN_WIDTH/375*30)];
    }
    return _understandButton;
}

//left
-(UIButton *)lefrButton{
    if (!_lefrButton) {
        _lefrButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                 SCREEN_WIDTH/375*0,
                                                                 SCREEN_WIDTH/2,
                                                                 SCREEN_WIDTH/375*37)];
    }
    return _lefrButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,
                                                                  SCREEN_WIDTH/375*0,
                                                                  SCREEN_WIDTH/2,
                                                                  SCREEN_WIDTH/375*37)];
    }
    return _rightButton;
}

-(UIView *)tipLine{
    if (!_tipLine) {
        _tipLine = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-SCREEN_WIDTH/375*100)/2,
                                                            CGRectGetMaxY(self.lefrButton.frame),
                                                            SCREEN_WIDTH/375*100,
                                                            SCREEN_WIDTH/375*3)];
    }
    return _tipLine;
}

//scroll
-(UIScrollView *)bottomScrollView{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLine.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame))];
        _bottomScrollView.pagingEnabled   = YES;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.bounces = NO;
        _bottomScrollView.contentSize     = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame));
    }
    return _bottomScrollView;
}

//left table
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        //_leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.tipLine.frame))];
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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




@end
