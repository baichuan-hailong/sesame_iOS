//
//  ZMTradingTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMTradingTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;
@property (nonatomic , strong) UILabel     *timeLabel;


@property (nonatomic , strong) UIView      *line;
- (void)setPromoteIntro:(NSDictionary *)promoteDid;
@end
