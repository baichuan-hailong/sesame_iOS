//
//  ZMCommissionDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionDetailView.h"

@implementation ZMCommissionDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.commissionDetailTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.commissionDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.commissionDetailTableView];
    
}

//lazy
-(UITableView *)commissionDetailTableView{
    if (_commissionDetailTableView==nil) {
        _commissionDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        
        
    }
    return _commissionDetailTableView;
}


@end
