//
//  ZMInvoiceDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvoiceDetailView.h"

@implementation ZMInvoiceDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.invoiceTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.invoiceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.invoiceTableView];
    
}

//lazy
-(UITableView *)invoiceTableView{
    if (_invoiceTableView==nil) {
        _invoiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                          64,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HEIGHT-64)];
        
        
    }
    return _invoiceTableView;
}

@end
