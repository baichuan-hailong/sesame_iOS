//
//  ZMAimAnswererInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAimAnswererInfoTableViewCell.h"

@implementation ZMAimAnswererInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setValueWithDic:(NSDictionary *)info {
    
    //...
    if (info != nil) {
        
        /** 头像 */
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",info[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        
        /** 昵称 */
        CGSize Nicksize = CGSizeMake(0, SCREEN_WIDTH/28.85);
        CGSize NickautoSize = [self.nickNameLable actualSizeOfLable:[NSString stringWithFormat:@"%@",info[@"person_name"]]
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3] andSize:Nicksize];
        self.nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/37.5,
                                              self.avatarImage.top,
                                              NickautoSize.width,
                                              SCREEN_WIDTH/28.85);
        
        /** 公司职位 */
        NSString *companyStr;
        if (![[NSString stringWithFormat:@"%@",info[@"corp_name"]] isEqualToString:@""] &&
            ![[NSString stringWithFormat:@"%@",info[@"title"]] isEqualToString:@""]) {
            companyStr = [NSString stringWithFormat:@"%@ | %@",info[@"corp_name"],info[@"title"]];
        } else if ([[NSString stringWithFormat:@"%@",info[@"corp_name"]] isEqualToString:@""] &&
                   [[NSString stringWithFormat:@"%@",info[@"title"]] isEqualToString:@""]) {
            //companyStr = @"暂无企业和职位信息";
            companyStr = @"";
        } else {
            companyStr = [NSString stringWithFormat:@"%@%@",info[@"corp_name"],info[@"title"]];
        }
        self.companyLable.text = companyStr;
        
        if ([[NSString stringWithFormat:@"%@",info[@"level"]] isEqualToString:@"gold"]) {
            /* 金牌 **/
            self.vipImage.image = [UIImage imageNamed:@"jinpaiImage"];
        } else if ([[NSString stringWithFormat:@"%@",info[@"level"]] isEqualToString:@"silver"]) {
            /* 银牌 **/
            self.vipImage.image = [UIImage imageNamed:@"yinpaiImage"];
        } else {
            /* 铜牌 **/
            self.vipImage.image = [UIImage imageNamed:@"tongpaiImage"];
        }
        
        if ([[NSString stringWithFormat:@"%@",info[@"auth"]] isEqualToString:@"authed"]) {
            /** 已认证 */
            self.certificalImage.alpha = 1;
        } else {
            /** 未认证 */
            self.certificalImage.alpha = 0;
        }

        
        
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.avatarImage];
        [self addSubview:self.certificalImage];
        [self addSubview:self.nickNameLable];
        [self addSubview:self.vipImage];
        [self addSubview:self.companyLable];
    }
    return self;
}

#pragma maek - getter
- (UIImageView *)avatarImage {
    
    if (_avatarImage == nil) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.frame = CGRectMake(SCREEN_WIDTH/25,
                                       (SCREEN_WIDTH/5.36 - SCREEN_WIDTH/10.7)/2,
                                        SCREEN_WIDTH/10.7,
                                        SCREEN_WIDTH/10.7);
        _avatarImage.backgroundColor = [UIColor lightGrayColor];
        _avatarImage.layer.cornerRadius  = 2;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}

- (UILabel *)nickNameLable {
    
    if (_nickNameLable == nil) {
        _nickNameLable = [[UILabel alloc] init];
        _nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/37.5,
                                          self.avatarImage.top,
                                          SCREEN_WIDTH/2,
                                          SCREEN_WIDTH/28.85);
        _nickNameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
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
        _vipImage.image = [UIImage imageNamed:@"jinpaiImage"];
    }
    _vipImage.frame = CGRectMake(self.nickNameLable.right + SCREEN_WIDTH/75,
                                 self.nickNameLable.centerY - (SCREEN_WIDTH/23.43)/2,
                                 SCREEN_WIDTH/26.78,
                                 SCREEN_WIDTH/23.43);
    return _vipImage;
}


- (UILabel *)companyLable {
    
    if (_companyLable == nil) {
        _companyLable = [[UILabel alloc] init];
        _companyLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/37.5,
                                         self.vipImage.bottom + SCREEN_WIDTH/62.5,
                                         SCREEN_WIDTH - self.avatarImage.width - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/31.25);
        _companyLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _companyLable.textColor = [UIColor colorWithHex:@"666666"];
    }
    return _companyLable;
}


@end
