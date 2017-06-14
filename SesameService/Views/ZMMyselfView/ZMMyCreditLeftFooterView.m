//
//  ZMMyCreditLeftFooterView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditLeftFooterView.h"

@implementation ZMMyCreditLeftFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"- 更多权益，敬请期待 -"
                                hex:@"BBBBBB"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self addSubview:self.tipLabel];
    
    
}

//lazy
-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               SCREEN_WIDTH/375*40.5,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*14)];
    }
    return _tipLabel;
}

@end
