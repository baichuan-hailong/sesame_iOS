//
//  ZMAllUnderStandAnswerCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/18.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderStandAnswerCell.h"

@implementation ZMAllUnderStandAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithDic:(NSDictionary *)info {

    //...
    if (info != nil) {
    
        /** 头像 */
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",info[@"user"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        
        /** 昵称 */
        CGSize Nicksize = CGSizeMake(0, SCREEN_WIDTH/28.85);
        CGSize NickautoSize = [self.nickNameLable actualSizeOfLable:[NSString stringWithFormat:@"%@",info[@"user"][@"person_name"]]
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3] andSize:Nicksize];
        self.nickNameLable.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/37.5,
                                              self.avatarImage.top,
                                              NickautoSize.width,
                                              SCREEN_WIDTH/28.85);
        
        /** 公司职位 */
        NSString *companyStr;
        if (![[NSString stringWithFormat:@"%@",info[@"user"][@"corp_name"]] isEqualToString:@""] &&
            ![[NSString stringWithFormat:@"%@",info[@"user"][@"title"]] isEqualToString:@""]) {
            companyStr = [NSString stringWithFormat:@"%@ | %@",info[@"user"][@"corp_name"],info[@"user"][@"title"]];
        } else if ([[NSString stringWithFormat:@"%@",info[@"user"][@"corp_name"]] isEqualToString:@""] &&
                   [[NSString stringWithFormat:@"%@",info[@"user"][@"title"]] isEqualToString:@""]) {
            //companyStr = @"暂无企业和职位信息";
            companyStr = @"";
        } else {
            companyStr = [NSString stringWithFormat:@"%@%@",info[@"user"][@"corp_name"],info[@"user"][@"title"]];
        }
        self.companyLable.text = companyStr;
        
        
        self.timeLable.text = [NSString stringWithFormat:@"%@ 回答",[toolClass changeTime:[info[@"time"] stringValue]]];
        
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
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        if ([[NSString stringWithFormat:@"%@",info[@"is_show_answer"]] isEqualToString:@"1"]) {
            /** 可见答案 */
            if ([[NSString stringWithFormat:@"%@",info[@"audio"]] isEqualToString:@""]) {
                /** 文字回答 */
                CGSize   size = CGSizeMake(SCREEN_WIDTH - self.avatarImage.width - SCREEN_WIDTH/4.86, MAXFLOAT);
                CGSize   autoSize = [self.contentLable actualSizeOfLable:[NSString stringWithFormat:@"%@",info[@"answer"]]
                                                                 andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85]
                                                                 andSize:size];
                
//                NSString *content = [NSString stringWithFormat:@"%@",info[@"answer"]];
//                self.contentLable.text = content;
//                CGSize titleSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85]} context:nil].size;

                
                self.contentLable.alpha = 1;
                self.voiceView.alpha    = 0;
                self.contentLable.frame = CGRectMake(self.avatarImage.right  + SCREEN_WIDTH/37.5,
                                                     self.avatarImage.bottom + SCREEN_WIDTH/62.5,
                                                     SCREEN_WIDTH - self.avatarImage.width - SCREEN_WIDTH/4.86,
                                                     autoSize.height);
                
                /* 赏金 */
                if (![[NSString stringWithFormat:@"%@",info[@"reward"]] isEqualToString:@"0"]) {
                    self.priceLable.frame = CGRectMake(self.avatarImage.right  + SCREEN_WIDTH/37.5,
                                                       self.contentLable.bottom + SCREEN_WIDTH/37.5,
                                                       SCREEN_WIDTH - self.avatarImage.width - SCREEN_WIDTH/9.375,
                                                       SCREEN_WIDTH/28.85);
                } else {
                    self.priceLable.frame = CGRectMake(0,0,0,0);
                }
                
            } else {
                /** 语音回答 */
                self.contentLable.alpha = 0;
                self.voiceView.alpha = 1;
                self.secondLable.text = [NSString stringWithFormat:@"%@″",info[@"audio_time"]];
                
                /* 赏金 */
                if (![[NSString stringWithFormat:@"%@",info[@"reward"]] isEqualToString:@"0"]) {
                    self.priceLable.frame = CGRectMake(self.avatarImage.right  + SCREEN_WIDTH/37.5,
                                                       self.voiceView.bottom + SCREEN_WIDTH/37.5,
                                                       SCREEN_WIDTH - self.avatarImage.width - SCREEN_WIDTH/9.375,
                                                       SCREEN_WIDTH/28.85);
                } else {
                    self.priceLable.frame = CGRectMake(0,0,0,0);
                }
            }
            
        } else {
            /** 不可见答案 */
            self.contentLable.alpha = 0;
            self.voiceView.alpha = 0;
            
            /* 赏金 */
            if (![[NSString stringWithFormat:@"%@",info[@"reward"]] isEqualToString:@"0"]) {
                self.priceLable.frame = CGRectMake(self.avatarImage.right  + SCREEN_WIDTH/37.5,
                                                   self.avatarImage.bottom + SCREEN_WIDTH/37.5,
                                                   SCREEN_WIDTH - self.avatarImage.width - SCREEN_WIDTH/9.375,
                                                   SCREEN_WIDTH/28.85);
            } else {
                self.priceLable.frame = CGRectMake(0,0,0,0);
            }
        }

        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"获得赏金 ¥%@",info[@"reward"]]];
        [cerStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"333333"] range:NSMakeRange(0,4)];
        self.priceLable.attributedText = cerStr;
        
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
        [self addSubview:self.timeLable];
        [self addSubview:self.companyLable];
        
        [self addSubview:self.contentLable];
        [self addSubview:self.voiceView];
        [self.voiceView addSubview:self.voiceBtn];
        [self.voiceView addSubview:self.secondLable];
        [self addSubview:self.priceLable];
        [self addSubview:self.getBtn];
    }
    return self;
}

