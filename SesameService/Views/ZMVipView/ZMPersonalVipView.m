//
//  ZMPersonalVipView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPersonalVipView.h"

@interface ZMPersonalVipView ()
@property(nonatomic,strong)UIView *memberView;
@end

@implementation ZMPersonalVipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor= [UIColor colorWithHex:backGroundColor];
    //top
    self.topView.backgroundColor = [UIColor whiteColor];
    //[self addSubview:self.topView];
    
    self.topLine.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
    [self.topView addSubview:self.topLine];
    
    
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
    
    //name
    [ZMLabelAttributeMange setLabel:self.nameLabel
                               text:@"--"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    [self.topView addSubview:self.nameLabel];
    
    
    
    
    //member
    self.memberView.backgroundColor = [UIColor colorWithHex:@"F4F1E7"];
    self.memberView.layer.cornerRadius  = SCREEN_WIDTH/375*10;
    self.memberView.layer.masksToBounds = YES;
    [self.topView addSubview:self.memberView];
    
    //jinpai
    self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
    [self.memberView addSubview:self.memberShipImageView];
    
    [ZMLabelAttributeMange setLabel:self.memberLabel
                               text:@"---"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*11]];
    [self.memberView addSubview:self.memberLabel];
    
    
    
    [self setButton:self.evaluationButton
              title:@"向ta打听"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14] boo:NO];
    self.evaluationButton.userInteractionEnabled = NO;
    [self.topView addSubview:self.evaluationButton];
    
    
    
    self.personalTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.personalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.personalTableView];
    
}



- (void)setTopPer:(NSDictionary *)topDic{
    
    
    NSString *detailID = [NSString stringWithFormat:@"%@",topDic[@"id"]];
    NSString *userID   = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    if ([detailID integerValue]==[userID integerValue]) {
        
        self.topView.frame = CGRectMake(0,
                                        0,
                                        SCREEN_WIDTH,
                                        SCREEN_WIDTH/375*181);
        self.evaluationButton.alpha = 0;
        self.topLine.alpha          = 0;
    }else{
        self.evaluationButton.alpha = 1;
        self.topLine.alpha          = 1;
        self.evaluationButton.userInteractionEnabled = YES;
    }
    
    
    self.personalTableView.tableHeaderView = self.topView;
    
    NSString *avatar     = [NSString stringWithFormat:@"%@",topDic[@"avatar"]];
    NSString *auth       = [NSString stringWithFormat:@"%@",topDic[@"auth"]];
    NSString *level      = [NSString stringWithFormat:@"%@",topDic[@"level"]];
    //NSString *main_biz   = [NSString stringWithFormat:@"%@",topDic[@"main_biz"]];
    
    
    if (avatar.length>10) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView .backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
        self.headerImageView .backgroundColor = [UIColor lightGrayColor];
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
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",topDic[@"person_name"]];
    
    
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


//lazy
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*220)];
    }
    return _topView;
}

-(UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*175,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*0.5)];
    }
    return _topLine;
}

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

//name
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                               SCREEN_WIDTH/375*99,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*21)];
    }
    return _nameLabel;
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



-(UIButton *)evaluationButton{
    if (!_evaluationButton) {
        _evaluationButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*60)/2,
                                               SCREEN_WIDTH/375*186,
                                               SCREEN_WIDTH/375*60,
                                               SCREEN_WIDTH/375*20)];
    }
    return _evaluationButton;
}

-(UITableView *)personalTableView{
    if (!_personalTableView) {
        _personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                           64,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT-SCREEN_WIDTH/375*64) style:UITableViewStyleGrouped];
        _personalTableView.showsVerticalScrollIndicator = NO;
    }
    return _personalTableView;
}

@end
