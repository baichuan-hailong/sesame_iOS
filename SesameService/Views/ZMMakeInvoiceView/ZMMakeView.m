//
//  ZMMakeView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMakeView.h"

@interface ZMMakeView ()

@end



@implementation ZMMakeView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor                   = [UIColor whiteColor];
    
    self.contentSize     = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-63);
    self.showsHorizontalScrollIndicator = NO;
    
    
    
}

@end
