//
//  ZMShareSuggestCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareSuggestCell.h"

@implementation ZMShareSuggestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithDic:(NSDictionary *)info {
    
    //code here...
    if (info != nil) {
     
        /* 头像 **/
        
        /* 姓名 **/
        NSString *nameStr;
        if ([[NSString stringWithFormat:@"%@",info[@"info"][@"mask"]] isEqualToString:@"1"]) {
            self.avatarImage.image = [UIImage imageNamed:@"hideNameImage"];
            nameStr = @"匿名";
            self.telNum.alpha = 0;
            
        } else {
            [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",info[@"asker"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
            if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"type"]] isEqualToString:@"1"]) {
                nameStr = [NSString stringWithFormat:@"%@",info[@"asker"][@"person_name"]];
            } else {
                nameStr = [NSString stringWithFormat:@"%@",info[@"asker"][@"corp_name"]];
            }
            self.telNum.alpha = 1;
        }
        CGSize size = CGSizeMake(0, SCREEN_WIDTH/26.78);
        CGSize autoSize = [self.nickNameLable actualSizeOfLable:nameStr
                                                        andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3] andSize:size];
        self.nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/25,
                                              self.avatarImage.centerY - (SCREEN_WIDTH/26.78)/2,
                                              autoSize.width,
                                              SCREEN_WIDTH/26.78 + 3);
        
        
        NSString *vipStr;
        if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"level"]] isEqualToString:@"gold"]) {
            /* 金牌 **/
            self.vipImage.image = [UIImage imageNamed:@"jinpaiImage"];
            vipStr = @"会员等级：金牌会员";
        } else if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"level"]] isEqualToString:@"silver"]) {
            /* 银牌 **/
            self.vipImage.image = [UIImage imageNamed:@"yinpaiImage"];
            vipStr = @"会员等级：银牌会员";
        } else {
            /* 铜牌 **/
            self.vipImage.image = [UIImage imageNamed:@"tongpaiImage"];
            vipStr = @"会员等级：铜牌会员";
        }
        
        
        /* 会员等级 */
        NSMutableAttributedString *vipAttriStr = [[NSMutableAttributedString alloc] initWithString:vipStr];
        [vipAttriStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"151515"] range:NSMakeRange(5, vipStr.length-5)];
        self.vipLevel.attributedText = vipAttriStr;
        
        /* 联系电话 */
        NSMutableAttributedString *telStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"联系电话：购买可见"]];
        [telStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:tonalColor] range:NSMakeRange(5, telStr.length-5)];
        self.telNum.attributedText = telStr;
        
        /* 实名认证 */
        NSString *cerTmpStr;
        if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"auth"]] isEqualToString:@"unauthed"] ||
            [[NSString stringWithFormat:@"%@",info[@"asker"][@"auth"]] isEqualToString:@"unchecked"] ||
            [[NSString stringWithFormat:@"%@",info[@"asker"][@"auth"]] isEqualToString:@"failed"]) {
            /* 未认证 **/
            if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"type"]] isEqualToString:@"1"]) {
                cerTmpStr = @"实名认证：未认证，请谨慎购买";
            } else {
                cerTmpStr = @"企业认证：未认证，请谨慎购买";
            }
            
            self.certificalImage.alpha = 0;
        } else {
            /* 已认证 **/
            if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"type"]] isEqualToString:@"1"]) {
                cerTmpStr = @"实名认证：已认证";
            } else {
                cerTmpStr = @"企业认证：已认证";
            }
            
            self.certificalImage.alpha = 1;
        }
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:cerTmpStr];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"151515"] range:NSMakeRange(5, cerStr.length-5)];
        self.certifical.attributedText = cerStr;
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHex:backColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.avatarImage];
        [self.backView addSubview:self.certificalImage];
        [self.backView addSubview:self.nickNameLable];
        [self.backView addSubview:self.vipImage];
        [self.backView addSubview:self.vipLevel];
        [self.backView addSubview:self.telNum];
        [self.backView addSubview:self.certifical];

        
    }
    return self;
}

