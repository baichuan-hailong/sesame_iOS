//
//  ZMAgentDetailView.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentDetailView.h"

@implementation ZMAgentDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor colorWithHex:backColor];
    [self addSubview:self.mainScrollerView];
    [self.mainScrollerView addSubview:self.topView];
    [self.topView addSubview:self.avatarImage];
    [self.avatarImage addSubview:self.vipImage];
    [self.topView addSubview:self.companyLable];
    [self.topView addSubview:self.creditLable];
    [self.topView addSubview:self.starTipsLable];
    [self.topView addSubview:self.starView];
    [self.topView addSubview:self.tagView];
    
    
    [self.mainScrollerView addSubview:self.footView];
    [self.footView addSubview:self.titleLable];
    [self.footView addSubview:self.tipsImage1];
    [self.footView addSubview:self.cityLable];
    [self.footView addSubview:self.tipsImage2];
    [self.footView addSubview:self.moneyLable];
    [self.footView addSubview:self.tipsImage3];
    [self.footView addSubview:self.connectLable];
    [self.footView addSubview:self.tipsImage4];
    [self.footView addSubview:self.phoneLable];
    [self.footView addSubview:self.detailLable];
    
    
    [self.mainScrollerView addSubview:self.timeView];
    [self.timeView addSubview:self.timeLable];
}


#pragma mark - getter
- (UIScrollView *)mainScrollerView {

    if (_mainScrollerView == nil) {
        _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           64,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT - 64)];
        _mainScrollerView.backgroundColor = [UIColor colorWithHex:backColor];
        _mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 63);
    }
    return _mainScrollerView;
}

/** topView */
- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/37.5, SCREEN_WIDTH, SCREEN_WIDTH/3.32)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIImageView *)avatarImage {

    if (_avatarImage == nil) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                                    (self.topView.frame.size.height - SCREEN_WIDTH/4.69)/2,
                                                                     SCREEN_WIDTH/4.69,
                                                                     SCREEN_WIDTH/4.69)];
        _avatarImage.layer.cornerRadius = (SCREEN_WIDTH/4.69)/2;
        _avatarImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _avatarImage;
}

- (UIImageView *)vipImage {

    if (_vipImage == nil) {
        _vipImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.avatarImage.frame.size.width - SCREEN_WIDTH/20.83 - 5,
                                                                  self.avatarImage.frame.size.height - SCREEN_WIDTH/20.83,
                                                                  SCREEN_WIDTH/20.83,
                                                                  SCREEN_WIDTH/20.83)];
        _vipImage.layer.cornerRadius = (SCREEN_WIDTH/20.83)/2;
        _vipImage.backgroundColor = [UIColor whiteColor];
        _vipImage.image = [UIImage imageNamed:@"agentVip"];
    }
    return _vipImage;
}

- (UILabel *)companyLable {

    if (_companyLable == nil) {
        _companyLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImage.frame) + SCREEN_WIDTH/25,
                                                                  CGRectGetMinY(self.avatarImage.frame),
                                                                  self.topView.frame.size.width - self.avatarImage.frame.size.width - (SCREEN_WIDTH/25) * 3,
                                                                  0)];
        _companyLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3];
        _companyLable.textAlignment = NSTextAlignmentLeft;
        _companyLable.textColor = [UIColor colorWithHex:@"333333"];
        _companyLable.numberOfLines = 2;
    }
    _companyLable.text = @"北京安家万邦传媒科技股份有限公司";
    [_companyLable sizeToFit];
    return _companyLable;
}

- (UILabel *)creditLable {

    if (_creditLable == nil) {
        _creditLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImage.frame) + SCREEN_WIDTH/25,
                                                                 CGRectGetMaxY(self.companyLable.frame) + SCREEN_WIDTH/37.5,
                                                                 self.companyLable.frame.size.width/2,
                                                                 SCREEN_WIDTH/31.25)];
        _creditLable.font = [UIFont fontWithName:@"Futura-Medium" size:SCREEN_WIDTH/31.25];
        _creditLable.textAlignment = NSTextAlignmentLeft;
        _creditLable.textColor = [UIColor colorWithHex:@"666666"];
    }
    NSMutableAttributedString *tmpStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"信用：92.3分"]];
    [tmpStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:tonalColor] range:NSMakeRange(3, tmpStr.length-3)];
    _creditLable.attributedText = tmpStr;
    
    return _creditLable;
}

