//
//  ZMInvitateAcTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvitateAcTableViewCell.h"

@interface ZMInvitateAcTableViewCell ()
@property (nonatomic , strong) UILabel      *titleLabel;
@property (nonatomic , strong) UIImageView  *leftImageView;
@property (nonatomic , strong) UILabel      *leftTopLabel;
@property (nonatomic , strong) UILabel      *leftBottomLabel;
@property (nonatomic , strong) UIImageView  *middleImageView;
@property (nonatomic , strong) UILabel      *middleTopLabel;
@property (nonatomic , strong) UILabel      *middleBottomLabel;
@property (nonatomic , strong) UIImageView  *rightImageView;
@property (nonatomic , strong) UILabel      *rightTopLabel;
@property (nonatomic , strong) UILabel      *rightBottomLabel;
@end

@implementation ZMInvitateAcTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//invitateOne
//intivateTwo
//invitateThree

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //title
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"邀请好友拿奖金"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
        [self.contentView addSubview:self.titleLabel];
        
        //left
        self.leftImageView.image = [UIImage imageNamed:@"invitateOne"];
        [self.contentView addSubview:self.leftImageView];
        
        [ZMLabelAttributeMange setLabel:self.leftTopLabel
                                   text:@"点击立即邀请"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.leftTopLabel];
        
        [ZMLabelAttributeMange setLabel:self.leftBottomLabel
                                   text:@"分享链接给好友"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.leftBottomLabel];
        
        //middle
        self.middleImageView.image = [UIImage imageNamed:@"intivateTwo"];
        [self.contentView addSubview:self.middleImageView];
        
        [ZMLabelAttributeMange setLabel:self.middleTopLabel
                                   text:@"好友注册成功"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.middleTopLabel];
        
        [ZMLabelAttributeMange setLabel:self.middleBottomLabel
                                   text:@"您可得10元红包"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.middleBottomLabel];
        
        //right
        self.rightImageView.image = [UIImage imageNamed:@"invitateThree"];
        [self.contentView addSubview:self.rightImageView];
        
        [ZMLabelAttributeMange setLabel:self.rightTopLabel
                                   text:@"好友的每次交易"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.rightTopLabel];
        
        [ZMLabelAttributeMange setLabel:self.rightBottomLabel
                                   text:@"您都可以领奖金"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.rightBottomLabel];
        
        
        [self setButton:self.shareButton
                  title:@"立即邀请"
                  color:[UIColor colorWithHex:@"FFFFFF"]
                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                    boo:YES];
        [self.shareButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
        [self.contentView addSubview:self.shareButton];
    }
    return self;
}

- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        //button.layer.borderColor  = [UIColor whiteColor].CGColor;
        //button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}


//lazy
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                  SCREEN_WIDTH/375*25,
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_WIDTH/375*22)];
    }
    return _titleLabel;
}

//left
-(UIImageView *)leftImageView{
    if (_leftImageView==nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*44,
                                                                SCREEN_WIDTH/375*71,
                                                                SCREEN_WIDTH/375*45,
                                                                SCREEN_WIDTH/375*50)];
    }
    return _leftImageView;
}


-(UILabel *)leftTopLabel{
    if (_leftTopLabel==nil) {
        _leftTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*24,
                                                                CGRectGetMaxY(self.leftImageView.frame)+SCREEN_WIDTH/375*7,
                                                                SCREEN_WIDTH/375*85,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _leftTopLabel;
}

-(UILabel *)leftBottomLabel{
    if (_leftBottomLabel==nil) {
        _leftBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*14,
                                                                  CGRectGetMaxY(self.leftTopLabel.frame),
                                                                  SCREEN_WIDTH/375*105,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _leftBottomLabel;
}


//middle
-(UIImageView *)middleImageView{
    if (_middleImageView==nil) {
        _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*45)/2,
                                                                       SCREEN_WIDTH/375*71,
                                                                       SCREEN_WIDTH/375*45,
                                                                       SCREEN_WIDTH/375*50)];
    }
    return _middleImageView;
}

-(UILabel *)middleTopLabel{
    if (_middleTopLabel==nil) {
        _middleTopLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*100)/2,
                                                                  CGRectGetMaxY(self.middleImageView.frame)+SCREEN_WIDTH/375*7,
                                                                  SCREEN_WIDTH/375*100,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _middleTopLabel;
}

-(UILabel *)middleBottomLabel{
    if (_middleBottomLabel==nil) {
        _middleBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*100)/2,
                                                                     CGRectGetMaxY(self.middleTopLabel.frame),
                                                                     SCREEN_WIDTH/375*100,
                                                                     SCREEN_WIDTH/375*17)];
    }
    return _middleBottomLabel;
}


//right
-(UIImageView *)rightImageView{
    if (_rightImageView==nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*44-SCREEN_WIDTH/375*45,
                                                                       SCREEN_WIDTH/375*71,
                                                                       SCREEN_WIDTH/375*45,
                                                                       SCREEN_WIDTH/375*50)];
    }
    return _rightImageView;
}

-(UILabel *)rightTopLabel{
    if (_rightTopLabel==nil) {
        _rightTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*44-SCREEN_WIDTH/375*45-SCREEN_WIDTH/375*30,
                                                                    CGRectGetMaxY(self.middleImageView.frame)+SCREEN_WIDTH/375*7,
                                                                    SCREEN_WIDTH/375*105,
                                                                    SCREEN_WIDTH/375*17)];
    }
    return _rightTopLabel;
}

-(UILabel *)rightBottomLabel{
    if (_rightBottomLabel==nil) {
        _rightBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*44-SCREEN_WIDTH/375*45-SCREEN_WIDTH/375*30,
                                                                       CGRectGetMaxY(self.middleTopLabel.frame),
                                                                       SCREEN_WIDTH/375*105,
                                                                       SCREEN_WIDTH/375*17)];
    }
    return _rightBottomLabel;
}

//share
-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                  SCREEN_WIDTH/375*189,
                                                                  SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                  (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*40)];
    }
    return _shareButton;
}


@end
