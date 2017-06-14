//
//  ZMInfoMoneyView.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/4.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInfoMoneyView.h"

@implementation ZMInfoMoneyView

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
    
    /** 项目信息 */
    [self.mainScrollerView addSubview:self.projectNameLable];
    [self.mainScrollerView addSubview:self.projectNameText];
    [self.mainScrollerView addSubview:self.cityLable];
    [self.mainScrollerView addSubview:self.cityText];
    [self.mainScrollerView addSubview:self.projectType];
    [self.mainScrollerView addSubview:self.projectTypeText];
    [self.mainScrollerView addSubview:self.projectPriceLable];
    [self.mainScrollerView addSubview:self.projectPriceText];
    [self.mainScrollerView addSubview:self.tipsLable1];
    [self.mainScrollerView addSubview:self.expireTimeLable];
    [self.mainScrollerView addSubview:self.expireTimeText];
    
    /** 甲方联系人 */
    [self.mainScrollerView addSubview:self.titleViewLable];
    [self.mainScrollerView addSubview:self.nameLable];
    [self.mainScrollerView addSubview:self.nameText];
    [self.mainScrollerView addSubview:self.positionLable];
    [self.mainScrollerView addSubview:self.positionText];
    [self.mainScrollerView addSubview:self.telLable];
    [self.mainScrollerView addSubview:self.telText];
    [self.mainScrollerView addSubview:self.tipsLable2];
    
    /** 项目说明 */
    [self.mainScrollerView addSubview:self.titleView2];
    [self.mainScrollerView addSubview:self.projectDescribeLable];
    [self.mainScrollerView addSubview:self.projectDescribeTextView];
    [self.mainScrollerView addSubview:self.worldCountLabel];
    [self.mainScrollerView addSubview:self.supportLable];
    [self.mainScrollerView addSubview:self.supportText];
    [self.mainScrollerView addSubview:self.tipsLable3];
    
    /** 发布信息 */
    [self.mainScrollerView addSubview:self.titleView3];
    [self.mainScrollerView addSubview:self.basePriceTips];
    [self.mainScrollerView addSubview:self.basePriceLable];
    [self.mainScrollerView addSubview:self.tipsLable4];
    [self.mainScrollerView addSubview:self.choiceBtn];
    [self.mainScrollerView addSubview:self.nextBtn];
    
    /** 选择器 */
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.infoPicker];
    [self.pickerView addSubview:self.confirmBtn];
    [self.pickerView addSubview:self.cancelBtn];
    
    /** 时间选择器 */
    [self addSubview:self.timeView];
    [self.timeView addSubview:self.datePicker];
    [self.timeView addSubview:self.timeConfirmBtn];
    [self.timeView addSubview:self.timeCancelBtn];
    
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
                                                                           64,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT - 64)];
        _mainScrollerView.backgroundColor = [UIColor whiteColor];
        _mainScrollerView.panGestureRecognizer.delaysTouchesBegan = YES;
    }
    return _mainScrollerView;
}


#pragma mark - 项目信息
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
        _projectNameText.tag = 1;
        _projectNameText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectNameText.layer.borderWidth  = 1;
        _projectNameText.layer.cornerRadius = 4;
        _projectNameText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _projectNameText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectNameText.leftView = paddingView;
        _projectNameText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectNameText;
}

/** 业务区域 */
- (UILabel *)cityLable {
    
    if (_cityLable == nil) {
        _cityLable = [[UILabel alloc] init];
        _cityLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      CGRectGetMaxY(self.projectNameText.frame) + SCREEN_WIDTH/37.5,
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
        _cityText.placeholder = @"请选择";
        _cityText.tag = 9;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _cityText.leftView = paddingView;
        _cityText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _cityText;
}


/** 项目类型 */
- (UILabel *)projectType {
    
    if (_projectType == nil) {
        _projectType = [[UILabel alloc] init];
        _projectType.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                        CGRectGetMaxY(self.cityText.frame) + SCREEN_WIDTH/37.5,
                                        SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                        SCREEN_WIDTH/26.78);
        _projectType.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectType.textAlignment = NSTextAlignmentLeft;
        _projectType.textColor = [UIColor colorWithHex:@"333333"];
        _projectType.text = @"项目类型";
    }
    return _projectType;
}

