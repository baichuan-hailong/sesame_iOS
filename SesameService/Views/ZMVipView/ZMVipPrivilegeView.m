//
//  ZMVipPrivilegeView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMVipPrivilegeView.h"

@interface ZMVipPrivilegeView ()
@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UILabel          *levelLabel;
@property(nonatomic,strong)UILabel          *levelTipLabel;
@property(nonatomic,strong)UIImageView      *levelImageView;

@property(nonatomic,strong)UILabel          *rightsLabel;
@property(nonatomic,strong)UIImageView      *rightsImageView;

@property(nonatomic,strong)UILabel          *whyExperienceLabel;
@property(nonatomic,strong)UILabel          *oneLabel;
@property(nonatomic,strong)UILabel          *onelowLabel;
@property(nonatomic,strong)UILabel          *twoLabel;
@property(nonatomic,strong)UILabel          *twolowLabel;
@property(nonatomic,strong)UILabel          *threeLabel;
@property(nonatomic,strong)UILabel          *threelowLabel;

@property(nonatomic,strong)UIView           *bottomLine;


@end

@implementation ZMVipPrivilegeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    self.showsHorizontalScrollIndicator = NO;
    
    //top
    self.topView.backgroundColor = [UIColor colorWithHex:tonalColor];
    [self addSubview:self.topView];
    
    //company
    [ZMLabelAttributeMange setLabel:self.companyLabel
                               text:@"北京安家万邦传媒科技股份有限公司"
                                hex:@"FFFFFF"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.topView addSubview:self.companyLabel];
    
    //exper
    [ZMLabelAttributeMange setLabel:self.experienceLabel
                               text:@"当前经验值：800"
                                hex:tonalColor
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    self.experienceLabel.backgroundColor    = [UIColor whiteColor];
    self.experienceLabel.layer.cornerRadius = SCREEN_WIDTH/375*6;
    self.experienceLabel.layer.masksToBounds= YES;
    [self.topView addSubview:self.experienceLabel];
    
    //level
    [ZMLabelAttributeMange setLabel:self.levelLabel
                               text:@"会员等级"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    [self addSubview:self.levelLabel];
    
    [ZMLabelAttributeMange setLabel:self.levelTipLabel
                               text:@"芝麻商服会员等级按照会员经验值逐级进阶，企业会员和个人会员进阶分值规则如下："
                                hex:@"777777"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    
    [ZMLabelAttributeMange setLineSpacing:self.levelTipLabel str:@"芝麻商服会员等级按照会员经验值逐级进阶，企业会员和个人会员进阶分值规则如下："];
    
    [self addSubview:self.levelTipLabel];
    
    self.levelImageView.image = [UIImage imageNamed:@"membersLevel"];
    [self addSubview:self.levelImageView];
    
    //rights
    [ZMLabelAttributeMange setLabel:self.rightsLabel
                               text:@"会员权益"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    [self addSubview:self.rightsLabel];
    
    self.rightsImageView.image = [UIImage imageNamed:@"membersRights"];
    [self addSubview:self.rightsImageView];
    
    //why
    [ZMLabelAttributeMange setLabel:self.whyExperienceLabel
                               text:@"如何获得经验值?"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    [self addSubview:self.whyExperienceLabel];
    
    [ZMLabelAttributeMange setLabel:self.oneLabel
                               text:@"· 完善会员资料"
                                hex:@"777777"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self addSubview:self.oneLabel];
    
    [ZMLabelAttributeMange setLabel:self.onelowLabel
                               text:@"· 发表企业点评"
                                hex:@"777777"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self addSubview:self.onelowLabel];
    
    //bottom
    self.bottomLine.backgroundColor = [UIColor colorWithHex:@"CCCCCC"];
    [self addSubview:self.bottomLine];
    
    [ZMLabelAttributeMange setLabel:self.bottomLabel
                               text:@"尝试更多，经验更多！"
                                hex:@"CCCCCC"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    self.bottomLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomLabel];
}

//lazy
-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                            SCREEN_WIDTH/375*64,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*168)];
    }
    return _topView;
}

//com
-(UILabel *)companyLabel{
    if (!_companyLabel) {
        
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                SCREEN_WIDTH/375*105,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _companyLabel;
}

//exper
-(UILabel *)experienceLabel{
    if (!_experienceLabel) {
        
        _experienceLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*111)/2,
                                                                  SCREEN_WIDTH/375*130,
                                                                  SCREEN_WIDTH/375*111,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _experienceLabel;
}


//level
-(UILabel *)levelLabel{
    if (!_levelLabel) {
        
        _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                                CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*31,
                                                                SCREEN_WIDTH/375*111,
                                                                SCREEN_WIDTH/375*21)];
    }
    return _levelLabel;
}

-(UILabel *)levelTipLabel{
    if (!_levelTipLabel) {
        
        _levelTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                                CGRectGetMaxY(self.levelLabel.frame)+SCREEN_WIDTH/375*5,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*44,
                                                                SCREEN_WIDTH/375*40)];
    }
    return _levelTipLabel;
}

-(UIImageView *)levelImageView{
    if (!_levelImageView) {
        
        _levelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                CGRectGetMaxY(self.levelTipLabel.frame)+SCREEN_WIDTH/375*11,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*46,
                                                                (SCREEN_WIDTH-SCREEN_WIDTH/375*46)/704*324)];
    }
    return _levelImageView;
}

//rights
-(UILabel *)rightsLabel{
    if (!_rightsLabel) {
        
        _rightsLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                                CGRectGetMaxY(self.levelImageView.frame)+SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*21)];
    }
    return _rightsLabel;
}

-(UIImageView *)rightsImageView{
    if (!_rightsImageView) {
        
        _rightsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                        CGRectGetMaxY(self.rightsLabel.frame)+SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH-SCREEN_WIDTH/375*46,
                                                                        (SCREEN_WIDTH-SCREEN_WIDTH/375*46)/660*860)];
    }
    return _rightsImageView;
}

//why
-(UILabel *)whyExperienceLabel{
    if (!_whyExperienceLabel) {
        
        _whyExperienceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                                 CGRectGetMaxY(self.rightsImageView.frame)+SCREEN_WIDTH/375*17,
                                                                 SCREEN_WIDTH/375*150,
                                                                 SCREEN_WIDTH/375*21)];
    }
    return _whyExperienceLabel;
}

//one
-(UILabel *)oneLabel{
    if (!_oneLabel) {
        
        _oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                                 CGRectGetMaxY(self.whyExperienceLabel.frame)+SCREEN_WIDTH/375*13,
                                                                 SCREEN_WIDTH/375*110,
                                                                 SCREEN_WIDTH/375*18)];
    }
    return _oneLabel;
}

-(UILabel *)onelowLabel{
    if (!_onelowLabel) {
        
        _onelowLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                              CGRectGetMaxY(self.oneLabel.frame)+SCREEN_WIDTH/375*10,
                                                              SCREEN_WIDTH/375*110,
                                                              SCREEN_WIDTH/375*18)];
    }
    return _onelowLabel;
}


//bottom
-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*155)/2,
                                                                 CGRectGetMaxY(self.onelowLabel.frame)+SCREEN_WIDTH/375*26,
                                                                 SCREEN_WIDTH/375*155,
                                                                 SCREEN_WIDTH/375*18)];
    }
    return _bottomLabel;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                 CGRectGetMaxY(self.onelowLabel.frame)+SCREEN_WIDTH/375*35,
                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*46,
                                                                 SCREEN_WIDTH/375*1)];
    }
    return _bottomLine;
}

@end
