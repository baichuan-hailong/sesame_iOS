//
//  ZMAllUnderStandTopCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/17.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderStandTopCell.h"

@implementation ZMAllUnderStandTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setValueWithDic:(NSDictionary *)info {
    
    if (info != nil) {
        
        /** 头像 */
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",info[@"user"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        
        /* 昵称 **/
        NSString *nickName;
        if ([[NSString stringWithFormat:@"%@",info[@"user"][@"type"]] isEqualToString:@"1"]) {
            nickName = [NSString stringWithFormat:@"%@",info[@"user"][@"person_name"]];
        } else {
            nickName = [NSString stringWithFormat:@"%@",info[@"user"][@"corp_name"]];
        }
        CGSize Nicksize = CGSizeMake(0, SCREEN_WIDTH/26.78);
        CGSize NickautoSize = [self.nickNameLable actualSizeOfLable:nickName
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3] andSize:Nicksize];
        self.nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/25,
                                              self.avatarImage.centerY - (SCREEN_WIDTH/26.78)/2,
                                              NickautoSize.width,
                                              SCREEN_WIDTH/26.78 + 3);
        
        if ([[NSString stringWithFormat:@"%@",info[@"user"][@"level"]] isEqualToString:@"gold"]) {
            /* 金牌 **/
            self.vipImage.image = [UIImage imageNamed:@"jinpaiImage"];
        } else if ([[NSString stringWithFormat:@"%@",info[@"user"][@"level"]] isEqualToString:@"silver"]) {
            /* 银牌 **/
            self.vipImage.image = [UIImage imageNamed:@"yinpaiImage"];
        } else {
            /* 铜牌 **/
            self.vipImage.image = [UIImage imageNamed:@"tongpaiImage"];
        }
        
        if ([[NSString stringWithFormat:@"%@",info[@"user"][@"auth"]] isEqualToString:@"authed"]) {
            /** 已认证 */
            self.certificalImage.alpha = 1;
        } else {
            /** 未认证 */
            self.certificalImage.alpha = 0;
        }
        
        /** 赏金 */
        self.priceLable.text = [NSString stringWithFormat:@"赏金 ¥%@",info[@"price"]];
        
        /* 文字 **/
        CGSize size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, 0);
        CGSize autoSize = [self.contentLable actualSizeOfLable:[NSString stringWithFormat:@"%@",info[@"question"]]
                                                       andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85] andSize:size];
        self.contentLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                             self.avatarImage.bottom + SCREEN_WIDTH/37.5,
                                             SCREEN_WIDTH - SCREEN_WIDTH/12.5,
                                             autoSize.height);
        
        /* 图片 **/
        self.photosView.py_x = SCREEN_WIDTH/25;
        NSArray *imgArr      = (NSArray *)info[@"images"];
        if (imgArr.count != 0) {
            self.photosView.height = SCREEN_WIDTH/6.25;
            self.photosView.py_y   = self.contentLable.bottom + SCREEN_WIDTH/37.5;

            NSMutableArray *images = [[NSMutableArray alloc] init];
            for (int i = 0; i < imgArr.count; i++) {
                NSString *imgStr   = [NSString stringWithFormat:@"%@",[imgArr objectAt:i][@"file"]];
                [images addObject:imgStr];
            }
            self.photosView.thumbnailUrls = images;
            self.photosView.originalUrls  = images;
            if (imgArr.count == 1) {
                self.photosView.py_width  = (SCREEN_WIDTH/6.25);
            } else {
                self.photosView.py_width  = (SCREEN_WIDTH/6.25) * 4 + 30;
            }

        } else {
            //没图片
            self.photosView.thumbnailUrls = nil;
            self.photosView.originalUrls  = nil;
            self.photosView.height = 0;
            self.photosView.py_y = self.contentLable.bottom;
        }
        
        [self tipsImage];
        
        if ([[NSString stringWithFormat:@"%@",info[@"status"]] isEqualToString:@"complete"]) {
            /** 已完成 */
            self.tipsImage.image = [UIImage imageNamed:@"home_已完成"];
            self.tipsLable.text = [NSString stringWithFormat:@"已完成  |  %@人已抢答",info[@"answer_user_num"]];
            
        } else if ([[NSString stringWithFormat:@"%@",info[@"status"]] isEqualToString:@"expired"]) {
            /** 已过期 */
            self.tipsLable.text = @"已过期";
            self.tipsImage.image = [UIImage imageNamed:@"yiguoqi"];
        } else if ([[NSString stringWithFormat:@"%@",info[@"status"]] isEqualToString:@"closed"]) {
            /** 已撤销 */
            self.tipsLable.text = @"已撤销";
            self.tipsImage.image = [UIImage imageNamed:@"yichexiao"];
        } else {
            /** 未完成 */
            self.tipsImage.image = [UIImage imageNamed:@"isComingImage"];
            self.tipsLable.text = [NSString stringWithFormat:@"还剩%@小时  |  %@人已抢答",info[@"last_hours"],info[@"answer_user_num"]];
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
        [self addSubview:self.priceLable];
        [self addSubview:self.contentLable];
        [self addSubview:self.photosView];
        [self addSubview:self.tipsImage];
        [self addSubview:self.tipsLable];
    }
    return self;
}

