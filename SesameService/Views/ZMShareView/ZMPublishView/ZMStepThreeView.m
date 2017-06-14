//
//  ZMStepThreeView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMStepThreeView.h"

@implementation ZMStepThreeView

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
    
    [self.mainScrollerView addSubview:self.relationLable];
    [self.mainScrollerView addSubview:self.relationText];
    [self.mainScrollerView addSubview:self.supportLable];
    [self.mainScrollerView addSubview:self.supportText];
    [self.mainScrollerView addSubview:self.getPriceLable];
    [self.mainScrollerView addSubview:self.getPriceText];
    [self.mainScrollerView addSubview:self.describe1Lable];
    [self.mainScrollerView addSubview:self.describe1Lable];
    [self.mainScrollerView addSubview:self.expireLable];
    [self.mainScrollerView addSubview:self.expireText];
    [self.mainScrollerView addSubview:self.priceLable];
    [self.mainScrollerView addSubview:self.priceText];
    [self.mainScrollerView addSubview:self.describe2Lable];
    
    [self.mainScrollerView addSubview:self.submitBtn];
    
    self.mainScrollerView.delaysContentTouches = NO;
    for (UIView *currentView in self.mainScrollerView.subviews) {
        
        if([currentView isKindOfClass:[UIScrollView class]]) {
            
            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }
    }
    
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH,
                                       (CGRectGetMaxY(self.submitBtn.frame) + 20) > SCREEN_HEIGHT - 75 ? (CGRectGetMaxY(self.submitBtn.frame) + 20) : SCREEN_HEIGHT - 75);
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
        _topLable.text = @"第三步：设置并提交";
        
        [_topLable.layer setShadowOffset:CGSizeMake(1, 1)];
        [_topLable.layer setShadowRadius:1];
        [_topLable.layer setShadowOpacity:0.2];
        [_topLable.layer setShadowColor:[UIColor blackColor].CGColor];
    }
    return _topLable;
}

/** 您与此项目的关系 */
- (UILabel *)relationLable {
    
    if (_relationLable == nil) {
        _relationLable = [[UILabel alloc] init];
        _relationLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                          SCREEN_WIDTH/18.75,
                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                          SCREEN_WIDTH/26.78);
        _relationLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _relationLable.textAlignment = NSTextAlignmentLeft;
        _relationLable.textColor = [UIColor colorWithHex:@"333333"];
        _relationLable.text = @"您与此项目的关系";
    }
    return _relationLable;
}

- (UITextField *)relationText {
    
    if (_relationText == nil) {
        _relationText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                      CGRectGetMaxY(self.relationLable.frame) + SCREEN_WIDTH/37.5,
                                                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                      SCREEN_WIDTH/9.375)];
        _relationText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _relationText.layer.borderWidth  = 1;
        _relationText.layer.cornerRadius = 4;
        _relationText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _relationText.placeholder = @"您与此项目的关系";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _relationText.leftView = paddingView;
        _relationText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _relationText;
}


/** 您是否能够提供其他支持？ */
- (UILabel *)supportLable {
    
    if (_supportLable == nil) {
        _supportLable = [[UILabel alloc] init];
        _supportLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.relationText.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _supportLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _supportLable.textAlignment = NSTextAlignmentLeft;
        _supportLable.textColor = [UIColor colorWithHex:@"333333"];
        _supportLable.text = @"您是否能够提供其他支持？";
    }
    return _supportLable;
}

- (UITextField *)supportText {
    
    if (_supportText == nil) {
        _supportText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                     CGRectGetMaxY(self.supportLable.frame) + SCREEN_WIDTH/37.5,
                                                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                     SCREEN_WIDTH/9.375)];
        _supportText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _supportText.layer.borderWidth  = 1;
        _supportText.layer.cornerRadius = 4;
        _supportText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _supportText.placeholder = @"您是否能够提供其他支持？";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _supportText.leftView = paddingView;
        _supportText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _supportText;
}


