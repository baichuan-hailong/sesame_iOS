//
//  UILabel+autoSize.h
//  biufang
//
//  Created by 娄耀文 on 16/12/7.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (autoSize)

/*
 UILable高度动态改变方法
 
 @param:
 
 @lableStr 文本内容
 @font     字体
 @size     最大尺寸
 
 */
- (CGSize)actualSizeOfLable:(NSString *)lableStr
                    andFont:(UIFont   *)font
                    andSize:(CGSize    )size;



/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;


/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


//带有行间距的Label高度
- (CGSize)actualSizeOfLineSpaceLable:(NSString *)lableStr
                             andFont:(UIFont   *)font
                             andSize:(CGSize    )size;

- (CGSize)actualSizeOfLeftLineSpaceLable:(NSString *)lableStr
                                 andFont:(UIFont   *)font
                                 andSize:(CGSize    )size;
//2
- (CGSize)actualSizeOfSpaceLable:(NSString *)lableStr
                         andFont:(UIFont   *)font
                         andSize:(CGSize    )size;
@end
