//
//  CheckPopingNotificationPop.m
//  biufang
//
//  Created by 杜海龙 on 17/2/21.
//  Copyright © 2017年 biufang. All rights reserved.
//

#import "CheckPopingNotificationPop.h"

@implementation CheckPopingNotificationPop

+(void)checkPopingNotiPop{
    //取出当前系统的时间
    NSDate          *unifiedDate         = [NSDate date];//获取当前时间，日期
    NSTimeInterval  currenSyetemTimeInla = [unifiedDate timeIntervalSince1970]+28800;
    NSString *timeSystemStrla            = [NSString stringWithFormat:@"%.f", currenSyetemTimeInla];//转为字符型
    NSLog(@"%@",timeSystemStrla);
    
}


@end
