//
//  ZMMyInvitionsView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyInvitionsView.h"

@implementation ZMMyInvitionsView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.invitionsTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.invitionsTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.invitionsTableView];
}

//lazy
-(UITableView *)invitionsTableView{
    if (_invitionsTableView==nil) {
        _invitionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                     64,
                                                                                     SCREEN_WIDTH,
                                                                                     SCREEN_HEIGHT-64)];
    }
    return _invitionsTableView;
}


@end
