//
//  ZMTradingDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingDetailView.h"

@implementation ZMTradingDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.tradingDetailTableView.backgroundColor= [UIColor colorWithHex:backGroundColor];
    self.tradingDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tradingDetailTableView];

}

//lazy
-(UITableView *)tradingDetailTableView{
    if (_tradingDetailTableView==nil) {
        _tradingDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                      64,
                                                      SCREEN_WIDTH,
                                                      SCREEN_HEIGHT-64)];
        
        
    }
    return _tradingDetailTableView;
}

@end
