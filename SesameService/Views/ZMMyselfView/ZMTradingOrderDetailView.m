//
//  ZMTradingOrderDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingOrderDetailView.h"

@implementation ZMTradingOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.tradingOrderDetailTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.tradingOrderDetailTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tradingOrderDetailTableView];
    
}

//lazy
-(UITableView *)tradingOrderDetailTableView{
    if (_tradingOrderDetailTableView==nil) {
        _tradingOrderDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                         64,
                                                                                         SCREEN_WIDTH,
                                                                                         SCREEN_HEIGHT-64)];
        
        
    }
    return _tradingOrderDetailTableView;
}


@end
