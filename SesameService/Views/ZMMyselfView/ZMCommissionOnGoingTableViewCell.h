//
//  ZMCommissionOnGoingTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCommissionOnGoingTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;

@property (nonatomic , strong) UILabel     *accountedLabel;

@property (nonatomic , strong) UILabel     *timeLabel;
@property (nonatomic , strong) UILabel     *stateLabel;

@property (nonatomic , strong) UILabel     *tipLabel;

- (void)setCommission:(NSDictionary *)commisionDid isLeft:(BOOL)isLeft isCom:(BOOL)isCom;

@end
