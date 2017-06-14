//
//  ZMMoreProjectInfoView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMoreProjectInfoView.h"

@implementation ZMMoreProjectInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.moreProjectInfoTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.moreProjectInfoTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.moreProjectInfoTableView];
    
}

//lazy
-(UITableView *)moreProjectInfoTableView{
    if (_moreProjectInfoTableView==nil) {
        _moreProjectInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                    64,
                                                                                    SCREEN_WIDTH,
                                                                                    SCREEN_HEIGHT-64)];
    }
    return _moreProjectInfoTableView;
}

@end
