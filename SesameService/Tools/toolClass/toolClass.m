//
//  toolClass.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "toolClass.h"

@implementation toolClass


#pragma mark - 编码工具类
/**
 *  将字符串进行encode编码
 *
 *  @param input 需要编码的字符串
 *
 *  @return 编码后的字符换
 */
+ (NSString *)encodeToPercentEscapeString: (NSString *) input {
    
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return outputStr;
}

#pragma mark - 时间工具类
/**
 *  获取当前时间
 *
 *  @return 当前时间
 */
+ (NSString *)getCurrentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *time = [NSString stringWithFormat:@"%@",dateTime];
    return time;
}


//时间戳传唤为标准时间
+ (NSString *)changeTime:(NSString *)timeStr {
    
    NSTimeInterval timeInt = [timeStr doubleValue];// + 28800;//因为时差 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInt];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}

+ (NSString *)changeTimeToDay:(NSString *)timeStr {
    
    NSTimeInterval timeInt = [timeStr doubleValue];// + 28800;//因为时差 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInt];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}



#pragma mark - 图形工具类
//将颜色转换为图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}



#pragma mark - 字符串工具类
/**
 *  将字符串转换为标书呢json
 *
 *  @param jsonString 字符串
 *
 *  @return json对象
 */
+ (NSDictionary *)nsstringToJson: (NSString *)jsonString {
    
    NSError *error;
    NSData *resData = [[NSData alloc] initWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:&error];  //解析
    
    return resultDic;
}


//评分正则
+ (NSString *)rateStr:(NSString *)commentStr {
    
    NSString *searchedString = commentStr;
    NSRange  searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"T(\\d+\\.?\\d*).*$";
    NSError  *error = nil;
    
    NSRegularExpression  *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:searchedString options:0 range: searchedRange];
    NSLog(@"group1: %@", [searchedString substringWithRange:[match rangeAtIndex:1]]);
    return [NSString stringWithFormat:@"%.2f",[[searchedString substringWithRange:[match rangeAtIndex:1]] floatValue]];
}

//*** 金额字段加千位分隔符方法 ***//
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString {
    
    if (digitString.length <= 3) {
        
        return digitString;
        
    } else {
        
        NSMutableString *processString = [NSMutableString stringWithString:digitString];
        
        NSInteger location = processString.length - 3;
        
        NSMutableArray *processArray = [NSMutableArray array];
        
        while (location >= 0) {
            
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            
            [processArray addObject:temp];
            
            if (location < 3 && location > 0) {
                
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                
                [processArray addObject:t];
            }
            location -= 3;
        }
        
        NSMutableArray *resultsArray = [NSMutableArray array];
        
        int k = 0;
        for (NSString *str in processArray) {
            
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            
            if (str.length > 2 && k < processArray.count ) {
                
                [tmp insertString:@"," atIndex:0];
                
                [resultsArray addObject:tmp];
                
            } else {
                
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--) {
            
            NSString *tmp = [resultsArray objectAtIndex:i];
            
            [resultString appendString:tmp];
        }
        return resultString;
    }
}

//*** 获取URL内指定参数 ***//
+ (NSString *)paramValueOfUrl:(NSString *)url withParam:(NSString *)param{
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
         NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
         return tagValue;
    }
    return nil;
}

//*MBProgressBud 文本提示 ***//
+ (void)showProgress:(NSString *)tipStr toView:(UIView *)showView {
    
    //只显示文字
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = tipStr;
    hud.detailsLabelFont = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
    //hud.labelText = tipStr;
    //hud.labelFont = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
    hud.margin = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

@end
