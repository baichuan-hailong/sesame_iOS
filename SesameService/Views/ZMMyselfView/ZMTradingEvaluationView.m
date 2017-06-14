
//
//  ZMTradingEvaluationView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingEvaluationView.h"

@implementation ZMTradingEvaluationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.tradingEvaluationTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.tradingEvaluationTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tradingEvaluationTableView];
    
}

//lazy
-(UITableView *)tradingEvaluationTableView{
    if (_tradingEvaluationTableView==nil) {
        _tradingEvaluationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                      64,
                                                                      SCREEN_WIDTH,
                                                                      SCREEN_HEIGHT-64)];
    }
    return _tradingEvaluationTableView;
}

@end
