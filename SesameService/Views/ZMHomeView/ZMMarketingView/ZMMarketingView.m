//
//  ZMMarketingView.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/4.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMarketingView.h"

@implementation ZMMarketingView

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
    [self.mainScrollerView addSubview:self.companyLable];
    [self.mainScrollerView addSubview:self.companyText];
    [self.mainScrollerView addSubview:self.tipsLable1];
    [self.mainScrollerView addSubview:self.productLable];
    [self.mainScrollerView addSubview:self.productText];
    [self.mainScrollerView addSubview:self.tipsLable2];
    [self.mainScrollerView addSubview:self.cityLable];
    [self.mainScrollerView addSubview:self.cityText];
    [self.mainScrollerView addSubview:self.projectPriceLable];
    [self.mainScrollerView addSubview:self.projectPriceText];
    
    [self.mainScrollerView addSubview:self.commissionLable];
    [self.mainScrollerView addSubview:self.funcBtn1];
    [self.mainScrollerView addSubview:self.funcBtn2];
    [self.mainScrollerView addSubview:self.funcBtn3];
    [self.mainScrollerView addSubview:self.funcBtn4];
    [self.mainScrollerView addSubview:self.priceLable];
    [self.mainScrollerView addSubview:self.priceText];
    
    [self.mainScrollerView addSubview:self.projectDescribeLable];
    [self.mainScrollerView addSubview:self.projectDescribeTextView];
    [self.mainScrollerView addSubview:self.worldCountLabel];
    [self.mainScrollerView addSubview:self.nextBtn];
    
    /** 选择器 */
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.infoPicker];
    [self.pickerView addSubview:self.confirmBtn];
    [self.pickerView addSubview:self.cancelBtn];
    
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
        _mainScrollerView.panGestureRecognizer.delaysTouchesBegan = YES;
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
        _topLable.text = @"以下信息提交后将由平台客服与您联系，不会公开发布";
        _topLable.clipsToBounds = NO;
        
        _topLable.layer.borderColor = [UIColor colorWithHex:@"bbbbbb"].CGColor;
        _topLable.layer.borderWidth = 0.5;
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
        _projectNameText.placeholder = @"";
        _projectNameText.tag = 1;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectNameText.leftView = paddingView;
        _projectNameText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectNameText;
}


/** 填写您要推介的公司 */
- (UILabel *)companyLable {
    
    if (_companyLable == nil) {
        _companyLable = [[UILabel alloc] init];
        _companyLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.projectNameText.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _companyLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _companyLable.textAlignment = NSTextAlignmentLeft;
        _companyLable.textColor = [UIColor colorWithHex:@"333333"];
        _companyLable.text = @"填写您要推介的公司";
    }
    return _companyLable;
}

- (UITextField *)companyText {
    
    if (_companyText == nil) {
        _companyText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                     CGRectGetMaxY(self.companyLable.frame) + SCREEN_WIDTH/37.5,
                                                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                     SCREEN_WIDTH/9.375)];
        _companyText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _companyText.layer.borderWidth  = 1;
        _companyText.layer.cornerRadius = 4;
        _companyText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _companyText.placeholder = @"";
        _companyText.tag = 2;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _companyText.leftView = paddingView;
        _companyText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _companyText;
}

- (UILabel *)tipsLable1 {
    
    if (_tipsLable1 == nil) {
        _tipsLable1 = [[UILabel alloc] init];
        _tipsLable1.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       self.companyText.bottom + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/31.25);
        _tipsLable1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable1.textAlignment = NSTextAlignmentLeft;
        _tipsLable1.textColor = [UIColor colorWithHex:@"a5a5a5"];
        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* 如果您要推介房产，请填写开发商名称"]];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"fa4a4a"] range:NSMakeRange(0,1)];
        _tipsLable1.attributedText = cerStr;
        
        _tipsLable1.numberOfLines = 0;
        [_tipsLable1 sizeToFit];
    }
    return _tipsLable1;
}


