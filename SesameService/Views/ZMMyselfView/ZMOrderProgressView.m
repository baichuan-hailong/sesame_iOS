//
//  ZMOrderProgressView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/17.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMOrderProgressView.h"

@interface ZMOrderProgressView ()
@property(nonatomic,strong)UIView   *headerView;
@end

@implementation ZMOrderProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.orderProgressTableView.backgroundColor = [UIColor whiteColor];
    self.orderProgressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.orderProgressTableView];
    
    self.ordProHeaderView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    [self addSubview:self.ordProHeaderView];
    
    //header view
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.ordProHeaderView addSubview:self.headerView];
    
    
    self.ordProHeaderImageView.backgroundColor = [UIColor whiteColor];
    self.ordProHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerView addSubview:self.ordProHeaderImageView];
    
    
    
    
    
}

//lazy
-(UITableView *)orderProgressTableView{
    if (_orderProgressTableView==nil) {
        _orderProgressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64+SCREEN_WIDTH/375*120+SCREEN_WIDTH/375*13,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64-SCREEN_WIDTH/375*120-SCREEN_WIDTH/375*13)];
        
        
    }
    return _orderProgressTableView;
}


-(UIView *)ordProHeaderView{
    if (_ordProHeaderView==nil) {
        _ordProHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    64,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_WIDTH/375*120+SCREEN_WIDTH/375*13)];
        
        
    }
    return _ordProHeaderView;
}


-(UIView *)headerView{
    if (_headerView==nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                 0,
                                                 SCREEN_WIDTH,
                                                 SCREEN_WIDTH/375*120)];

        
    }
    return _headerView;
}
-(UIImageView *)ordProHeaderImageView{
    if (_ordProHeaderImageView==nil) {
        _ordProHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*330)/2,
                                                                     (SCREEN_WIDTH/375*120-SCREEN_WIDTH/375*134/2)/2,
                                                                     SCREEN_WIDTH/375*330,
                                                                     SCREEN_WIDTH/375*134/2)];
        
        
    }
    return _ordProHeaderImageView;
}

@end
