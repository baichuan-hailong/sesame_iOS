//
//  ZMComplaintsDetailTopTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMComplaintsDetailTopTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *tradingNumLabel;
@property (nonatomic , strong) UILabel     *tradingTimeLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;

@property (nonatomic , strong) UILabel     *stateLabel;

- (void)setDetailTop:(NSDictionary *)leftDic;
@end
