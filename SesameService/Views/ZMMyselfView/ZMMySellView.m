
//
//  ZMMySellView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySellView.h"

@implementation ZMMySellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.sellTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.sellTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.sellTableView];
    
}

//lazy
-(UITableView *)sellTableView{
    if (_sellTableView==nil) {
        _sellTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        
        
    }
    return _sellTableView;
}


@end