/** 期望佣金 */
- (UILabel *)getPriceLable {
    
    if (_getPriceLable == nil) {
        _getPriceLable = [[UILabel alloc] init];
        _getPriceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                          CGRectGetMaxY(self.supportText.frame) + SCREEN_WIDTH/37.5,
                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                          SCREEN_WIDTH/26.78);
        _getPriceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _getPriceLable.textAlignment = NSTextAlignmentLeft;
        _getPriceLable.textColor = [UIColor colorWithHex:@"333333"];
        _getPriceLable.text = @"期望佣金";
    }
    return _getPriceLable;
}

- (UITextField *)getPriceText {
    
    if (_getPriceText == nil) {
        _getPriceText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                      CGRectGetMaxY(self.getPriceLable.frame) + SCREEN_WIDTH/37.5,
                                                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                      SCREEN_WIDTH/9.375)];
        _getPriceText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _getPriceText.layer.borderWidth  = 1;
        _getPriceText.layer.cornerRadius = 4;
        _getPriceText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _getPriceText.placeholder = @"期望佣金";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _getPriceText.leftView = paddingView;
        _getPriceText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _getPriceText;
}

/** 说明2 */
- (UILabel *)describe1Lable {
    
    if (_describe1Lable == nil) {
        _describe1Lable = [[UILabel alloc] init];
        _describe1Lable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                           CGRectGetMaxY(self.getPriceText.frame) + SCREEN_WIDTH/37.5,
                                           SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                           SCREEN_WIDTH/31.25);
        _describe1Lable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _describe1Lable.textAlignment = NSTextAlignmentLeft;
        _describe1Lable.textColor = [UIColor colorWithHex:@"999999"];
        _describe1Lable.numberOfLines = 0;
        _describe1Lable.text = @"说明：佣金奖励由会员线下协商，平台不保证会员一定可以获得佣金。";
        [_describe1Lable sizeToFit];
    }
    return _describe1Lable;
}


/** 消息有效期 */
- (UILabel *)expireLable {
    
    if (_expireLable == nil) {
        _expireLable = [[UILabel alloc] init];
        _expireLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.describe1Lable.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _expireLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _expireLable.textAlignment = NSTextAlignmentLeft;
        _expireLable.textColor = [UIColor colorWithHex:@"333333"];
        _expireLable.text = @"消息有效期";
    }
    return _expireLable;
}

- (UITextField *)expireText {
    
    if (_expireText == nil) {
        _expireText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                    CGRectGetMaxY(self.expireLable.frame) + SCREEN_WIDTH/37.5,
                                                                    SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                    SCREEN_WIDTH/9.375)];
        _expireText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _expireText.layer.borderWidth  = 1;
        _expireText.layer.cornerRadius = 4;
        _expireText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _expireText.placeholder = @"消息有效期";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _expireText.leftView = paddingView;
        _expireText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _expireText;
}


/** 设置价格（目前平台规定信息价格应为0-5000元之间） */
- (UILabel *)priceLable {
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.expireText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78);
        _priceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.textColor = [UIColor colorWithHex:@"333333"];
        _priceLable.text = @"设置价格（目前平台规定信息价格应为0-5000元之间）";
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
        _priceText.placeholder = @"请输入0-5000的数值";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _priceText.leftView = paddingView;
        _priceText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _priceText;
}



/** 说明2 */
- (UILabel *)describe2Lable {
    
    if (_describe2Lable == nil) {
        _describe2Lable = [[UILabel alloc] init];
        _describe2Lable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                          CGRectGetMaxY(self.priceText.frame) + SCREEN_WIDTH/37.5,
                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                          SCREEN_WIDTH/31.25);
        _describe2Lable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _describe2Lable.textAlignment = NSTextAlignmentLeft;
        _describe2Lable.textColor = [UIColor colorWithHex:@"999999"];
        _describe2Lable.text = @"说明：信息出售后15个工作日结算";
    }
    return _describe2Lable;
}



/** 下一步 */
- (UIButton *)submitBtn {
    
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                CGRectGetMaxY(self.describe2Lable.frame) + SCREEN_WIDTH/18.75,
                                                                SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                SCREEN_WIDTH/9.375)];
        [_submitBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 4;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_submitBtn.frame.size] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

@end
