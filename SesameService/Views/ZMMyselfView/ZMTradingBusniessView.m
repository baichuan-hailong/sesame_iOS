//
//  ZMTradingBusniessView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingBusniessView.h"

@implementation ZMTradingBusniessView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.tradingBusniessTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.tradingBusniessTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tradingBusniessTableView];
    
}

//lazy
-(UITableView *)tradingBusniessTableView{
    if (_tradingBusniessTableView==nil) {
        _tradingBusniessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                            64,
                                            SCREEN_WIDTH,
                                            SCREEN_HEIGHT-64)];
    }
    return _tradingBusniessTableView;
}


@end
