//
//  ZMReleaseBusinessView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMReleaseBusinessView.h"

@implementation ZMReleaseBusinessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.releaseBusinessTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.releaseBusinessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.releaseBusinessTableView];
}

//lazy
-(UITableView *)releaseBusinessTableView{
    if (!_releaseBusinessTableView) {
        _releaseBusinessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*64, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/375*64)];
    }
    return _releaseBusinessTableView;
}

@end
