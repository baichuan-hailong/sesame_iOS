//
//  ZMTradingEvaluationViewController.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBasePushViewController.h"

@interface ZMTradingEvaluationViewController : ZMBasePushViewController
@property(nonatomic,copy)NSString *infoID;
@property(nonatomic,assign)BOOL   isSell;


@property(nonatomic,strong)NSDictionary *buyTipDic;

@end
