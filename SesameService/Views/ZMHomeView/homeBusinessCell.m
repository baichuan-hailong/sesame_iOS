//
//  homeBusinessCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "homeBusinessCell.h"

@implementation homeBusinessCell

- (void)setValueWithDic:(NSDictionary *)info {

    //code here...
    self.titleLable.text   = [NSString stringWithFormat:@"%@",info[@"title"]];
    self.detailLable.text  = [NSString stringWithFormat:@"%@ | 标的额%@ | %@",info[@"type"],
                              [[NSString stringWithFormat:@"%@",info[@"target_amount"]] isEqualToString:@"<null>"] ? @"" : info[@"target_amount"][@"title"],
                              [[NSString stringWithFormat:@"%@",info[@"support_level"]] isEqualToString:@"<null>"] ? @"" : info[@"support_level"][@"title"]];
    self.contentLable.text = [NSString stringWithFormat:@"%@",info[@"description"]];
    self.unitPrice.text    = [NSString stringWithFormat:@"¥%@",info[@"price"]];
    
    
    //姓名
    NSString *nameStr;
    if ([[NSString stringWithFormat:@"%@",info[@"mask"]] isEqualToString:@"1"]) {
        self.avatarImage.image = [UIImage imageNamed:@"hideNameImage"];
        nameStr = @"匿名";
    } else {
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",info[@"asker"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"type"]] isEqualToString:@"1"]) {
            nameStr = [NSString stringWithFormat:@"%@",info[@"asker"][@"person_name"]];
        } else {
            nameStr = [NSString stringWithFormat:@"%@",info[@"asker"][@"corp_name"]];
        }
    }
    CGSize size = CGSizeMake(0, SCREEN_WIDTH/26.78);
    CGSize autoSize = [self.nickNameLable actualSizeOfLable:nameStr
                                                    andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3] andSize:size];
    self.nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/25,
                                          self.avatarImage.centerY - (SCREEN_WIDTH/26.78)/2,
                                          autoSize.width,
                                          SCREEN_WIDTH/26.78 + 3);
    
    /* 实名认证 */
    if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"auth"]] isEqualToString:@"unauthed"] ||
        [[NSString stringWithFormat:@"%@",info[@"asker"][@"auth"]] isEqualToString:@"unchecked"] ||
        [[NSString stringWithFormat:@"%@",info[@"asker"][@"auth"]] isEqualToString:@"failed"]) {
        /* 未认证 **/
        self.certificalImage.alpha = 0;
    } else {
        /* 已认证 **/
        self.certificalImage.alpha = 1;
    }
    
    if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"level"]] isEqualToString:@"gold"]) {
        /* 金牌 **/
        self.vipImage.image = [UIImage imageNamed:@"jinpaiImage"];
    } else if ([[NSString stringWithFormat:@"%@",info[@"asker"][@"level"]] isEqualToString:@"silver"]) {
        /* 银牌 **/
        self.vipImage.image = [UIImage imageNamed:@"yinpaiImage"];
    } else {
        /* 铜牌 **/
        self.vipImage.image = [UIImage imageNamed:@"tongpaiImage"];
    }
    
    
    /*
    [self.tagView removeAllTags];
    [self.tagView addTags:@[@"策划", @"顾问", @"广告媒体资源", @"公关活动", @"室内设计装饰", @"好 ", @"建筑工程施工", @"活动"]];
     */
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:backColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.avatarImage];
        [self.backView addSubview:self.certificalImage];
        [self.backView addSubview:self.nickNameLable];
        [self.backView addSubview:self.vipImage];
        
        [self.backView addSubview:self.titleLable];
        [self.backView addSubview:self.detailLable];
        [self.backView addSubview:self.contentLable];
        
        [self.backView addSubview:self.lineImage];
        [self.backView addSubview:self.unitPrice];
        [self.backView addSubview:self.buyBtn];
        //[self.backView addSubview:self.tagView];
    }
    return self;
}

- (UIView *)backView {
    
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        _backView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        [_backView addSubview:line];
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
        _vipImage.image = [UIImage imageNamed:@"jinpaiImage"];
    }
    _vipImage.frame = CGRectMake(self.nickNameLable.right + SCREEN_WIDTH/75,
                                 self.nickNameLable.centerY - (SCREEN_WIDTH/23.43)/2,
                                 SCREEN_WIDTH/26.78,
                                 SCREEN_WIDTH/23.43);
    return _vipImage;
}

- (UILabel *)titleLable {

    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       self.avatarImage.bottom + SCREEN_WIDTH/25,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78 + 3);
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHex:@"333333"];
    }
    return _titleLable;
}

