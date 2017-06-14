//
//  ZMPayView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayView.h"

@implementation ZMPayView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor              = [UIColor colorWithHex:backGroundColor];
    self.payTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.payTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.payTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.payTableView];
    
}

-(UITableView *)payTableView{
    
    if (_payTableView==nil) {
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                      64,
                                                                      SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    return _payTableView;
}


@end
