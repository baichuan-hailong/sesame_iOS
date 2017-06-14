//
//  ZMMyBuyView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyBuyView.h"

@implementation ZMMyBuyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.buyTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.buyTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.buyTableView];
    
}

//lazy
-(UITableView *)buyTableView{
    if (_buyTableView==nil) {
        _buyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    }
    return _buyTableView;
}

@end
