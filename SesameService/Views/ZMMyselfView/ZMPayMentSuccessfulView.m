//
//  ZMPayMentSuccessfulView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayMentSuccessfulView.h"

@implementation ZMPayMentSuccessfulView




- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    self.succeTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.succeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.succeTableView];
}




//lazy
-(UITableView *)succeTableView{
    if (_succeTableView==nil) {
        _succeTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                        64,
                                                                        SCREEN_WIDTH,
                                                                        SCREEN_HEIGHT-SCREEN_WIDTH/375*64)];
    }
    return _succeTableView;
}

@end