#pragma maek - getter
- (UIImageView *)avatarImage {
    
    if (_avatarImage == nil) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.frame = CGRectMake(SCREEN_WIDTH/25, SCREEN_WIDTH/37.5, SCREEN_WIDTH/10.7, SCREEN_WIDTH/10.7);
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

- (UILabel *)timeLable {
    
    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.frame = CGRectMake(SCREEN_WIDTH - 150 - SCREEN_WIDTH/25,
                                      self.avatarImage.top,
                                      150,
                                      SCREEN_WIDTH/37.5);
        _timeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/37.5];
        _timeLable.textColor = [UIColor colorWithHex:@"999999"];
        _timeLable.textAlignment = NSTextAlignmentRight;
    }
    return _timeLable;
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

/** voiceView */
- (UIView *)voiceView {

    if (_voiceView == nil) {
        _voiceView = [[UIView alloc] init];
        _voiceView.frame = CGRectMake(self.avatarImage.right + SCREEN_WIDTH/37.5,
                                      self.avatarImage.bottom,
                                      SCREEN_WIDTH/2,
                                      SCREEN_WIDTH/8.15);
    }
    return _voiceView;
}

- (UIButton *)voiceBtn {

    if (_voiceBtn == nil) {
        _voiceBtn = [[UIButton alloc] init];
        _voiceBtn.frame = CGRectMake(0, SCREEN_WIDTH/62.5, SCREEN_WIDTH/3.26, SCREEN_WIDTH/9.375);
        _voiceBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
        _voiceBtn.layer.cornerRadius = (SCREEN_WIDTH/9.375)/2;
        
        
        //语音图片
        UIImage     *voiceImg     = [UIImage imageNamed:@"au_voice"];
        UIImageView *voiceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/31.25,
                                                                                 (_voiceBtn.height - voiceImg.size.height)/2,
                                                                                  voiceImg.size.width,
                                                                                  voiceImg.size.height)];
        voiceImgView.image = voiceImg;
        
        //loading
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/62.5,
                                                                                                              (_voiceBtn.height - 30)/2,
                                                                                                               30,
                                                                                                               30)];

        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        activityIndicator.alpha = 0;
        [activityIndicator startAnimating];
        
        //playGif
        UIImageView *gifImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/31.25,
                                                                             (_voiceBtn.height - voiceImg.size.height)/2,
                                                                              voiceImg.size.width,
                                                                              voiceImg.size.height)];
        NSURL * url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"play.gif" ofType:nil]];
        [gifImage yh_setImage:url];
        gifImage.alpha = 0;
        
        //tipsLable
        UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(_voiceBtn.width - SCREEN_WIDTH/6.25 - SCREEN_WIDTH/25,
                                                                      (_voiceBtn.height - SCREEN_WIDTH/26.78)/2,
                                                                       SCREEN_WIDTH/6.25,
                                                                       SCREEN_WIDTH/26.78)];
        tipsLable.textColor = [UIColor whiteColor];
        tipsLable.textAlignment = NSTextAlignmentRight;
        tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tipsLable.text = @"免费收听";
        
        [_voiceBtn addSubview:voiceImgView];
        [_voiceBtn addSubview:activityIndicator];
        [_voiceBtn addSubview:gifImage];
        [_voiceBtn addSubview:tipsLable];
        
    }
    return _voiceBtn;
}

- (UILabel *)secondLable {

    if (_secondLable == nil) {
        _secondLable = [[UILabel alloc] init];
        _secondLable.frame = CGRectMake(self.voiceBtn.right + SCREEN_WIDTH/37.5,
                                        self.voiceBtn.centerY - (SCREEN_WIDTH/26.78)/2,
                                        36,
                                        SCREEN_WIDTH/26.78);
        _secondLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _secondLable.textColor = [UIColor colorWithHex:@"999999"];
    }
    return _secondLable;
}



- (UILabel *)contentLable {
    
    if (_contentLable == nil) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _contentLable.textColor = [UIColor colorWithHex:@"333333"];
        _contentLable.numberOfLines = 0;
        _contentLable.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLable;
}

- (UILabel *)priceLable {
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _priceLable.textColor = [UIColor colorWithHex:@"eb6d62"];
    }
    return _priceLable;
}

- (UIButton *)getBtn {

    if (_getBtn == nil) {
        _getBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/6.25,
                                                             SCREEN_WIDTH/12.5,
                                                             SCREEN_WIDTH/6.25,
                                                             SCREEN_WIDTH/6.25)];
        
        UIImage *img = [UIImage imageNamed:@"symbol_noSelect"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_getBtn.width - img.size.width)/2,
                                                                            (_getBtn.height - img.size.height)/2,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        [_getBtn addSubview:imgView];
        _getBtn.alpha = 0;
    }
    return _getBtn;
}



@end
