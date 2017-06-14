//
//  ZMMyCreditRightFooterView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditRightFooterView.h"

@implementation ZMMyCreditRightFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    //self.backgroundColor = [UIColor whiteColor];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                              SCREEN_WIDTH/375*25,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                              SCREEN_WIDTH/375*40)];
    [self setButton:self.backBtn title:@"返回会员中心" color:[UIColor colorWithHex:@"FFFFFF"] font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16] boo:NO];
    [self.backBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.backBtn];
}

- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}


//lazy

@end
