//
//  ZMUserDataView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUserDataView.h"

@implementation ZMUserDataView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.userDataTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.userDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.userDataTableView];
    
}

//lazy
-(UITableView *)userDataTableView{
    if (_userDataTableView==nil) {
        _userDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64)];
        
        
    }
    return _userDataTableView;
}



@end
