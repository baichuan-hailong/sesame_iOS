//
//  ZMWordOfMouthTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMStarComponentView.h"

@interface ZMWordOfMouthTableViewCell : UITableViewCell
@property (nonatomic , strong) ZMStarComponentView      *startsView;
@property (nonatomic , strong) UILabel     *topLabel;
@property (nonatomic , strong) UILabel     *timeLabel;
@property (nonatomic , strong) UIImageView *headerImageView;
@property (nonatomic , strong) UILabel     *titleLabel;
@end