- (UILabel *)starTipsLable {
    
    if (_starTipsLable == nil) {
        _starTipsLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.creditLable.frame),
                                                                   CGRectGetMaxY(self.companyLable.frame) + SCREEN_WIDTH/37.5,
                                                                   (SCREEN_WIDTH/31.25) * 3,
                                                                   SCREEN_WIDTH/31.25)];
        _starTipsLable.font = [UIFont fontWithName:@"Futura-Medium" size:SCREEN_WIDTH/31.25];
        _starTipsLable.textAlignment = NSTextAlignmentLeft;
        _starTipsLable.textColor = [UIColor colorWithHex:@"666666"];
        _starTipsLable.text = @"口碑：";
    }
    return _starTipsLable;
}

- (UIView *)starView {

    if (_starView == nil) {
        _starView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starTipsLable.frame),
                                                             CGRectGetMaxY(self.companyLable.frame) + SCREEN_WIDTH/37.5,
                                                             76,
                                                             12)];
        _starView.backgroundColor = [UIColor yellowColor];
    }
    return _starView;
}

/** 标签 */
- (TTGTextTagCollectionView *)tagView {
    
    if (_tagView == nil) {
        _tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImage.frame) + SCREEN_WIDTH/25,
                                                                              CGRectGetMaxY(self.starTipsLable.frame) + SCREEN_WIDTH/37.5,
                                                                              self.topView.frame.size.width - self.avatarImage.frame.size.width - (SCREEN_WIDTH/25) * 3,
                                                                              self.topView.frame.size.height - CGRectGetMaxY(self.starTipsLable.frame) - SCREEN_WIDTH/37.5)];
        
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
        
        [_tagView addTags:@[@"策划", @"顾问", @"广告媒体资源", @"公关活动", @"室内设计装饰", @"建筑工程施工", @"活动"]];
    }
    return _tagView;
}






/** footView */
- (UIView *)footView {

    if (_footView == nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + SCREEN_WIDTH/37.5, SCREEN_WIDTH, SCREEN_WIDTH/2.4)];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}

- (UILabel *)titleLable {

    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                                SCREEN_WIDTH/25,
                                                                self.topView.frame.size.width - (SCREEN_WIDTH/25) * 2,
                                                                0)];
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:3];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHex:@"333333"];
        _titleLable.numberOfLines = 2;
    }
    _titleLable.text = @"新楼盘寻找自媒体推广";
    [_titleLable sizeToFit];
    return _titleLable;
}

- (UIImageView *)tipsImage1 {

    if (_tipsImage1 == nil) {
        UIImage *img = [UIImage imageNamed:@"agentArea"];
        _tipsImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                                    CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/37.5,
                                                                    img.size.width,
                                                                    img.size.height)];
        _tipsImage1.image = img;
        
    }
    return _tipsImage1;
}

- (UILabel *)cityLable {

    if (_cityLable == nil) {
        _cityLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipsImage1.frame) + 5,
                                                               CGRectGetMinY(self.tipsImage1.frame),
                                                               SCREEN_WIDTH/2.5,
                                                                SCREEN_WIDTH/28.85)];
        _cityLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _cityLable.textAlignment = NSTextAlignmentLeft;
        _cityLable.textColor = [UIColor colorWithHex:@"666666"];
        _cityLable.text = @"区域：北京";
    }
    return _cityLable;
}

- (UIImageView *)tipsImage2 {
    
    if (_tipsImage2 == nil) {
        UIImage *img = [UIImage imageNamed:@"agentPrice"];
        _tipsImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,
                                                                    CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/37.5,
                                                                    img.size.width,
                                                                    img.size.height)];
        _tipsImage2.image = img;
    }
    return _tipsImage2;
}

