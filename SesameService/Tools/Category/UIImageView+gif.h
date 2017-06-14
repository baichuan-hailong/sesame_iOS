//
//  UIImageView+gif.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (gif)

-(void)getGifImageWithUrk:(NSURL *)url
               returnData:(void(^)(NSArray<UIImage *> * imageArray,
                                   NSArray<NSNumber *>*timeArray,
                                   CGFloat totalTime,
                                   NSArray<NSNumber *>* widths,
                                   NSArray<NSNumber *>* heights))dataBlock;

-(void)yh_setImage:(NSURL *)imageUrl;

@end
