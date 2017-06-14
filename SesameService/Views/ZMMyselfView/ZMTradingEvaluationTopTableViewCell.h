//
//  ZMTradingEvaluationTopTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMTradingEvaluationTopTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *buyLabel;
@property (nonatomic , strong) UILabel     *numberLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;

- (void)setTradingEvaTop:(NSDictionary *)topDic;
@end