/** 填写业务类型 或 产品名称 */
- (UILabel *)productLable {
    
    if (_productLable == nil) {
        _productLable = [[UILabel alloc] init];
        _productLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.tipsLable1.frame) + SCREEN_WIDTH/25,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _productLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _productLable.textAlignment = NSTextAlignmentLeft;
        _productLable.textColor = [UIColor colorWithHex:@"333333"];
        _productLable.text = @"填写您要推介的具体产品（或服务）名称";
    }
    return _productLable;
}

- (UITextField *)productText {
    
    if (_productText == nil) {
        _productText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                     CGRectGetMaxY(self.productLable.frame) + SCREEN_WIDTH/37.5,
                                                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                     SCREEN_WIDTH/9.375)];
        _productText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _productText.layer.borderWidth  = 1;
        _productText.layer.cornerRadius = 4;
        _productText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _productText.placeholder = @"";
        _productText.tag = 3;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _productText.leftView = paddingView;
        _productText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _productText;
}

- (UILabel *)tipsLable2 {
    
    if (_tipsLable2 == nil) {
        _tipsLable2 = [[UILabel alloc] init];
        _tipsLable2.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       self.productText.bottom + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/31.25);
        _tipsLable2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable2.textAlignment = NSTextAlignmentLeft;
        _tipsLable2.textColor = [UIColor colorWithHex:@"a5a5a5"];
        
        NSMutableAttributedString *cerStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* 如果您要推介房产，请填写楼盘名称"]];
        [cerStr     addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"fa4a4a"] range:NSMakeRange(0,1)];
        _tipsLable2.attributedText = cerStr;
        
        _tipsLable2.numberOfLines = 0;
        [_tipsLable2 sizeToFit];
    }
    return _tipsLable2;
}


/** 业务区域 */
- (UILabel *)cityLable {
    
    if (_cityLable == nil) {
        _cityLable = [[UILabel alloc] init];
        _cityLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      CGRectGetMaxY(self.tipsLable2.frame) + SCREEN_WIDTH/25,
                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                      SCREEN_WIDTH/26.78);
        _cityLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _cityLable.textAlignment = NSTextAlignmentLeft;
        _cityLable.textColor = [UIColor colorWithHex:@"333333"];
        _cityLable.text = @"业务区域";
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
        _cityText.tag = 4;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _cityText.leftView = paddingView;
        _cityText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _cityText;
}


/** 预估项目标的额（万元） */
- (UILabel *)projectPriceLable {
    
    if (_projectPriceLable == nil) {
        _projectPriceLable = [[UILabel alloc] init];
        _projectPriceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                              CGRectGetMaxY(self.cityText.frame) + SCREEN_WIDTH/37.5,
                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                              SCREEN_WIDTH/26.78);
        _projectPriceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _projectPriceLable.textAlignment = NSTextAlignmentLeft;
        _projectPriceLable.textColor = [UIColor colorWithHex:@"333333"];
        _projectPriceLable.text = @"预估项目标的额（万元）";
    }
    return _projectPriceLable;
}

- (UITextField *)projectPriceText {
    
    if (_projectPriceText == nil) {
        _projectPriceText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                          CGRectGetMaxY(self.projectPriceLable.frame) + SCREEN_WIDTH/37.5,
                                                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                          SCREEN_WIDTH/9.375)];
        _projectPriceText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _projectPriceText.layer.borderWidth  = 1;
        _projectPriceText.layer.cornerRadius = 4;
        _projectPriceText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _projectPriceText.placeholder = @"";
        _projectPriceText.keyboardType = UIKeyboardTypeDecimalPad;
        _projectPriceText.tag = 5;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _projectPriceText.leftView = paddingView;
        _projectPriceText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _projectPriceText;
}

/** 期望佣金（%） */
- (UILabel *)commissionLable {
    
    if (_commissionLable == nil) {
        _commissionLable = [[UILabel alloc] init];
        _commissionLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                            CGRectGetMaxY(self.projectPriceText.frame) + SCREEN_WIDTH/37.5,
                                            SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                            SCREEN_WIDTH/26.78);
        _commissionLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _commissionLable.textAlignment = NSTextAlignmentLeft;
        _commissionLable.textColor = [UIColor colorWithHex:@"333333"];
        _commissionLable.text = @"您的期望推介费";
    }
    return _commissionLable;
}