- (UITextField *)projectTypeText {
    
    if (_projectTypeText == nil) {
        _projectTypeText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                         CGRectGetMaxY(self.projectType.frame) + SCREEN_WIDTH/37.5,
                                                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                         SCREEN_WIDTH/9.375)];
        _projectTypeText.tag = 2;
        _projectTypeText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectTypeText.layer.borderWidth  = 1;
        _projectTypeText.layer.cornerRadius = 4;
        _projectTypeText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _projectTypeText.placeholder = @"请选择";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectTypeText.leftView = paddingView;
        _projectTypeText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectTypeText;
}


/** 预估项目标的额 */
- (UILabel *)projectPriceLable {
    
    if (_projectPriceLable == nil) {
        _projectPriceLable = [[UILabel alloc] init];
        _projectPriceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                              CGRectGetMaxY(self.projectTypeText.frame) + SCREEN_WIDTH/37.5,
                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                              SCREEN_WIDTH/26.78);
        _projectPriceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectPriceLable.textAlignment = NSTextAlignmentLeft;
        _projectPriceLable.textColor = [UIColor colorWithHex:@"333333"];
        _projectPriceLable.text = @"预计标的额";
    }
    return _projectPriceLable;
}

- (UITextField *)projectPriceText {
    
    if (_projectPriceText == nil) {
        _projectPriceText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                          CGRectGetMaxY(self.projectPriceLable.frame) + SCREEN_WIDTH/37.5,
                                                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                          SCREEN_WIDTH/9.375)];
        _projectPriceText.tag = 3;
        _projectPriceText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectPriceText.layer.borderWidth  = 1;
        _projectPriceText.layer.cornerRadius = 4;
        _projectPriceText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _projectPriceText.placeholder = @"请选择";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectPriceText.leftView = paddingView;
        _projectPriceText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectPriceText;
}


- (UILabel *)tipsLable1 {
    
    if (_tipsLable1 == nil) {
        _tipsLable1 = [[UILabel alloc] init];
        _tipsLable1.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.projectPriceText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/31.25);
        _tipsLable1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable1.textAlignment = NSTextAlignmentLeft;
        _tipsLable1.textColor = [UIColor colorWithHex:@"a5a5a5"];
        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* 不同标的额对应的信息费不同，请您务必如实选择并保证可以提供相应的支持，以免带来不必要的纠纷。"]];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"fa4a4a"] range:NSMakeRange(0,1)];
        _tipsLable1.attributedText = cerStr;
        
        _tipsLable1.numberOfLines = 0;
        [_tipsLable1 sizeToFit];
    }
    return _tipsLable1;
}

/** 消息有效期 */
- (UILabel *)expireTimeLable {
    
    if (_expireTimeLable == nil) {
        _expireTimeLable = [[UILabel alloc] init];
        _expireTimeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      CGRectGetMaxY(self.tipsLable1.frame) + SCREEN_WIDTH/37.5,
                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                      SCREEN_WIDTH/26.78);
        _expireTimeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _expireTimeLable.textAlignment = NSTextAlignmentLeft;
        _expireTimeLable.textColor = [UIColor colorWithHex:@"333333"];
        _expireTimeLable.text = @"消息有效期";
    }
    return _expireTimeLable;
}

- (UITextField *)expireTimeText {
    
    if (_expireTimeText == nil) {
        _expireTimeText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                  CGRectGetMaxY(self.expireTimeLable.frame) + SCREEN_WIDTH/37.5,
                                                                  SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                  SCREEN_WIDTH/9.375)];
        _expireTimeText.tag = 4;
        _expireTimeText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _expireTimeText.layer.borderWidth  = 1;
        _expireTimeText.layer.cornerRadius = 4;
        _expireTimeText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _expireTimeText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _expireTimeText.leftView = paddingView;
        _expireTimeText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _expireTimeText;
}


#pragma mark - 甲方联系人
- (UILabel *)titleViewLable {

    if (_titleViewLable == nil) {
        
        _titleViewLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    self.expireTimeText.bottom + SCREEN_WIDTH/20.83,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_WIDTH/20)];
        _titleViewLable.backgroundColor = [UIColor colorWithHex:@"efeff4"];
        _titleViewLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _titleViewLable.textColor = [UIColor colorWithHex:@"666666"];
        _titleViewLable.text = @"      甲方联系人";
    }
    return _titleViewLable;
}

- (UILabel *)nameLable {
    
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      self.titleViewLable.bottom + SCREEN_WIDTH/18.75,
                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                      SCREEN_WIDTH/26.78);
        _nameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.textColor = [UIColor colorWithHex:@"333333"];
        _nameLable.text = @"姓名";
    }
    return _nameLable;
}

