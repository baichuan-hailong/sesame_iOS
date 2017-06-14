//
//  ZMPayMoneyTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPayMoneyTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *tipLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;
@property (nonatomic , strong) UIView     *line;
- (void)setPayMoney:(NSDictionary *)dic;
@end
