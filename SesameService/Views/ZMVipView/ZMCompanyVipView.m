//
//  ZMCompanyVipView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCompanyVipView.h"

@interface ZMCompanyVipView ()

@property(nonatomic,strong)UIView *memberView;
@property(nonatomic,strong)UIView *tipView;
@end

@implementation ZMCompanyVipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor= [UIColor colorWithHex:backGroundColor];
    //self.backgroundColor= [UIColor redColor];
    
    //top
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    //tip
    self.tipView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    //[self.topView addSubview:self.tipView];
    
    
    
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    self.headerImageView.layer.borderWidth = SCREEN_WIDTH/375*0.3;
    self.headerImageView.layer.borderColor = [UIColor colorWithHex:@"B2B2B2"].CGColor;
    self.headerImageView.layer.masksToBounds= YES;

    [self.topView addSubview:self.headerImageView];
    
    
    //state
    self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
    self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
    [self.topView addSubview:self.stateImageView];
    
    
    
    //company
    [ZMLabelAttributeMange setLabel:self.companyLabel
                               text:@"---"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    //self.companyLabel.numberOfLines = 0;
    //[self.companyLabel sizeToFit];
    [self.topView addSubview:self.companyLabel];

    //member
    self.memberView.backgroundColor = [UIColor colorWithHex:@"F4F1E7"];
    self.memberView.layer.cornerRadius  = SCREEN_WIDTH/375*10;
    self.memberView.layer.masksToBounds = YES;
    [self.topView addSubview:self.memberView];
    
    //jinpai
    //self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
    [self.memberView addSubview:self.memberShipImageView];
    
    [ZMLabelAttributeMange setLabel:self.memberLabel
                               text:@"---"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*11]];
    [self.memberView addSubview:self.memberLabel];
    
    //left table
    self.leftTableView.backgroundColor= [UIColor colorWithHex:backGroundColor];
    self.leftTableView.tag            = 6010;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.leftTableView];
    
    
    //self.topView.backgroundColor       = [UIColor redColor];
    
}


- (void)setTopCom:(NSDictionary *)topDic{
    
    self.leftTableView.tableHeaderView = self.topView;
    
    NSString *avatar     = [NSString stringWithFormat:@"%@",topDic[@"avatar"]];
    NSString *auth       = [NSString stringWithFormat:@"%@",topDic[@"auth"]];
    NSString *level      = [NSString stringWithFormat:@"%@",topDic[@"level"]];
    //NSString *main_biz   = [NSString stringWithFormat:@"%@",topDic[@"main_biz"]];

    if (avatar.length>10) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    if ([auth isEqualToString:@"unauthed"]) {
        self.stateImageView.alpha = 0;
    }else if ([auth isEqualToString:@"authed"]){
        self.stateImageView.alpha = 1;
    }else{
        self.stateImageView.alpha = 0;
    }
    
    
    if ([level isEqualToString:@"gold"]) {
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        self.memberLabel.text          = @"金牌会员";
    }else if ([level isEqualToString:@"silver"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
        self.memberLabel.text          = @"银牌会员";
    }else if ([level isEqualToString:@"copper"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
        self.memberLabel.text          = @"铜牌会员";
    }else{
        self.memberShipImageView.alpha = 0;
        self.memberLabel.alpha         = 0;
        self.memberView.alpha          = 0;
    }
    
    self.companyLabel.text = [NSString stringWithFormat:@"%@",topDic[@"corp_name"]];
    
    
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


- (void)setlabel:(UILabel *)label title:(NSString *)title color:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond{
    
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFond;
    label.text = title;
    
    label.layer.borderColor  = [UIColor colorWithHex:@"AAAAAA"].CGColor;
    label.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
    label.layer.cornerRadius = SCREEN_WIDTH/375*8;
}


-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*0,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*170)];
    }
    return _topView;
}


-(UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*170,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*11)];
    }
    return _tipView;
}

//header
-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*65)/2,
                                                                         SCREEN_WIDTH/375*24,
                                                                         SCREEN_WIDTH/375*65,
                                                                         SCREEN_WIDTH/375*65)];
    }
    return _headerImageView;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*209,
                                                                        SCREEN_WIDTH/375*77,
                                                                        SCREEN_WIDTH/375*16,
                                                                        SCREEN_WIDTH/375*16)];
    }
    return _stateImageView;
}

//company
-(UILabel *)companyLabel{
    if (_companyLabel==nil) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*10,
                                                                  SCREEN_WIDTH/375*99,
                                                                  SCREEN_WIDTH-SCREEN_WIDTH/375*20,
                                                                  SCREEN_WIDTH/375*21)];
    }
    return _companyLabel;
}


//member
-(UIView *)memberView{
    if (!_memberView) {
        _memberView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*84)/2,
                                                            SCREEN_WIDTH/375*132,
                                                            SCREEN_WIDTH/375*84,
                                                            SCREEN_WIDTH/375*23)];
    }
    return _memberView;
}

-(UILabel *)memberLabel{
    if (!_memberLabel) {
        _memberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*31,
                                               SCREEN_WIDTH/375*0,
                                               SCREEN_WIDTH/375*50,
                                               SCREEN_WIDTH/375*23)];
    }
    return _memberLabel;
}


-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*12.3,
                                     (SCREEN_WIDTH/375*23-SCREEN_WIDTH/375*16)/2,
                                     SCREEN_WIDTH/375*14,
                                     SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}






//left table
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64)
                                                      style:UITableViewStyleGrouped];
        _leftTableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTableView;
}
@end