- (UITextField *)nameText {
    
    if (_nameText == nil) {
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                  CGRectGetMaxY(self.nameLable.frame) + SCREEN_WIDTH/37.5,
                                                                  SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                  SCREEN_WIDTH/9.375)];
        _nameText.tag = 5;
        _nameText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _nameText.layer.borderWidth  = 1;
        _nameText.layer.cornerRadius = 4;
        _nameText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _nameText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _nameText.leftView = paddingView;
        _nameText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _nameText;
}

- (UILabel *)positionLable {
    
    if (_positionLable == nil) {
        _positionLable = [[UILabel alloc] init];
        _positionLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                          CGRectGetMaxY(self.nameText.frame) + SCREEN_WIDTH/37.5,
                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                          SCREEN_WIDTH/26.78);
        _positionLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _positionLable.textAlignment = NSTextAlignmentLeft;
        _positionLable.textColor = [UIColor colorWithHex:@"333333"];
        _positionLable.text = @"职务";
    }
    return _positionLable;
}

- (UITextField *)positionText {
    
    if (_positionText == nil) {
        _positionText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                         CGRectGetMaxY(self.positionLable.frame) + SCREEN_WIDTH/37.5,
                                                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                         SCREEN_WIDTH/9.375)];
        _positionText.tag = 6;
        _positionText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _positionText.layer.borderWidth  = 1;
        _positionText.layer.cornerRadius = 4;
        _positionText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _positionText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _positionText.leftView = paddingView;
        _positionText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _positionText;
}

- (UILabel *)telLable {
    
    if (_telLable == nil) {
        _telLable = [[UILabel alloc] init];
        _telLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                     CGRectGetMaxY(self.positionText.frame) + SCREEN_WIDTH/37.5,
                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                     SCREEN_WIDTH/26.78);
        _telLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _telLable.textAlignment = NSTextAlignmentLeft;
        _telLable.textColor = [UIColor colorWithHex:@"333333"];
        _telLable.text = @"电话";
    }
    return _telLable;
}

- (UITextField *)telText {
    
    if (_telText == nil) {
        _telText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                 CGRectGetMaxY(self.telLable.frame) + SCREEN_WIDTH/37.5,
                                                                 SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                 SCREEN_WIDTH/9.375)];
        _telText.tag = 7;
        _telText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _telText.layer.borderWidth  = 1;
        _telText.layer.cornerRadius = 4;
        _telText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _telText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _telText.leftView = paddingView;
        _telText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _telText;
}


- (UILabel *)tipsLable2 {
    
    if (_tipsLable2 == nil) {
        _tipsLable2 = [[UILabel alloc] init];
        _tipsLable2.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.telText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/31.25);
        _tipsLable2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable2.textAlignment = NSTextAlignmentLeft;
        _tipsLable2.textColor = [UIColor colorWithHex:@"a5a5a5"];
        
        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* 提交后不会公开显示，仅在信息被购买后提供给购买者。"]];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"fa4a4a"] range:NSMakeRange(0,1)];
        _tipsLable2.attributedText = cerStr;
        
        _tipsLable2.numberOfLines = 0;
        [_tipsLable2 sizeToFit];
    }
    return _tipsLable2;
}





#pragma mark - 项目说明
- (UIView *)titleView2 {
    
    if (_titleView2 == nil) {
        _titleView2 = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               self.tipsLable2.bottom + SCREEN_WIDTH/20.83,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/20)];
        _titleView2.backgroundColor = [UIColor colorWithHex:@"efeff4"];
    }
    return _titleView2 ;
}

/** 项目描述 */
- (UILabel *)projectDescribeLable {
    
    if (_projectDescribeLable == nil) {
        _projectDescribeLable = [[UILabel alloc] init];
        _projectDescribeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                                 CGRectGetMaxY(self.titleView2.frame) + SCREEN_WIDTH/37.5,
                                                 SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                 SCREEN_WIDTH/26.78);
        _projectDescribeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectDescribeLable.textAlignment = NSTextAlignmentLeft;
        _projectDescribeLable.textColor = [UIColor colorWithHex:@"333333"];
        _projectDescribeLable.text = @"项目说明";
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
        
        
        //placeholder
        _placeholderLable=[[UILabel alloc] init];
        _placeholderLable.font  = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _placeholderLable.numberOfLines = 0;
        _placeholderLable.frame = CGRectMake(10, 8, _projectDescribeTextView.frame.size.width - 20, SCREEN_WIDTH/26.78);
        _placeholderLable.text  = @"请填写不少于20字的项目说明，内容将被公开显示，为保证您的权益，请不要填写业主的详细资料";
        _placeholderLable.textColor=[UIColor colorWithHex:@"bbbbbb"];
        [_placeholderLable sizeToFit];
        [_projectDescribeTextView addSubview:_placeholderLable];
    }
    return _projectDescribeTextView;
}

