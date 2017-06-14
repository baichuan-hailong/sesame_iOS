//
//  ZMPostEvaluationViewController.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBasePushViewController.h"

@interface ZMPostEvaluationViewController : ZMBasePushViewController
@property(nonatomic,copy)NSString *infoID;

@property(nonatomic,strong)NSDictionary *buyTipDic;
@property(nonatomic,assign)BOOL   isSell;

@end
