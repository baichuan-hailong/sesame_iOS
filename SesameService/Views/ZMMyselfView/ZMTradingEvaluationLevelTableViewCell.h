//
//  ZMTradingEvaluationLevelTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMEvaluationView.h"

@interface ZMTradingEvaluationLevelTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIView  *levelView;
@property(nonatomic,strong)ZMEvaluationView *levelBtn;

- (void)setEvaluationLevel:(NSDictionary *)levelDic;
@end
