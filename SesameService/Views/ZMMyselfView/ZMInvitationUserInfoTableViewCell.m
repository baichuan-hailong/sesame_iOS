//
//  ZMInvitationUserInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvitationUserInfoTableViewCell.h"

@implementation ZMInvitationUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //person
        //self.headerImageViwe.backgroundColor     = [UIColor yellowColor];
        self.headerImageViwe.layer.cornerRadius  = SCREEN_WIDTH/375*5;
        self.headerImageViwe.layer.masksToBounds = YES;
        self.headerImageViwe.image               = [UIImage imageNamed:@"placeHeaderImage"];
        [self.contentView addSubview:self.headerImageViwe];
        
        [self.headerImageViwe sd_setImageWithURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201311/13/20131113184407_WsxaM.jpeg"]];
        self.headerImageViwe.contentMode = UIViewContentModeScaleAspectFill;
        
        
        self.nameLabel.textColor = [UIColor colorWithHex:@"333333"];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.nameLabel.text = @"百川川";
        [self.contentView addSubview:self.nameLabel];
        
        self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
        self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.stateImageView];
        
        
        //1
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        //self.memberShipImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.memberShipImageView];
        
    }
    return self;
}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}

//@{@"nick":@"请登录",@"headerImage":@"",@"ishid":@"1"};
- (void)setPersonCell{
    
    
    
}

//person
- (UIImageView *)headerImageViwe{
    
    if (_headerImageViwe==nil) {
        _headerImageViwe = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                         SCREEN_WIDTH/375*13,
                                                                         SCREEN_WIDTH/375*30,
                                                                         SCREEN_WIDTH/375*30)];
    }
    return _headerImageViwe;
}
-(UIImageView *)stateImageView{
    
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*40.8,
                                                                        SCREEN_WIDTH/375*35,
                                                                        SCREEN_WIDTH/375*12.2,
                                                                        SCREEN_WIDTH/375*12.2)];
    }
    return _stateImageView;
}


-(UILabel *)nameLabel{
    
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*63,
                                                               SCREEN_WIDTH/375*18,
                                                               SCREEN_WIDTH/375*45,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _nameLabel;
}

//28 32
-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*110,
                                                                             (SCREEN_WIDTH/375*57-SCREEN_WIDTH/375*16)/2,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}





@end
