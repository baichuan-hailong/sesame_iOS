//
//  ZMSaleView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSaleView.h"

@implementation ZMSaleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.saleableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.saleableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.saleableView];
}

//lazy
-(UITableView *)saleableView{
    if (!_saleableView) {
        _saleableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*64, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/375*64)];
    }
    return _saleableView;
}
@end