- (UIView *)backView {
    
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3.125);
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)avatarImage {
    
    if (_avatarImage == nil) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                     SCREEN_WIDTH/25,
                                                                     SCREEN_WIDTH/12.5,
                                                                     SCREEN_WIDTH/12.5)];
        _avatarImage.backgroundColor = [UIColor colorWithHex:backColor];
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.cornerRadius = 4;
        _avatarImage.layer.borderColor = [UIColor colorWithHex:@"bbbbbb"].CGColor;
        _avatarImage.layer.borderWidth = 0.3;
    }
    return _avatarImage;
}

- (UILabel *)nickNameLable {
    
    if (_nickNameLable == nil) {
        _nickNameLable = [[UILabel alloc] init];
        _nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/25,
                                          self.avatarImage.centerY - (SCREEN_WIDTH/26.78)/2,
                                          0,
                                          SCREEN_WIDTH/26.78);
        _nickNameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3];
        _nickNameLable.textAlignment = NSTextAlignmentLeft;
        _nickNameLable.textColor = [UIColor colorWithHex:@"333333"];
    }
    return _nickNameLable;
}

- (UIImageView *)certificalImage {
    
    if (_certificalImage == nil) {
        _certificalImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.avatarImage.right - (SCREEN_WIDTH/28.85)/2 - 2,
                                                                         self.avatarImage.bottom - (SCREEN_WIDTH/28.85)/2 - 2,
                                                                         SCREEN_WIDTH/28.85,
                                                                         SCREEN_WIDTH/28.85)];
        _certificalImage.layer.masksToBounds = YES;
        _certificalImage.image = [UIImage imageNamed:@"haveRenzhengImage"];
    }
    return _certificalImage;
}

- (UIImageView *)vipImage {
    
    if (_vipImage == nil) {
        _vipImage = [[UIImageView alloc] init];
        _vipImage.layer.masksToBounds = YES;
    }
    _vipImage.frame = CGRectMake(self.nickNameLable.right + SCREEN_WIDTH/75,
                                 self.nickNameLable.centerY - (SCREEN_WIDTH/23.43)/2,
                                 SCREEN_WIDTH/26.78,
                                 SCREEN_WIDTH/23.43);
    return _vipImage;
}

- (UILabel *)vipLevel {
    
    if (_vipLevel == nil) {
        _vipLevel = [[UILabel alloc] init];
        _vipLevel.frame = CGRectMake(SCREEN_WIDTH/25,
                                     self.avatarImage.bottom + SCREEN_WIDTH/22.05,
                                     (SCREEN_WIDTH - SCREEN_WIDTH/8.33)/2,
                                     SCREEN_WIDTH/26.78);
        _vipLevel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _vipLevel.textAlignment = NSTextAlignmentLeft;
        _vipLevel.textColor = [UIColor colorWithHex:@"999999"];
    }
    return _vipLevel;
}

- (UILabel *)telNum {
    
    if (_telNum == nil) {
        _telNum = [[UILabel alloc] init];
        _telNum.frame = CGRectMake(self.vipLevel.right,
                                   self.avatarImage.bottom + SCREEN_WIDTH/22.05,
                                   (SCREEN_WIDTH - SCREEN_WIDTH/8.33)/2,
                                   SCREEN_WIDTH/26.78);
        _telNum.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _telNum.textAlignment = NSTextAlignmentLeft;
        _telNum.textColor = [UIColor colorWithHex:@"999999"];
    }
    return _telNum;
}

- (UILabel *)certifical {
    
    if (_certifical == nil) {
        _certifical = [[UILabel alloc] init];
        _certifical.frame = CGRectMake(SCREEN_WIDTH/25,
                                       self.vipLevel.bottom + SCREEN_WIDTH/31.25,
                                       SCREEN_WIDTH - SCREEN_WIDTH/12.5,
                                       SCREEN_WIDTH/26.78);
        _certifical.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _certifical.textAlignment = NSTextAlignmentLeft;
        _certifical.textColor = [UIColor colorWithHex:@"999999"];
    }
    return _certifical;
}


@end
