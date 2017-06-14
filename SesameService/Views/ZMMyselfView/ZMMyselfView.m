//
//  ZMMyselfView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyselfView.h"

@implementation ZMMyselfView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor                   = [UIColor colorWithHex:backGroundColor];
    self.newMyselTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.newMyselTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.newMyselTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.newMyselTableView];
    
}

-(UITableView *)newMyselTableView{
    
    if (_myselTableView==nil) {
        _myselTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    return _myselTableView;
}

@end
