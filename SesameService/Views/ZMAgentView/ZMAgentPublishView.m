//
//  ZMAgentPublishView.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentPublishView.h"

@implementation ZMAgentPublishView

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
    
    [self.mainScrollerView addSubview:self.titleLable];
    [self.mainScrollerView addSubview:self.titleText];
    [self.mainScrollerView addSubview:self.areaLable];
    [self.mainScrollerView addSubview:self.areaText];
    [self.mainScrollerView addSubview:self.moneyLable];
    [self.mainScrollerView addSubview:self.moneyText];
    [self.mainScrollerView addSubview:self.describeLable];
    [self.mainScrollerView addSubview:self.describeTextView];
    [self.mainScrollerView addSubview:self.connectLable];
    [self.mainScrollerView addSubview:self.connectText];
    [self.mainScrollerView addSubview:self.phoneLable];
    [self.mainScrollerView addSubview:self.phoneText];
    [self.mainScrollerView addSubview:self.submitBtn];
    
    
    self.mainScrollerView.delaysContentTouches = NO;
    for (UIView *currentView in self.mainScrollerView.subviews) {
        
        if([currentView isKindOfClass:[UIScrollView class]]) {
            
            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }
    }
    
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH,
                                                   CGRectGetMaxY(self.submitBtn.frame) > SCREEN_HEIGHT - 64 ? CGRectGetMaxY(self.submitBtn.frame) + 10 : SCREEN_HEIGHT - 63);
}


#pragma mark - getter
- (UIScrollView *)mainScrollerView {
    
    if (_mainScrollerView == nil) {
        _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           64,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT - 64)];
        _mainScrollerView.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollerView;
}

/** 标题 */
- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       SCREEN_WIDTH/18.75,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78);
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHex:@"333333"];
        _titleLable.text = @"标题";
    }
    return _titleLable;
}

- (UITextField *)titleText {
    
    if (_titleText == nil) {
        _titleText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                   CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/37.5,
                                                                   SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                   SCREEN_WIDTH/9.375)];
        _titleText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _titleText.layer.borderWidth  = 1;
        _titleText.layer.cornerRadius = 4;
        _titleText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _titleText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _titleText.leftView = paddingView;
        _titleText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _titleText;
}


/** 代理区域 */
- (UILabel *)areaLable {
    
    if (_areaLable == nil) {
        _areaLable = [[UILabel alloc] init];
        _areaLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      CGRectGetMaxY(self.titleText.frame) + SCREEN_WIDTH/37.5,
                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                      SCREEN_WIDTH/26.78);
        _areaLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _areaLable.textAlignment = NSTextAlignmentLeft;
        _areaLable.textColor = [UIColor colorWithHex:@"333333"];
        _areaLable.text = @"代理区域";
    }
    return _areaLable;
}

- (UITextField *)areaText {
    
    if (_areaText == nil) {
        _areaText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                  CGRectGetMaxY(self.areaLable.frame) + SCREEN_WIDTH/37.5,
                                                                  SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                  SCREEN_WIDTH/9.375)];
        _areaText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _areaText.layer.borderWidth  = 1;
        _areaText.layer.cornerRadius = 4;
        _areaText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _areaText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _areaText.leftView = paddingView;
        _areaText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _areaText;
}


/** 佣金比例 */
- (UILabel *)moneyLable {
    
    if (_moneyLable == nil) {
        _moneyLable = [[UILabel alloc] init];
        _moneyLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                        CGRectGetMaxY(self.areaText.frame) + SCREEN_WIDTH/37.5,
                                        SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                        SCREEN_WIDTH/26.78);
        _moneyLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _moneyLable.textAlignment = NSTextAlignmentLeft;
        _moneyLable.textColor = [UIColor colorWithHex:@"333333"];
        _moneyLable.text = @"佣金比例（%）";
    }
    return _moneyLable;
}

