//
//  ZMPayViewController.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBasePushViewController.h"

@interface ZMPayViewController : ZMBasePushViewController
@property(nonatomic,assign)BOOL     isInfo;
//打听
@property(nonatomic,strong)NSString *questionID;
//指定打听
@property(nonatomic,assign)BOOL     isSelected;

//info
@property(nonatomic,strong)NSString *infoID;
@property(nonatomic,strong)NSString *infoTitle;
@property(nonatomic,strong)NSString *money;

//bug
@property (nonatomic, assign) BOOL isHome;

@end
