//
//  ZMLabelAttributeMange.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMLabelAttributeMange : NSObject
+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr;
+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr space:(CGFloat)lineSpacing;
+(void)attributeLabel:(UILabel *)label range:(NSRange)range;
+(void)setLabel:(UILabel *)label text:(NSString *)text hex:(NSString *)hex textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;
@end
