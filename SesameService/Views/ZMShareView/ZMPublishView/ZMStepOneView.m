//
//  ZMStepOneView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMStepOneView.h"

@implementation ZMStepOneView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.mainScrollerView];
    [self addSubview:self.topLable];
    
    [self.mainScrollerView addSubview:self.projectNameLable];
    [self.mainScrollerView addSubview:self.projectNameText];
    [self.mainScrollerView addSubview:self.priceLable];
    [self.mainScrollerView addSubview:self.priceText];
    [self.mainScrollerView addSubview:self.cityLable];
    [self.mainScrollerView addSubview:self.cityText];
    [self.mainScrollerView addSubview:self.projectTypeLable];
    [self.mainScrollerView addSubview:self.projectTypeText];
    
    [self.mainScrollerView addSubview:self.choiceLable];
    [self.mainScrollerView addSubview:self.tagBackView];
    [self.tagBackView addSubview:self.tagView];
    
    [self.mainScrollerView addSubview:self.projectDescribeLable];
    [self.mainScrollerView addSubview:self.projectDescribeTextView];
    [self.mainScrollerView addSubview:self.nextBtn];
    
    
    self.mainScrollerView.delaysContentTouches = NO;
    for (UIView *currentView in self.mainScrollerView.subviews) {

        if([currentView isKindOfClass:[UIScrollView class]]) {

            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }
    }
    
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.nextBtn.frame) + 20);
}


#pragma mark - getter
- (UIScrollView *)mainScrollerView {

    if (_mainScrollerView == nil) {
        _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           64 + SCREEN_WIDTH/12.5,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT - 64 - SCREEN_WIDTH/12.5)];
        _mainScrollerView.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollerView;
}

- (UILabel *)topLable {

    if (_topLable == nil) {
        _topLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH/12.5)];
        _topLable.backgroundColor = [UIColor colorWithHex:@"efeff4"];
        _topLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _topLable.textColor = [UIColor colorWithHex:@"5f5f61"];
        _topLable.textAlignment = NSTextAlignmentCenter;
        _topLable.text = @"第一步：填写项目信息";
        
        [_topLable.layer setShadowOffset:CGSizeMake(1, 1)];
        [_topLable.layer setShadowRadius:1];
        [_topLable.layer setShadowOpacity:0.2];
        [_topLable.layer setShadowColor:[UIColor blackColor].CGColor];
    }
    return _topLable;
}

/** 项目名称 */
- (UILabel *)projectNameLable {
    
    if (_projectNameLable == nil) {
        _projectNameLable = [[UILabel alloc] init];
        _projectNameLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                             SCREEN_WIDTH/18.75,
                                             SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                             SCREEN_WIDTH/26.78);
        _projectNameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectNameLable.textAlignment = NSTextAlignmentLeft;
        _projectNameLable.textColor = [UIColor colorWithHex:@"333333"];
        _projectNameLable.text = @"项目名称";
    }
    return _projectNameLable;
}

- (UITextField *)projectNameText {

    if (_projectNameText == nil) {
        _projectNameText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                         CGRectGetMaxY(self.projectNameLable.frame) + SCREEN_WIDTH/37.5,
                                                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                         SCREEN_WIDTH/9.375)];
        _projectNameText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectNameText.layer.borderWidth  = 1;
        _projectNameText.layer.cornerRadius = 4;
        _projectNameText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _projectNameText.placeholder = @"输入项目名称，如：旅游地产项目策划";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectNameText.leftView = paddingView;
        _projectNameText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectNameText;
}


/** 合同金额 */
- (UILabel *)priceLable {
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.projectNameText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78);
        _priceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.textColor = [UIColor colorWithHex:@"333333"];
        _priceLable.text = @"合同金额";
    }
    return _priceLable;
}

- (UITextField *)priceText {
    
    if (_priceText == nil) {
        _priceText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                   CGRectGetMaxY(self.priceLable.frame) + SCREEN_WIDTH/37.5,
                                                                   SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                   SCREEN_WIDTH/9.375)];
        _priceText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _priceText.layer.borderWidth  = 1;
        _priceText.layer.cornerRadius = 4;
        _priceText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _priceText.placeholder = @"合同金额";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _priceText.leftView = paddingView;
        _priceText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _priceText;
}


/** 所在城市 */
- (UILabel *)cityLable {
    
    if (_cityLable == nil) {
        _cityLable = [[UILabel alloc] init];
        _cityLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.priceText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78);
        _cityLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _cityLable.textAlignment = NSTextAlignmentLeft;
        _cityLable.textColor = [UIColor colorWithHex:@"333333"];
        _cityLable.text = @"所在城市";
    }
    return _cityLable;
}

- (UITextField *)cityText {
    
    if (_cityText == nil) {
        _cityText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                   CGRectGetMaxY(self.cityLable.frame) + SCREEN_WIDTH/37.5,
                                                                   SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                   SCREEN_WIDTH/9.375)];
        _cityText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _cityText.layer.borderWidth  = 1;
        _cityText.layer.cornerRadius = 4;
        _cityText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _cityText.placeholder = @"所在城市";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _cityText.leftView = paddingView;
        _cityText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _cityText;
}


/** 选择业务类型 */
- (UILabel *)projectTypeLable {
    
    if (_projectTypeLable == nil) {
        _projectTypeLable = [[UILabel alloc] init];
        _projectTypeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                             CGRectGetMaxY(self.cityText.frame) + SCREEN_WIDTH/37.5,
                                             SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                             SCREEN_WIDTH/26.78);
        _projectTypeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectTypeLable.textAlignment = NSTextAlignmentLeft;
        _projectTypeLable.textColor = [UIColor colorWithHex:@"333333"];
        _projectTypeLable.text = @"选择业务类型";
    }
    return _projectTypeLable;
}

