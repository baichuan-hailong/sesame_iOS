//
//  ZMMyDelegateView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyDelegateView.h"

@implementation ZMMyDelegateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];

    self.myDelegateTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.myDelegateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.myDelegateTableView];
}

//lazy
-(UITableView *)myDelegateTableView{
    if (_myDelegateTableView==nil) {
        _myDelegateTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0, SCREEN_WIDTH/375*64, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/375*64)];
    }
    return _myDelegateTableView;
}
@end
