//
//  ZMSelectVipView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSelectVipView.h"

@implementation ZMSelectVipView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor                   = [UIColor colorWithHex:backGroundColor];
    self.selectVipTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.selectVipTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.selectVipTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.selectVipTableView];
    
}

-(UITableView *)selectVipTableView{
    
    if (_selectVipTableView==nil) {
        _selectVipTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }
    return _selectVipTableView;
}

@end