- (UIButton *)funcBtn1 {
    
    if (_funcBtn1 == nil) {
        _funcBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                               CGRectGetMaxY(self.funcBtn3.frame),
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/9.375)];
        _funcBtn1.tag = 1001;
        
        UIImage *img = [UIImage imageNamed:@"symbol_noSelect"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             (_funcBtn1.height - img.size.height)/2,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + SCREEN_WIDTH/46.875,
                                                                        (_funcBtn1.height - SCREEN_WIDTH/31.25)/2,
                                                                        300,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.text = @"按金额";
        
        [_funcBtn1 addSubview:imgView];
        [_funcBtn1 addSubview:titleLable];
        
    }
    return _funcBtn1;
}

- (UIButton *)funcBtn2 {
    
    if (_funcBtn2 == nil) {
        _funcBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                               CGRectGetMaxY(self.funcBtn1.frame),
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/9.375)];
        _funcBtn2.tag = 1002;
        
        UIImage *img = [UIImage imageNamed:@"symbol_noSelect"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             (_funcBtn2.height - img.size.height)/2,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + SCREEN_WIDTH/46.875,
                                                                        (_funcBtn2.height - SCREEN_WIDTH/31.25)/2,
                                                                        300,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.text = @"按比例";
        
        [_funcBtn2 addSubview:imgView];
        [_funcBtn2 addSubview:titleLable];
    }
    return _funcBtn2;
}

- (UIButton *)funcBtn3 {
    
    if (_funcBtn3 == nil) {
        _funcBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                               CGRectGetMaxY(self.funcBtn4.frame),
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/9.375)];
        _funcBtn3.tag = 1003;
        
        UIImage *img = [UIImage imageNamed:@"symbol_noSelect"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             (_funcBtn3.height - img.size.height)/2,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + SCREEN_WIDTH/46.875,
                                                                        (_funcBtn3.height - SCREEN_WIDTH/31.25)/2,
                                                                        300,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.text = @"按行业惯例或接单方规定";
        
        [_funcBtn3 addSubview:imgView];
        [_funcBtn3 addSubview:titleLable];
    }
    return _funcBtn3;
}

- (UIButton *)funcBtn4 {
    
    if (_funcBtn4 == nil) {
        _funcBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                               CGRectGetMaxY(self.commissionLable.frame) + SCREEN_WIDTH/37.5,
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/9.375)];
        _funcBtn4.tag = 1004;
        
        UIImage *img = [UIImage imageNamed:@"symbol_select"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             (_funcBtn4.height - img.size.height)/2,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + SCREEN_WIDTH/46.875,
                                                                        (_funcBtn4.height - SCREEN_WIDTH/31.25)/2,
                                                                        300,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.text = @"认可平台协商的结果";
        
        [_funcBtn4 addSubview:imgView];
        [_funcBtn4 addSubview:titleLable];
    }
    return _funcBtn4;
}

/** 期望推介费 */
- (UILabel *)priceLable {
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.funcBtn2.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78);
        _priceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.textColor = [UIColor colorWithHex:@"333333"];
        _priceLable.alpha = 0;
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
        _priceText.keyboardType = UIKeyboardTypeDecimalPad;
        _priceText.alpha = 0;
        _priceText.tag = 6;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _priceText.leftView = paddingView;
        _priceText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _priceText;
}




/** 项目描述 */
- (UILabel *)projectDescribeLable {
    
    if (_projectDescribeLable == nil) {
        _projectDescribeLable = [[UILabel alloc] init];
        _projectDescribeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                                 CGRectGetMaxY(self.funcBtn2.frame) + SCREEN_WIDTH/37.5,
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
        _placeholderLable.text  = @"您可以填写项目详细信息、甲方具体要求等内容";
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


/** 下一步 */
- (UIButton *)nextBtn {
    
    if (_nextBtn == nil) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                              CGRectGetMaxY(self.worldCountLabel.frame) + SCREEN_WIDTH/18.75,
                                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                              SCREEN_WIDTH/9.375)];
        [_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_nextBtn setTitle:@"提交" forState:UIControlStateNormal];
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
        //_infoPicker.showsSelectionIndicator = YES;
        
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


@end
