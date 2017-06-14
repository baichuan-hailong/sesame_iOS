//
//  ZMTabbar.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTabbar.h"

@interface ZMTabbar ()

@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) UILabel  *publishLable;

@end

@implementation ZMTabbar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.publishBtn];
    [self addSubview:self.publishLable];
    [self dropShadowWithOffset:CGSizeMake(1, -0.6)
                        radius:1.2
                         color:[UIColor lightGrayColor]
                       opacity:0.66];
    
    //设置其他按钮位置
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0, j = 0; i < count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = self.width / 5.0;
            child.x = self.width * j / 5.0;
            j++;
            if (j == 2) {//中间空出一个位置留给发布按钮
                j++;
            }
        }
    }
}



- (void)publishButtonClick:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(tabBarButtonClick:)]) {
        [self.delegate tabBarButtonClick:self];
    }
}



#pragma mark - 阴影效果
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}


#pragma mark - getter
- (UIButton *)publishBtn {

    if (_publishBtn == nil) {
        
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
        [_publishBtn setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateHighlighted];
        _publishBtn.frame = CGRectMake(SCREEN_WIDTH/2 - (_publishBtn.currentBackgroundImage.size.width)/2,
                                      -(_publishBtn.currentBackgroundImage.size.height)/2.5,
                                      _publishBtn.currentBackgroundImage.size.width,
                                      _publishBtn.currentBackgroundImage.size.height);
        [_publishBtn addTarget:self action:@selector(publishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

- (UILabel *)publishLable {

    if (_publishLable == nil) {
        _publishLable = [[UILabel alloc] init];
        _publishLable.text = @"我要赚";
        _publishLable.font = [UIFont systemFontOfSize:10];
        _publishLable.textColor = [UIColor lightGrayColor];
        _publishLable.textAlignment = NSTextAlignmentCenter;
        _publishLable.width  = 50;
        _publishLable.height = 10;
        _publishLable.centerX = self.publishBtn.centerX;
        _publishLable.centerY = self.publishBtn.centerY + self.publishBtn.height * 0.69;
        
    }
    return _publishLable;
}



@end
