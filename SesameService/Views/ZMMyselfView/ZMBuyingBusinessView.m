
//
//  ZMBuyingBusinessView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBuyingBusinessView.h"

@implementation ZMBuyingBusinessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.buyingBusinessTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.buyingBusinessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self addSubview:self.buyingBusinessTableView];
}

//lazy
-(UITableView *)buyingBusinessTableView{
    if (!_buyingBusinessTableView) {
        _buyingBusinessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*64, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/375*64)];
    }
    return _buyingBusinessTableView;
}

@end
