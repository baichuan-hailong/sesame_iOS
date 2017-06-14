//
//  ZMPeopleOfSellTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPeopleOfSellTableViewCell.h"

@implementation ZMPeopleOfSellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

//142
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  = [UIColor whiteColor];
        
        //person
        self.headerImageViwe.layer.cornerRadius  = SCREEN_WIDTH/375*3;
        self.headerImageViwe.layer.masksToBounds = YES;
        self.headerImageViwe.image               = [UIImage imageNamed:@"placeHeaderImage"];
        [self.contentView addSubview:self.headerImageViwe];
        
        //[self.headerImageViwe sd_setImageWithURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201311/13/20131113184407_WsxaM.jpeg"]];
        self.headerImageViwe.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageViwe .backgroundColor = [UIColor lightGrayColor];
        
        //state
        self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
        self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
        self.stateImageView.alpha = 0;
        [self.contentView addSubview:self.stateImageView];
        
        
        self.nameLabel.textColor = [UIColor colorWithHex:@"333333"];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.nameLabel.text = @"--";
        [self.contentView addSubview:self.nameLabel];
        
        
        //1
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        //self.memberShipImageView.backgroundColor = [UIColor yellowColor];
        self.memberShipImageView.alpha = 0;
        [self.contentView addSubview:self.memberShipImageView];
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
        //[self.contentView addSubview:self.line];
        
        
        
        //level
        [ZMLabelAttributeMange setLabel:self.levelLabel
                                   text:@"会员等级：---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.levelLabel];
        
        //tel
        [ZMLabelAttributeMange setLabel:self.telLabel
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.telLabel];
        
        //cer
        [ZMLabelAttributeMange setLabel:self.isCerLabel
                                   text:@"实名认证：--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.isCerLabel];

        
    }
    return self;
}

- (void)setAsker:(NSDictionary *)askDic mask:(NSString *)mask{

    /*
     asker =         {
     auth = authed;
     avatar = "";
     "corp_name" = "";
     id = 10005;
     level = copper;
     "person_name" = 1234;
     type = 1;
     username = 13683027794;
     }
     */
    NSString *avatar      = [NSString stringWithFormat:@"%@",askDic[@"avatar"]];
    NSString *auth        = [NSString stringWithFormat:@"%@",askDic[@"auth"]];
    NSString *person_name = [NSString stringWithFormat:@"%@",askDic[@"person_name"]];
    NSString *corp_name = [NSString stringWithFormat:@"%@",askDic[@"corp_name"]];
    NSString *level       = [NSString stringWithFormat:@"%@",askDic[@"level"]];
    NSString *username    = [NSString stringWithFormat:@"%@",askDic[@"username"]];
    
    NSString *type    = [NSString stringWithFormat:@"%@",askDic[@"type"]];
    

    if ([type isEqualToString:@"1"]) {
        if ([auth isEqualToString:@"authed"]){
            self.stateImageView.alpha = 1;
            self.isCerLabel.text = @"实名认证：已认证";
        }else{
            if (auth.length>0&&![auth isEqualToString:@"(null)"]) {
                self.stateImageView.alpha = 0;
                self.isCerLabel.text = @"实名认证：未认证";
            }
        }
    }else{
    
        if ([auth isEqualToString:@"authed"]){
            self.stateImageView.alpha = 1;
            self.isCerLabel.text = @"企业认证：已认证";
        }else{
            if (auth.length>0&&![auth isEqualToString:@"(null)"]) {
                self.stateImageView.alpha = 0;
                self.isCerLabel.text = @"企业认证：未认证";
            }
        }
    }
    

    
    if ([mask integerValue]==1) {
        self.nameLabel.text = @"匿名";
        self.headerImageViwe .image = [UIImage imageNamed:@"hideNameImage"];
        self.telLabel.alpha = 0;
    }else{
        
        
        if ([type isEqualToString:@"1"]) {
            if (person_name.length>0&&![person_name isEqualToString:@"(null)"]) {
                self.nameLabel.text = person_name;
            }
        }else{
            if (corp_name.length>0&&![corp_name isEqualToString:@"(null)"]) {
                self.nameLabel.text = corp_name;
            }
        }
        
        NSLog(@"avatar------------%@",avatar);
        if (avatar.length>10) {
            [self.headerImageViwe sd_setImageWithURL:[NSURL URLWithString:avatar]
                                    placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
            self.headerImageViwe .backgroundColor = [UIColor lightGrayColor];
        }else{
            self.headerImageViwe .image = [UIImage imageNamed:@"placeHeaderImage"];
        }
        
        if (username.length>0&&![username isEqualToString:@"(null)"]) {
            self.telLabel.text = [NSString stringWithFormat:@"联系电话：%@",username];
        }
        self.telLabel.alpha = 1;
    }
    

    
    [self.nameLabel sizeToFit];
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*6,
                                                SCREEN_WIDTH/375*15,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
    
    
    if ([level isEqualToString:@"gold"]) {
        self.levelLabel.text  = @"会员等级：金牌会员";
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        self.memberShipImageView.alpha = 1;
    }else if ([level isEqualToString:@"silver"]){
        self.levelLabel.text  = @"会员等级：银牌会员";
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
        self.memberShipImageView.alpha = 1;
    }else if ([level isEqualToString:@"copper"]){
        self.levelLabel.text  = @"会员等级：铜牌会员";
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
        self.memberShipImageView.alpha = 1;
    }
}




//lazy
- (UIImageView *)headerImageViwe{
    if (_headerImageViwe==nil) {
        _headerImageViwe = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                         SCREEN_WIDTH/375*3,
                                                                         SCREEN_WIDTH/375*40,
                                                                         SCREEN_WIDTH/375*40)];
    }
    return _headerImageViwe;
}

-(UIImageView *)stateImageView{
    
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*49.8,
                                                                        SCREEN_WIDTH/375*33,
                                                                        SCREEN_WIDTH/375*13,
                                                                        SCREEN_WIDTH/375*13)];
    }
    return _stateImageView;
}



-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*78,
                                                               SCREEN_WIDTH/375*13,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*20)];
        
    }
    return _nameLabel;
}


//member
-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame),
                                                                             SCREEN_WIDTH/375*15,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}


//line
-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                         SCREEN_WIDTH/375*59,
                                                         SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*19,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}

-(UILabel *)levelLabel{
    if (_levelLabel==nil) {
        _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                         SCREEN_WIDTH/375*14+CGRectGetMaxY(self.headerImageViwe.frame),
                                                         SCREEN_WIDTH/375*150,
                                                         SCREEN_WIDTH/375*20)];
    }
    return _levelLabel;
}


-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*20-SCREEN_WIDTH/375*180,
                                                              SCREEN_WIDTH/375*14+CGRectGetMaxY(self.headerImageViwe.frame),
                                                              SCREEN_WIDTH/375*180,
                                                              SCREEN_WIDTH/375*20)];
    }
    return _telLabel;
}


-(UILabel *)isCerLabel{
    if (_isCerLabel==nil) {
        _isCerLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                              SCREEN_WIDTH/375*11+CGRectGetMaxY(self.telLabel.frame),
                                                              SCREEN_WIDTH/375*160,
                                                              SCREEN_WIDTH/375*20)];
    }
    return _isCerLabel;
}

@end
