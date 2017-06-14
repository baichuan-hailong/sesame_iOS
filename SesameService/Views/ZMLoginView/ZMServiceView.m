//
//  ZMServiceView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMServiceView.h"

@implementation ZMServiceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
