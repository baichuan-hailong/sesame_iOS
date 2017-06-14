//
//  ZMCommissionDetailTableHeaderView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionDetailTableHeaderView.h"

@implementation ZMCommissionDetailTableHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //title
    [ZMLabelAttributeMange setLabel:self.titleLabel
                               text:@"---"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self addSubview:self.titleLabel];
}


- (void)settitle:(NSString *)title color:(NSString *)color titleColor:(NSString *)titleColor{
    self.backgroundColor      = [UIColor colorWithHex:color];
    self.titleLabel.text      = title;
    self.titleLabel.textColor = [UIColor colorWithHex:titleColor];
}

-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                SCREEN_WIDTH/375*7,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*19,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _titleLabel;
}


@end
