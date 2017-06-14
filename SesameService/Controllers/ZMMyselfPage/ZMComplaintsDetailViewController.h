//
//  ZMComplaintsDetailViewController.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBasePushViewController.h"

@interface ZMComplaintsDetailViewController : ZMBasePushViewController
@property(nonatomic,copy)NSString     *feedID;
@property(nonatomic,copy)NSDictionary *topDic;
@property(nonatomic,copy)NSString     *status;

@property(nonatomic,assign)BOOL     isRootPop;
@end
