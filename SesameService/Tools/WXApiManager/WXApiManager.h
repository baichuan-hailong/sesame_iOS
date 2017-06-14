//
//  WXApiManager.h
//  biufang
//
//  Created by 杜海龙 on 16/9/30.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXApiManager : NSObject<WXApiDelegate>

+ (instancetype)sharedManager;


//包打听问题付款
- (void)evokeWechatPayQuestionID:(NSString *)questionID;
//业务信息支付
- (void)evokeWechatPayInfoID:(NSString *)infoID;











- (void)wechatPayParameter:(NSDictionary *)payload;


@end
