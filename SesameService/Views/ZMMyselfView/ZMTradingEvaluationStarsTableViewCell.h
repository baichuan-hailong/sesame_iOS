//
//  ZMTradingEvaluationStarsTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMStarTradingEvaluationView.h"

@interface ZMTradingEvaluationStarsTableViewCell : UITableViewCell


//信息
@property(nonatomic,strong)ZMStarTradingEvaluationView *xinxiStarView;
@property(nonatomic,strong)UILabel *xinxiLabel;

//关系
@property(nonatomic,strong)ZMStarTradingEvaluationView *guanxiStarView;
@property(nonatomic,strong)UILabel *guanxiLabel;

//价格
@property(nonatomic,strong)ZMStarTradingEvaluationView *jiageStarView;
@property(nonatomic,strong)UILabel *jiageLabel;

//项目
@property(nonatomic,strong)ZMStarTradingEvaluationView *xiangmuStarView;
@property(nonatomic,strong)UILabel *xiangmuLabel;


@property(nonatomic,strong)UILabel *tipLabel;

- (void)setEvaluationStars:(NSDictionary *)starDic;

@end
