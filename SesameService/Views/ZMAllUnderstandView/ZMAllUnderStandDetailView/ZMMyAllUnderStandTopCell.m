//
//  ZMMyAllUnderStandTopCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/12.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyAllUnderStandTopCell.h"

@implementation ZMMyAllUnderStandTopCell

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
        
        /** 时间 */
        self.timeLable.text = [toolClass changeTime:[NSString stringWithFormat:@"%@",info[@"time"]]];
        
        /** 赏金 */
        self.priceLable.text = [NSString stringWithFormat:@"赏金 ¥%@",info[@"price"]];
        
        /* 文字 **/
        CGSize size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, 0);
        CGSize autoSize = [self.contentLable actualSizeOfLable:[NSString stringWithFormat:@"%@",info[@"question"]]
                                                       andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85] andSize:size];
        self.contentLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                             self.timeLable.bottom + SCREEN_WIDTH/37.5,
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
        
        
        if ([[NSString stringWithFormat:@"%@",info[@"status"]] isEqualToString:@"asked"]) {
            self.cancelBtn.alpha = 1;
        } else {
            self.cancelBtn.alpha = 0;
        }
        
        if ([[NSString stringWithFormat:@"%@",info[@"status"]] isEqualToString:@"complete"]) {
            /** 已完成 */
            self.tipsImage.image = [UIImage imageNamed:@"home_已完成"];
            if ([[NSString stringWithFormat:@"%@",info[@"aim_answerer_info"]] isEqualToString:@"<null>"] ||
                [[NSString stringWithFormat:@"%@",info[@"aim_answerer_info"]] isEqualToString:@"(null)"]) {
                self.tipsLable.text = [NSString stringWithFormat:@"已完成  |  %@人已抢答",info[@"answer_user_num"]];
            } else {
                self.tipsLable.text = @"已完成";
            }
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
            if ([[NSString stringWithFormat:@"%@",info[@"aim_answerer_info"]] isEqualToString:@"<null>"] ||
                [[NSString stringWithFormat:@"%@",info[@"aim_answerer_info"]] isEqualToString:@"(null)"]) {
                self.tipsLable.text = [NSString stringWithFormat:@"进行中，还剩%@小时  |  %@人已抢答",info[@"last_hours"],info[@"answer_user_num"]];
            } else {
                self.tipsLable.text = [NSString stringWithFormat:@"进行中，还剩%@小时",info[@"last_hours"]];
            }
        }
       
        CGSize endTipsSize = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5 - self.tipsImage.width, 0);
        CGSize endTipsautoSize = [self.endTipsLable  actualSizeOfLable:[NSString stringWithFormat:@"%@",info[@"note"]]
                                                     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/31.25]
                                                     andSize:endTipsSize];
        self.endTipsLable.frame = CGRectMake(self.tipsImage.right  + 5,
                                             self.tipsLable.bottom + SCREEN_WIDTH/37.5,
                                             SCREEN_WIDTH - SCREEN_WIDTH/12.5 - self.tipsImage.width,
                                             endTipsautoSize.height);
        
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.timeLable];
        [self addSubview:self.priceLable];
        [self addSubview:self.contentLable];
        [self addSubview:self.photosView];
        [self addSubview:self.tipsImage];
        [self addSubview:self.tipsLable];
        [self addSubview:self.endTipsLable];
        [self addSubview:self.cancelBtn];
    }
    return self;
}

#pragma maek - getter
- (UILabel *)timeLable {
    
    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                      SCREEN_WIDTH/25,
                                      (SCREEN_WIDTH - SCREEN_WIDTH/12.5)/2,
                                      SCREEN_WIDTH/31.25);
        _timeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _timeLable.textColor = [UIColor colorWithHex:@"999999"];
        _timeLable.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLable;
}

- (UILabel *)priceLable {
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.frame = CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH - SCREEN_WIDTH/12.5)/2 - SCREEN_WIDTH/25,
                                       SCREEN_WIDTH/25,
                                      (SCREEN_WIDTH - SCREEN_WIDTH/12.5)/2,
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
                                         self.timeLable.bottom + SCREEN_WIDTH/37.5,
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

- (UILabel *)endTipsLable {
    
    if (_endTipsLable == nil) {
        _endTipsLable = [[UILabel alloc] init];
        _endTipsLable.frame = CGRectMake(self.tipsImage.right + 5,
                                         self.tipsLable.bottom + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/12.5 - self.tipsImage.width,
                                         0);
        _endTipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _endTipsLable.textColor = [UIColor colorWithHex:@"f47373"];
    }
    return _endTipsLable;
}

- (UIButton *)cancelBtn {

    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_cancelBtn setTitle:@"撤销" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
        _cancelBtn.layer.cornerRadius = 3;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.borderColor = [UIColor colorWithHex:tonalColor].CGColor;
        _cancelBtn.layer.borderWidth = 0.5;
        [_cancelBtn setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:_cancelBtn.frame.size] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_cancelBtn.frame.size] forState:UIControlStateHighlighted];
        _cancelBtn.alpha = 0;
    }
    _cancelBtn.frame = CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/6.25 - SCREEN_WIDTH/25,
                                  self.contentLable.bottom,
                                  SCREEN_WIDTH/6.25,
                                  SCREEN_WIDTH/13.6);
    return _cancelBtn;
}



@end