- (UILabel *)worldCountLabel {
    
    if (_worldCountLabel == nil) {
        //字符计数
        _worldCountLabel = [[UILabel alloc] init];
        _worldCountLabel.frame = CGRectMake(self.projectDescribeTextView.right - 100,
                                            self.projectDescribeTextView.bottom + SCREEN_WIDTH/75,
                                            100,
                                            SCREEN_WIDTH/31.25);
        _worldCountLabel.textAlignment = NSTextAlignmentRight;
        _worldCountLabel.text = @"0/300";
        _worldCountLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _worldCountLabel.textColor = [UIColor colorWithHex:@"bbbbbb"];
        [_projectDescribeTextView addSubview:_worldCountLabel];
    }
    return _worldCountLabel;
}


- (UILabel *)supportLable {
    
    if (_supportLable == nil) {
        _supportLable = [[UILabel alloc] init];
        _supportLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                     CGRectGetMaxY(self.worldCountLabel.frame) + SCREEN_WIDTH/37.5,
                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375 - 100,
                                     SCREEN_WIDTH/26.78);
        _supportLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _supportLable.textAlignment = NSTextAlignmentLeft;
        _supportLable.textColor = [UIColor colorWithHex:@"333333"];
        _supportLable.text = @"您可以为信息购买者提供的支持";
    }
    return _supportLable;
}

- (UITextField *)supportText {
    
    if (_supportText == nil) {
        _supportText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                 CGRectGetMaxY(self.supportLable.frame) + SCREEN_WIDTH/37.5,
                                                                 SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                 SCREEN_WIDTH/9.375)];
        _supportText.tag = 8;
        _supportText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _supportText.layer.borderWidth  = 1;
        _supportText.layer.cornerRadius = 4;
        _supportText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _supportText.placeholder = @"请选择";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _supportText.leftView = paddingView;
        _supportText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _supportText;
}


- (UILabel *)tipsLable3 {
    
    if (_tipsLable3 == nil) {
        _tipsLable3 = [[UILabel alloc] init];
        _tipsLable3.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.supportText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/31.25);
        _tipsLable3.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable3.textAlignment = NSTextAlignmentLeft;
        _tipsLable3.textColor = [UIColor colorWithHex:@"a5a5a5"];
        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* 不同支持力度对应的信息费不同，请您务必如实选择并保证可以提供相应的支持，以免带来不必要的纠纷。"]];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"fa4a4a"] range:NSMakeRange(0,1)];
        _tipsLable3.attributedText = cerStr;
        
        _tipsLable3.numberOfLines = 0;
        [_tipsLable3 sizeToFit];
    }
    return _tipsLable3;
}



#pragma mark - 发布信息
- (UIView *)titleView3 {
    
    if (_titleView3 == nil) {
        _titleView3 = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                self.tipsLable3.bottom + SCREEN_WIDTH/20.83,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH/20)];
        _titleView3.backgroundColor = [UIColor colorWithHex:@"efeff4"];
    }
    return _titleView3 ;
}

- (UILabel *)basePriceTips {
    
    if (_basePriceTips == nil) {
        _basePriceTips = [[UILabel alloc] init];
        _basePriceTips.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                           CGRectGetMaxY(self.titleView3.frame) + SCREEN_WIDTH/20.83,
                                           SCREEN_WIDTH/23.43 * 6,
                                           SCREEN_WIDTH/23.43);
        _basePriceTips.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:1];
        _basePriceTips.textAlignment = NSTextAlignmentLeft;
        _basePriceTips.textColor = [UIColor colorWithHex:@"333333"];
        _basePriceTips.text = @"基础信息费 ";
    }
    return _basePriceTips;
}

