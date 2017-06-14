//
//  ZMLabelAttributeMange.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMLabelAttributeMange.h"

@implementation ZMLabelAttributeMange
+(void)attributeLabel:(UILabel *)label range:(NSRange)range{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [label setAttributedText:noteStr];
}

+(void)setLabel:(UILabel *)label text:(NSString *)text hex:(NSString *)hex textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font{
    label.text = text;
    label.textColor = [UIColor colorWithHex:hex];
    label.textAlignment = textAlignment;
    label.font = font;
}

+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr{
    
    label.numberOfLines = 0;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:SCREEN_WIDTH/375*4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [labelStr length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
}
+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr space:(CGFloat)lineSpacing{
    
    label.numberOfLines = 0;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [labelStr length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
}

//计算UILabel的高度(带有行间距的情况)

+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = SCREEN_WIDTH/375*4;//行间距4个像素
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };

    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
}




@end
