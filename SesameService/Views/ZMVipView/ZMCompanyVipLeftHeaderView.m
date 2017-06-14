//
//  ZMCompanyVipLeftHeaderView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCompanyVipLeftHeaderView.h"

@interface ZMCompanyVipLeftHeaderView ()
@property(nonatomic,strong)UILabel *headerLabel;
@end

@implementation ZMCompanyVipLeftHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     SCREEN_WIDTH/375*12,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_WIDTH/375*46)];
    self.headerLabel.backgroundColor = [UIColor whiteColor];
    [ZMLabelAttributeMange setLabel:self.headerLabel
                               text:self.titleStr
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [self addSubview:self.headerLabel];
    
}


- (void)setTitle:(NSString *)titleStr{
    self.headerLabel.text = titleStr;
}

@end
