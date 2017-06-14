//
//  ZMStepTwoView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMStepTwoView.h"

@implementation ZMStepTwoView

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
    
    [self.mainScrollerView addSubview:self.nameLable];
    [self.mainScrollerView addSubview:self.nameText];
    [self.mainScrollerView addSubview:self.connectLable];
    [self.mainScrollerView addSubview:self.connectText];
    [self.mainScrollerView addSubview:self.telNumLable];
    [self.mainScrollerView addSubview:self.telNumText];
    [self.mainScrollerView addSubview:self.requireLable];
    [self.mainScrollerView addSubview:self.requireText];
    
    [self.mainScrollerView addSubview:self.describeLable];
    [self.mainScrollerView addSubview:self.describeTextView];
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
        _topLable.text = @"第二步：填写甲方信息及要求";
        
        [_topLable.layer setShadowOffset:CGSizeMake(1, 1)];
        [_topLable.layer setShadowRadius:1];
        [_topLable.layer setShadowOpacity:0.2];
        [_topLable.layer setShadowColor:[UIColor blackColor].CGColor];
    }
    return _topLable;
}

/** 客户名称 */
- (UILabel *)nameLable {
    
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                      SCREEN_WIDTH/18.75,
                                      SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                      SCREEN_WIDTH/26.78);
        _nameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.textColor = [UIColor colorWithHex:@"333333"];
        _nameLable.text = @"客户名称";
    }
    return _nameLable;
}

- (UITextField *)nameText {
    
    if (_nameText == nil) {
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                  CGRectGetMaxY(self.nameLable.frame) + SCREEN_WIDTH/37.5,
                                                                  SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                  SCREEN_WIDTH/9.375)];
        _nameText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _nameText.layer.borderWidth  = 1;
        _nameText.layer.cornerRadius = 4;
        _nameText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _nameText.placeholder = @"输入项目名称，如：旅游地产项目策划";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _nameText.leftView = paddingView;
        _nameText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _nameText;
}


/** 项目联系人 */
- (UILabel *)connectLable {
    
    if (_connectLable == nil) {
        _connectLable = [[UILabel alloc] init];
        _connectLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.nameText.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _connectLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _connectLable.textAlignment = NSTextAlignmentLeft;
        _connectLable.textColor = [UIColor colorWithHex:@"333333"];
        _connectLable.text = @"项目联系人";
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
        _connectText.placeholder = @"项目联系人";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _connectText.leftView = paddingView;
        _connectText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _connectText;
}


/** 联系电话 */
- (UILabel *)telNumLable {
    
    if (_telNumLable == nil) {
        _telNumLable = [[UILabel alloc] init];
        _telNumLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                        CGRectGetMaxY(self.connectText.frame) + SCREEN_WIDTH/37.5,
                                        SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                        SCREEN_WIDTH/26.78);
        _telNumLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _telNumLable.textAlignment = NSTextAlignmentLeft;
        _telNumLable.textColor = [UIColor colorWithHex:@"333333"];
        _telNumLable.text = @"联系电话";
    }
    return _telNumLable;
}

- (UITextField *)telNumText {
    
    if (_telNumText == nil) {
        _telNumText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                    CGRectGetMaxY(self.telNumLable.frame) + SCREEN_WIDTH/37.5,
                                                                    SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                    SCREEN_WIDTH/9.375)];
        _telNumText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _telNumText.layer.borderWidth  = 1;
        _telNumText.layer.cornerRadius = 4;
        _telNumText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _telNumText.placeholder = @"联系电话";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _telNumText.leftView = paddingView;
        _telNumText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _telNumText;
}


/** 客户对服务商行业排名的要求 */
- (UILabel *)requireLable {
    
    if (_requireLable == nil) {
        _requireLable = [[UILabel alloc] init];
        _requireLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                         CGRectGetMaxY(self.telNumText.frame) + SCREEN_WIDTH/37.5,
                                         SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                         SCREEN_WIDTH/26.78);
        _requireLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _requireLable.textAlignment = NSTextAlignmentLeft;
        _requireLable.textColor = [UIColor colorWithHex:@"333333"];
        _requireLable.text = @"客户对服务商行业排名的要求";
    }
    return _requireLable;
}

- (UITextField *)requireText {
    
    if (_requireText == nil) {
        _requireText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                     CGRectGetMaxY(self.requireLable.frame) + SCREEN_WIDTH/37.5,
                                                                     SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                                     SCREEN_WIDTH/9.375)];
        _requireText.layer.borderColor  = [UIColor colorWithHex:@"cfcfcf"].CGColor;
        _requireText.layer.borderWidth  = 1;
        _requireText.layer.cornerRadius = 4;
        _requireText.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        _requireText.placeholder = @"客户对服务商行业排名的要求";
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/31.25, SCREEN_WIDTH/9.375)];
        _requireText.leftView = paddingView;
        _requireText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _requireText;
}



/** 其他说明（选填） */
- (UILabel *)describeLable {
    
    if (_describeLable == nil) {
        _describeLable = [[UILabel alloc] init];
        _describeLable.frame = CGRectMake(SCREEN_WIDTH/18.75,
                                                 CGRectGetMaxY(self.requireText.frame) + SCREEN_WIDTH/37.5,
                                                 SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                 SCREEN_WIDTH/26.78);
        _describeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
        _describeLable.textAlignment = NSTextAlignmentLeft;
        _describeLable.textColor = [UIColor colorWithHex:@"333333"];
        _describeLable.text = @"其他说明（选填）";
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


/** 下一步 */
- (UIButton *)nextBtn {
    
    if (_nextBtn == nil) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                              CGRectGetMaxY(self.describeTextView.frame) + SCREEN_WIDTH/18.75,
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
