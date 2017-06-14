//
//  ZMCommissionDetailTableHeaderView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCommissionDetailTableHeaderView : UIView
@property(nonatomic,strong)UILabel  *titleLabel;
- (void)settitle:(NSString *)title color:(NSString *)color titleColor:(NSString *)titleColor;
@end