- (UILabel *)detailLable {
    
    if (_detailLable == nil) {
        _detailLable = [[UILabel alloc] init];
        _detailLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                        CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/37.5,
                                        SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                        SCREEN_WIDTH/31.25);
        _detailLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.textColor = [UIColor colorWithHex:@"555555"];
    }
    return _detailLable;
}

- (UILabel *)contentLable {
    
    if (_contentLable == nil) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.detailLable.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/31.25);
        _contentLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.textColor = [UIColor colorWithHex:@"555555"];
    }
    return _contentLable;
}

- (UIImageView *)lineImage {
    
    if (_lineImage == nil) {
        _lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                   self.contentLable.bottom + SCREEN_WIDTH/31.25,
                                                                   SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                   1)];
        /** 虚线 */
        [toolClass drawDashLine:_lineImage lineLength:3 lineSpacing:3 lineColor:[UIColor colorWithHex:@"cccccc"]];
    }
    return _lineImage;
}


- (UILabel *)unitPrice {
    
    if (_unitPrice == nil) {
        _unitPrice = [[UILabel alloc] init];
        _unitPrice.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      self.lineImage.bottom + (self.backView.bottom - self.lineImage.bottom)/2 - (SCREEN_WIDTH/20.83)/2,
                                      SCREEN_WIDTH/1.35,
                                      SCREEN_WIDTH/20.83);
        _unitPrice.font = [UIFont fontWithName:@"Futura-Medium" size:SCREEN_WIDTH/20.83];
        _unitPrice.textAlignment = NSTextAlignmentLeft;
        _unitPrice.textColor = [UIColor colorWithHex:@"ee6b6a"];
    }
    return _unitPrice;
}

- (UIButton *)buyBtn {
    
    if (_buyBtn == nil) {
        _buyBtn = [[UIButton alloc] init];
        _buyBtn.frame = CGRectMake(self.backView.frame.size.width - SCREEN_WIDTH/4.69 - SCREEN_WIDTH/18.75,
                                   self.lineImage.bottom + (self.backView.bottom - self.lineImage.bottom)/2 - ((SCREEN_WIDTH/4.69)/2.22)/2,
                                   SCREEN_WIDTH/4.69,
                                   (SCREEN_WIDTH/4.69)/2.22);
        _buyBtn.backgroundColor = [UIColor colorWithHex:@"00bf8f"];
        
        _buyBtn.layer.cornerRadius = 4;
        [_buyBtn setTitle:@"立即买走" forState:UIControlStateNormal];
        [_buyBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/31.25]];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _buyBtn;
}



/** 标签 */
- (TTGTextTagCollectionView *)tagView {

    if (_tagView == nil) {
        _tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/22 - 3,
                                                                              CGRectGetMaxY(self.unitPrice.frame) + SCREEN_WIDTH/75,
                                                                              SCREEN_WIDTH - SCREEN_WIDTH/11,
                                                                              self.backView.frame.size.height - CGRectGetMaxY(self.unitPrice.frame))];
        
        /** config */
        _tagView.defaultConfig.tagTextFont          = [UIFont systemFontOfSize:SCREEN_WIDTH/37.5];
        _tagView.defaultConfig.tagTextColor         = [UIColor colorWithHex:@"aaaaaa"];
        _tagView.defaultConfig.tagSelectedTextColor = [UIColor colorWithHex:@"aaaaaa"];
        _tagView.defaultConfig.tagBackgroundColor   = [UIColor whiteColor];
        _tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor whiteColor];
        _tagView.defaultConfig.tagCornerRadius      = (SCREEN_WIDTH/37.5 + 3)/2;
        _tagView.defaultConfig.tagSelectedCornerRadius = (SCREEN_WIDTH/37.5 + 3)/2;
        _tagView.defaultConfig.tagBorderWidth       = 0.5;
        _tagView.defaultConfig.tagSelectedBorderWidth = 0.5;
        _tagView.defaultConfig.tagBorderColor       = [UIColor colorWithHex:@"bbbbbb"];
        _tagView.defaultConfig.tagSelectedBorderColor = [UIColor colorWithHex:@"bbbbbb"];
        _tagView.defaultConfig.tagShadowColor       = [UIColor whiteColor];
        _tagView.defaultConfig.tagShadowOffset      = CGSizeMake(0, 0);
        _tagView.defaultConfig.tagShadowRadius      = 0;
        _tagView.defaultConfig.tagShadowOpacity     = 0;
        _tagView.defaultConfig.tagExtraSpace        = CGSizeMake(12, 3);
        _tagView.verticalSpacing = 3;
    }
    return _tagView;
}




@end
