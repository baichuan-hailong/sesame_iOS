//
//  ZMComplaintsDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMComplaintsDetailView.h"

@implementation ZMComplaintsDetailView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.complaintsDetailTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.complaintsDetailTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.complaintsDetailTableView];
    
}

//lazy
-(UITableView *)complaintsDetailTableView{
    if (_complaintsDetailTableView==nil) {
        _complaintsDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                               64,
                                                                               SCREEN_WIDTH,
                                                                               SCREEN_HEIGHT-64)];
    }
    return _complaintsDetailTableView;
}


@end
