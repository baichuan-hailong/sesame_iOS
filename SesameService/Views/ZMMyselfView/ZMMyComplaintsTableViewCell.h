//
//  ZMMyComplaintsTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMyComplaintsTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *tradingNumLabel;
@property (nonatomic , strong) UILabel     *tradingTimeLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;
@property (nonatomic , strong) UILabel     *comTimeLabel;

@property (nonatomic , strong) UIImageView *lineImg;

@property (nonatomic , strong) UILabel     *stateLabel;
@property (nonatomic , strong) UILabel     *resultLabel;

- (void)setComplain:(NSDictionary *)leftDic;

@end
