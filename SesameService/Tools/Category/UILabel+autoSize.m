//
//  UILabel+autoSize.m
//  biufang
//
//  Created by 娄耀文 on 16/12/7.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "UILabel+autoSize.h"

@implementation UILabel (autoSize)

- (CGSize)actualSizeOfLable:(NSString *)lableStr
                    andFont:(UIFont   *)font
                    andSize:(CGSize    )size {
    
    self.font    = font;
    self.text    = lableStr;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize actualSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return actualSize;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}




//带有行间距的Label高度
- (CGSize)actualSizeOfLineSpaceLable:(NSString *)lableStr
                    andFont:(UIFont   *)font
                    andSize:(CGSize    )size {
    
    self.font    = font;
    self.text    = lableStr;
    
    
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /*
     paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
     paraStyle.hyphenationFactor = 1.0;
     
     paraStyle.firstLineHeadIndent = 0.0;
     
     paraStyle.paragraphSpacingBefore = 0.0;
     
     
     
     paraStyle.tailIndent = 0;
     */
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.headIndent = 0;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = SCREEN_WIDTH/375*4;
    
    
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize actualSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return actualSize;
}

- (CGSize)actualSizeOfLeftLineSpaceLable:(NSString *)lableStr
                             andFont:(UIFont   *)font
                             andSize:(CGSize    )size {
    
    self.font    = font;
    self.text    = lableStr;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 1;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize actualSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return actualSize;
}


- (CGSize)actualSizeOfSpaceLable:(NSString *)lableStr
                             andFont:(UIFont   *)font
                             andSize:(CGSize    )size {
    
    self.font    = font;
    self.text    = lableStr;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = SCREEN_WIDTH/375*2;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize actualSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return actualSize;
}

@end