- (UILabel *)moneyLable {
    
    if (_moneyLable == nil) {
        _moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipsImage2.frame) + 5,
                                                                CGRectGetMinY(self.tipsImage2.frame),
                                                                SCREEN_WIDTH/2.5,
                                                                SCREEN_WIDTH/28.85)];
        _moneyLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _moneyLable.textAlignment = NSTextAlignmentLeft;
        _moneyLable.textColor = [UIColor colorWithHex:@"666666"];
        _moneyLable.text = @"佣金：5%";
    }
    return _moneyLable;
}

- (UIImageView *)tipsImage3 {
    
    if (_tipsImage3 == nil) {
        UIImage *img = [UIImage imageNamed:@"agentConnect"];
        _tipsImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                                    CGRectGetMaxY(self.tipsImage1.frame) + SCREEN_WIDTH/28.85,
                                                                    img.size.width,
                                                                    img.size.height)];
        _tipsImage3.image = img;
    }
    return _tipsImage3;
}

- (UILabel *)connectLable {
    
    if (_connectLable == nil) {
        _connectLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipsImage3.frame) + 5,
                                                                  CGRectGetMinY(self.tipsImage3.frame),
                                                                  SCREEN_WIDTH/2.5,
                                                                  SCREEN_WIDTH/28.85)];
        _connectLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _connectLable.textAlignment = NSTextAlignmentLeft;
        _connectLable.textColor = [UIColor colorWithHex:@"666666"];
        _connectLable.text = @"联系人：刘阿飞";
    }
    return _connectLable;
}

- (UIImageView *)tipsImage4 {
    
    if (_tipsImage4 == nil) {
        UIImage *img = [UIImage imageNamed:@"agentPhone"];
        _tipsImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 1,
                                                                    CGRectGetMaxY(self.tipsImage1.frame) + SCREEN_WIDTH/28.85,
                                                                    img.size.width,
                                                                    img.size.height)];
        _tipsImage4.image = img;
    }
    return _tipsImage4;
}

- (UILabel *)phoneLable {
    
    if (_phoneLable == nil) {
        _phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipsImage4.frame) + 5,
                                                                CGRectGetMinY(self.tipsImage4.frame),
                                                                SCREEN_WIDTH/2.5,
                                                                SCREEN_WIDTH/28.85)];
        _phoneLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _phoneLable.textAlignment = NSTextAlignmentLeft;
        _phoneLable.textColor = [UIColor colorWithHex:@"666666"];
        _phoneLable.text = @"电话：18801018989";
    }
    return _phoneLable;
}

- (UILabel *)detailLable {
    
    if (_detailLable == nil) {
        _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                                 CGRectGetMaxY(self.connectLable.frame) + SCREEN_WIDTH/25,
                                                                 self.topView.frame.size.width - (SCREEN_WIDTH/25) * 2,
                                                                 0)];
        _detailLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.textColor = [UIColor colorWithHex:@"666666"];
        _detailLable.numberOfLines = 2;
    }
    _detailLable.text = @"随着市场需求不断增涨，预计在未来的3年内，我爱我家将至少再发展10余个城市，在不断的发展和壮大中";
    [_detailLable sizeToFit];
    return _detailLable;
}






/** timeView */
- (UIView *)timeView {

    if (_timeView == nil) {
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.footView.frame) + 1, SCREEN_WIDTH, SCREEN_WIDTH/8.9)];
        _timeView.backgroundColor = [UIColor whiteColor];
    }
    return _timeView;
}

- (UILabel *)timeLable {

    if (_timeLable == nil) {
     
        _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                              (self.timeView.frame.size.height - SCREEN_WIDTH/28.85)/2,
                                                               self.topView.frame.size.width - (SCREEN_WIDTH/25) * 2,
                                                               SCREEN_WIDTH/28.85)];
        _timeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _timeLable.textAlignment = NSTextAlignmentLeft;
        _timeLable.textColor = [UIColor colorWithHex:@"666666"];
        _timeLable.text = @"发布日期：2016-12-12";
    }
    return _timeLable;
}



@end
