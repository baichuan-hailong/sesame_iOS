//
//  ZMTabbar.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMTabbar;

@protocol ZMTabbarDelegate <NSObject>

@optional
- (void)tabBarButtonClick:(ZMTabbar *)tabBar;

@end

@interface ZMTabbar : UITabBar

@property (nonatomic, weak) id<ZMTabbarDelegate> delegate;

@end
