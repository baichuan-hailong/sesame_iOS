//
//  SSAliPayManage.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/16.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSAliPayManage : NSObject

+(instancetype)defauleSingleton;


//包打听问题付款
- (void)evokeAliPayQuestionID:(NSString *)questionID;

//业务信息支付
- (void)evokeAliPayInfoID:(NSString *)infoID;

//web pay
- (void)evokeWebPayWithWebPayStr:(NSString *)webPayStr;
//app pay
- (void)evokeAppPayOrderDic:(NSDictionary *)orderDic;
@end
