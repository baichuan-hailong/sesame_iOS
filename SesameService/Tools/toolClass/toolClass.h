//
//  toolClass.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface toolClass : NSObject

#pragma mark - 编码工具类
/**
 *  将字符串进行encode编码
 *
 *  @param input 需要编码的字符串
 *
 *  @return 编码后的字符换
 */
+ (NSString *)encodeToPercentEscapeString:(NSString *) input;


#pragma mark - 时间工具类
/**
 *  获取当前时间
 *
 *  @return 当前时间
 */
+ (NSString *)getCurrentTime;

//*** 时间戳转换为标准时间 ***//
+ (NSString *)changeTime:(NSString *)timeStr;
+ (NSString *)changeTimeToDay:(NSString *)timeStr;

#pragma mark - 图形工具类
//将颜色转换为图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//虚线绘制
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

#pragma mark - 字符串工具类
//将字符串转为字典格式json
+ (NSDictionary *)nsstringToJson: (NSString *)jsonString;


//评分正则
+ (NSString *)rateStr: (NSString *)commentStr;

//*** 金额字段加千位分隔符方法 ***//
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;

//*** 获取URL内指定参数 ***//
+ (NSString *)paramValueOfUrl:(NSString *)url withParam:(NSString *)param;

//*** MBProgressHud ***//
+ (void)showProgress:(NSString *)tipStr toView:(UIView *)showView;



@end
