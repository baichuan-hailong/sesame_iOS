//
//  ZMWordOfMouthView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMWordOfMouthView.h"

@implementation ZMWordOfMouthView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{

    self.mouthTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.mouthTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.mouthTableView];
}

//lazy
-(UITableView *)mouthTableView{
    if (!_mouthTableView) {
        _mouthTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*64, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/375*64)];
    }
    return _mouthTableView;
}


@end
