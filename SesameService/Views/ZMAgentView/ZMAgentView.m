//
//  ZMAgentView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentView.h"

@implementation ZMAgentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.agentTableView];
}


- (UITableView *)agentTableView {
    
    if (_agentTableView == nil) {
        _agentTableView = [[UITableView alloc] init];
        _agentTableView.frame = CGRectMake(0,
                                           64,
                                           SCREEN_WIDTH,
                                           SCREEN_HEIGHT - 64);
        _agentTableView.backgroundColor = [UIColor colorWithHex:backColor];
        _agentTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _agentTableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
        _agentTableView.showsVerticalScrollIndicator = NO;
    }
    return _agentTableView;
}

@end