#pragma maek - getter
- (UIImageView *)avatarImage {

    if (_avatarImage == nil) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.frame = CGRectMake(SCREEN_WIDTH/25, SCREEN_WIDTH/37.5, SCREEN_WIDTH/10.7, SCREEN_WIDTH/10.7);
        _avatarImage.backgroundColor = [UIColor lightGrayColor];
        _avatarImage.layer.cornerRadius = 2;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}

- (UILabel *)nickNameLable {

    if (_nickNameLable == nil) {
        _nickNameLable = [[UILabel alloc] init];
        _nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/37.5,
                                          self.avatarImage.centerY - (SCREEN_WIDTH/26.78)/2,
                                          SCREEN_WIDTH/2,
                                          SCREEN_WIDTH/26.78);
        _nickNameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _nickNameLable.textColor = [UIColor colorWithHex:@"333333"];
        _nickNameLable.text = @"张三";
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

- (UILabel *)priceLable {
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.frame = CGRectMake(SCREEN_WIDTH - 120 - SCREEN_WIDTH/25,
                                       self.avatarImage.centerY - (SCREEN_WIDTH/28.85)/2,
                                       120,
                                       SCREEN_WIDTH/28.85);
        _priceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _priceLable.textColor = [UIColor colorWithHex:@"EB6D62"];
        _priceLable.textAlignment = NSTextAlignmentRight;
    }
    return _priceLable;
}

- (UILabel *)contentLable {
    
    if (_contentLable == nil) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                         self.avatarImage.bottom + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/12.5,
                                         0);
        _contentLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _contentLable.textColor = [UIColor colorWithHex:@"333333"];
        _contentLable.numberOfLines = 0;
    }
    return _contentLable;
}

- (PYPhotosView *)photosView {
    
    if (_photosView == nil) {
        
        _photosView = [PYPhotosView photosView];
        _photosView.layoutType = PYPhotosViewLayoutTypeFlow;
        _photosView.autoLayoutWithWeChatSytle = NO;
        _photosView.py_height  = SCREEN_WIDTH/6.25;
        
        // 设置图片间距为10
        _photosView.photoMargin  = 10;
        _photosView.photosMaxCol = 4;
        _photosView.photoWidth   = SCREEN_WIDTH/6.25;
        _photosView.photoHeight  = SCREEN_WIDTH/6.25;
    }
    return _photosView;
}

- (UIImageView *)tipsImage {
    
    if (_tipsImage == nil) {
        _tipsImage = [[UIImageView alloc] init];
        _tipsImage.image = [UIImage imageNamed:@"home_已完成"];
    }
    _tipsImage.frame = CGRectMake(SCREEN_WIDTH/25,
                                  self.photosView.bottom + SCREEN_WIDTH/37.5,
                                  SCREEN_WIDTH/31.25,
                                  SCREEN_WIDTH/31.25);
    return _tipsImage;
}

- (UILabel *)tipsLable {
    
    if (_tipsLable == nil) {
        _tipsLable = [[UILabel alloc] init];
        _tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable.textColor = [UIColor colorWithHex:@"999999"];
    }
    _tipsLable.frame = CGRectMake(self.tipsImage.right + 5,
                                  self.photosView.bottom + SCREEN_WIDTH/37.5 - 0.5,
                                  SCREEN_WIDTH - SCREEN_WIDTH/12.5 - self.tipsImage.width,
                                  SCREEN_WIDTH/31.25);
    return _tipsLable;
}






@end