- (UITextField *)moneyText {
    
    if (_moneyText == nil) {
        _moneyText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                   CGRectGetMaxY(self.moneyLable.frame) + SCREEN_WIDTH/37.5,
                                                                   SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                   SCREEN_WIDTH/9.375)];
        _moneyText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _moneyText.layer.borderWidth  = 1;
        _moneyText.layer.cornerRadius = 4;
        _moneyText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _moneyText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _moneyText.leftView = paddingView;
        _moneyText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _moneyText;
}

/** 项目说明 */
- (UILabel *)describeLable {
    
    if (_describeLable == nil) {
        _describeLable = [[UILabel alloc] init];
        _describeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                          CGRectGetMaxY(self.moneyText.frame) + SCREEN_WIDTH/37.5,
                                          SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                          SCREEN_WIDTH/26.78);
        _describeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _describeLable.textAlignment = NSTextAlignmentLeft;
        _describeLable.textColor = [UIColor colorWithHex:@"333333"];
        _describeLable.text = @"项目说明";
    }
    return _describeLable;
}

- (UITextView *)describeTextView {
    
    if (_describeTextView == nil) {
        _describeTextView = [[UITextView alloc] init];
        
        _describeTextView.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                             CGRectGetMaxY(self.describeLable.frame) + SCREEN_WIDTH/37.5,
                                             SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                             SCREEN_WIDTH/2.35);
        _describeTextView.backgroundColor = [UIColor whiteColor];
        _describeTextView.layer.cornerRadius = 4;
        _describeTextView.layer.borderColor = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _describeTextView.layer.borderWidth = 1;
        _describeTextView.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];//设置字体名字和字体大小
        
        _describeTextView.keyboardType = UIKeyboardTypeDefault; //键盘类型
        _describeTextView.scrollEnabled = YES; //是否可以拖动
    }
    return _describeTextView;
}


/** 联系人 */
- (UILabel *)connectLable {
    
    if (_connectLable == nil) {
        _connectLable = [[UILabel alloc] init];
        _connectLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.describeTextView.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _connectLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _connectLable.textAlignment = NSTextAlignmentLeft;
        _connectLable.textColor = [UIColor colorWithHex:@"333333"];
        _connectLable.text = @"联系人";
    }
    return _connectLable;
}

- (UITextField *)connectText {
    
    if (_connectText == nil) {
        _connectText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                     CGRectGetMaxY(self.connectLable.frame) + SCREEN_WIDTH/37.5,
                                                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                     SCREEN_WIDTH/9.375)];
        _connectText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _connectText.layer.borderWidth  = 1;
        _connectText.layer.cornerRadius = 4;
        _connectText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _connectText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _connectText.leftView = paddingView;
        _connectText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _connectText;
}


/** 联系电话 */
- (UILabel *)phoneLable {
    
    if (_phoneLable == nil) {
        _phoneLable = [[UILabel alloc] init];
        _phoneLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                       CGRectGetMaxY(self.connectText.frame) + SCREEN_WIDTH/37.5,
                                       SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                       SCREEN_WIDTH/26.78);
        _phoneLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _phoneLable.textAlignment = NSTextAlignmentLeft;
        _phoneLable.textColor = [UIColor colorWithHex:@"333333"];
        _phoneLable.text = @"联系电话";
    }
    return _phoneLable;
}

- (UITextField *)phoneText {
    
    if (_phoneText == nil) {
        _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                   CGRectGetMaxY(self.phoneLable.frame) + SCREEN_WIDTH/37.5,
                                                                   SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                   SCREEN_WIDTH/9.375)];
        _phoneText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _phoneText.layer.borderWidth  = 1;
        _phoneText.layer.cornerRadius = 4;
        _phoneText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _phoneText.placeholder = @"";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _phoneText.leftView = paddingView;
        _phoneText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneText;
}





/** 下一步 */
- (UIButton *)submitBtn {
    
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                CGRectGetMaxY(self.phoneText.frame) + SCREEN_WIDTH/18.75,
                                                                SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                SCREEN_WIDTH/9.375)];
        [_submitBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_submitBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 4;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_submitBtn.frame.size] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

@end
