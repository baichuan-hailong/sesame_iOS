//
//  ZMFeedBackSignResultViewController.h
//  SesameService
//
//  Created by 杜海龙 on 17/6/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMFeedBackSignResultViewController : ZMBasePushViewController
@property(nonatomic,assign)BOOL isFnishFeedBackBool;

@property(nonatomic,strong)NSString *sign_time;
@property(nonatomic,strong)NSString *infoID;
@end