- (UILabel *)basePriceLable {
    
    if (_basePriceLable == nil) {
        _basePriceLable = [[UILabel alloc] init];
        _basePriceLable.frame = CGRectMake(self.basePriceTips.right,
                                           CGRectGetMaxY(self.titleView3.frame) + SCREEN_WIDTH/20.83,
                                           SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                           SCREEN_WIDTH/23.43);
        _basePriceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:1];
        _basePriceLable.textAlignment = NSTextAlignmentLeft;
        _basePriceLable.textColor = [UIColor colorWithHex:@"fa4a4a"];
        _basePriceLable.text = @"¥100";
    }
    return _basePriceLable;
}
- (UILabel *)tipsLable4 {
    
    if (_tipsLable4 == nil) {
        _tipsLable4 = [[UILabel alloc] init];
        _tipsLable4.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.basePriceLable.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/31.25);
        _tipsLable4.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable4.textAlignment = NSTextAlignmentLeft;
        _tipsLable4.textColor = [UIColor colorWithHex:@"a5a5a5"];
        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* 基础信息费是芝麻商服规定的最低信息售价。\n如果您想要提升信息售价，请在信息发布后继续补充项目资料。"]];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"fa4a4a"] range:NSMakeRange(0,1)];
        _tipsLable4.attributedText = cerStr;
        
        _tipsLable4.numberOfLines = 0;
        [_tipsLable4 sizeToFit];
    }
    return _tipsLable4;
}

- (UIButton *)choiceBtn {
    
    if (_choiceBtn == nil) {
        _choiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                CGRectGetMaxY(self.tipsLable4.frame),
                                                                SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                SCREEN_WIDTH/9.375)];
        _choiceBtn.tag = 1001;
        
        UIImage *img = [UIImage imageNamed:@"symbol_select"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                            (_choiceBtn.height - img.size.height)/2,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + SCREEN_WIDTH/46.875,
                                                                       (_choiceBtn.height - SCREEN_WIDTH/31.25)/2,
                                                                        300,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.text = @"匿名发布";
        
        [_choiceBtn addSubview:imgView];
        [_choiceBtn addSubview:titleLable];
    }
    return _choiceBtn;
}

    
/** 下一步 */
- (UIButton *)nextBtn {
    
    if (_nextBtn == nil) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                              self.choiceBtn.bottom + SCREEN_WIDTH/31.25,
                                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                              SCREEN_WIDTH/9.375)];
        [_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_nextBtn setTitle:@"立即发布" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 4;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_nextBtn.frame.size] forState:UIControlStateNormal];
    }
    return _nextBtn;
}


/** pickerView */
- (UIView *)pickerView {

    if (_pickerView == nil) {
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 240)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
        [_pickerView addSubview:line];
    }
    [self infoPicker];
    return _pickerView;
}

- (UIPickerView *)infoPicker {
    
    if (_infoPicker == nil) {
        _infoPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40 , SCREEN_WIDTH, 200)];
        _infoPicker.backgroundColor = [UIColor whiteColor];
        _infoPicker.layer.masksToBounds = NO;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
        [_infoPicker addSubview:line];
    }
    [_infoPicker reloadAllComponents];
    return _infoPicker;
}

- (UIButton *)confirmBtn {

    if (_confirmBtn == nil) {
        /** 确认 */
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,0,60,40)];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithHex:@"2E6EFA"] forState:UIControlStateNormal];
    }
    return _confirmBtn;
}

- (UIButton *)cancelBtn {
    
    if (_cancelBtn == nil) {
        /** 取消 */
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,60,40)];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:@"2E6EFA"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}



/** 时间选择器 */
/** pickerView */
- (UIView *)timeView {
    
    if (_timeView == nil) {
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 240)];
        _timeView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
        [_timeView addSubview:line];
    }
    return _timeView;
}

- (UIDatePicker *)datePicker {
    
    if (_datePicker == nil) {
        _datePicker = [[ UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
    [_datePicker addSubview:line];
    
    NSDate *minDate = [NSDate date];
    NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60 sinceDate:minDate];
    _datePicker.minimumDate = nextDat;
    return _datePicker;
}

- (UIButton *)timeConfirmBtn {
    
    if (_timeConfirmBtn == nil) {
        /** 确认 */
        _timeConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,0,60,40)];
        [_timeConfirmBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_timeConfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_timeConfirmBtn setTitleColor:[UIColor colorWithHex:@"2E6EFA"] forState:UIControlStateNormal];
    }
    return _timeConfirmBtn;
}

- (UIButton *)timeCancelBtn {
    
    if (_timeCancelBtn == nil) {
        /** 取消 */
        _timeCancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,60,40)];
        [_timeCancelBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_timeCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_timeCancelBtn setTitleColor:[UIColor colorWithHex:@"2E6EFA"] forState:UIControlStateNormal];
    }
    return _timeCancelBtn;
}






@end
