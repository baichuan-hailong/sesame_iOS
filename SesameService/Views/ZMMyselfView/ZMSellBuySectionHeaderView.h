//
//  ZMSellBuySectionHeaderView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSellBuySectionHeaderView : UIView
@property(nonatomic,strong)UILabel  *titleLabel;
@property(nonatomic,strong)UIButton *changeBtn;

- (void)settitle:(NSString *)title;
@end