- (UITextField *)projectTypeText {
    
    if (_projectTypeText == nil) {
        _projectTypeText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                         CGRectGetMaxY(self.projectTypeLable.frame) + SCREEN_WIDTH/37.5,
                                                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                         SCREEN_WIDTH/9.375)];
        _projectTypeText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectTypeText.layer.borderWidth  = 1;
        _projectTypeText.layer.cornerRadius = 4;
        _projectTypeText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _projectTypeText.placeholder = @"选择业务类型";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectTypeText.leftView = paddingView;
        _projectTypeText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectTypeText;
}


/** 标签选择 */
- (UILabel *)choiceLable {
    
    if (_choiceLable == nil) {
        _choiceLable = [[UILabel alloc] init];
        _choiceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                        CGRectGetMaxY(self.projectTypeText.frame) + SCREEN_WIDTH/18.75,
                                        SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                        SCREEN_WIDTH/26.78);
        _choiceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _choiceLable.textAlignment = NSTextAlignmentLeft;
        _choiceLable.textColor = [UIColor colorWithHex:@"333333"];
        _choiceLable.text = @"精准选择，更快被服务商发现";
    }
    return _choiceLable;
}

- (UIView *)tagBackView {

    if (_tagBackView == nil) {
        _tagBackView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                CGRectGetMaxY(self.choiceLable.frame) + SCREEN_WIDTH/17.05,
                                                                SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                SCREEN_WIDTH/2.75)];
        _tagBackView.backgroundColor = [UIColor colorWithHex:backColor];
        _tagBackView.layer.cornerRadius = 6;
    }
    return _tagBackView;
}

- (TTGTextTagCollectionView *)tagView {
    
    if (_tagView == nil) {
        _tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/31.25,
                                                                              SCREEN_WIDTH/31.25,
                                                                              self.tagBackView.frame.size.width  - SCREEN_WIDTH/15.625,
                                                                              self.tagBackView.frame.size.height - SCREEN_WIDTH/15.625)];
        
        /** config */
        _tagView.defaultConfig.tagTextFont          = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tagView.defaultConfig.tagTextColor         = [UIColor colorWithHex:@"999999"];
        _tagView.defaultConfig.tagSelectedTextColor = [UIColor colorWithHex:@"ffffff"];
        _tagView.defaultConfig.tagBackgroundColor   = [UIColor whiteColor];
        _tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithHex:tonalColor];
        _tagView.defaultConfig.tagCornerRadius      = 4;
        _tagView.defaultConfig.tagSelectedCornerRadius = 4;
        _tagView.defaultConfig.tagBorderWidth       = 0.5;
        _tagView.defaultConfig.tagSelectedBorderWidth = 0.5;
        _tagView.defaultConfig.tagBorderColor       = [UIColor colorWithHex:@"999999"];
        _tagView.defaultConfig.tagSelectedBorderColor = [UIColor colorWithHex:tonalColor];
        _tagView.defaultConfig.tagShadowColor       = [UIColor whiteColor];
        _tagView.defaultConfig.tagShadowOffset      = CGSizeMake(0, 0);
        _tagView.defaultConfig.tagShadowRadius      = 0;
        _tagView.defaultConfig.tagShadowOpacity     = 0;
        _tagView.defaultConfig.tagExtraSpace        = CGSizeMake(18, 15);
        _tagView.verticalSpacing = SCREEN_WIDTH/37.5;
        
        
        [_tagView addTags:@[@"企业咨询", @"策划代理", @"物业管理", @"公关活动", @"广告推广", @"地产评估", @"招标代理", @"金融服务",@"代理土地拍卖",@"地产运营管理"]];
    }
    return _tagView;
}


/** 项目描述 */
- (UILabel *)projectDescribeLable {
    
    if (_projectDescribeLable == nil) {
        _projectDescribeLable = [[UILabel alloc] init];
        _projectDescribeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                                 CGRectGetMaxY(self.tagBackView.frame) + SCREEN_WIDTH/37.5,
                                                 SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                 SCREEN_WIDTH/26.78);
        _projectDescribeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectDescribeLable.textAlignment = NSTextAlignmentLeft;
        _projectDescribeLable.textColor = [UIColor colorWithHex:@"333333"];
        _projectDescribeLable.text = @"项目描述";
    }
    return _projectDescribeLable;
}

- (UITextView *)projectDescribeTextView {

    if (_projectDescribeTextView == nil) {
        _projectDescribeTextView = [[UITextView alloc] init];

        _projectDescribeTextView.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                                    CGRectGetMaxY(self.projectDescribeLable.frame) + SCREEN_WIDTH/37.5,
                                                    SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                    SCREEN_WIDTH/2.35);
        _projectDescribeTextView.backgroundColor = [UIColor whiteColor];
        _projectDescribeTextView.layer.cornerRadius = 4;
        _projectDescribeTextView.layer.borderColor = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectDescribeTextView.layer.borderWidth = 1;
        _projectDescribeTextView.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];//设置字体名字和字体大小
        
        _projectDescribeTextView.keyboardType = UIKeyboardTypeDefault; //键盘类型
        _projectDescribeTextView.scrollEnabled = YES; //是否可以拖动
    }
    return _projectDescribeTextView;
}


/** 下一步 */
- (UIButton *)nextBtn {
    
    if (_nextBtn == nil) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                              CGRectGetMaxY(self.projectDescribeTextView.frame) + SCREEN_WIDTH/18.75,
                                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                              SCREEN_WIDTH/9.375)];
        [_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 4;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_nextBtn.frame.size] forState:UIControlStateNormal];
    }
    return _nextBtn;
}



@end
