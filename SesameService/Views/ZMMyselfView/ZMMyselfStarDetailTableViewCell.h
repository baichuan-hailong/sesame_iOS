//
//  ZMMyselfStarDetailTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/14.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMStarComponentView.h"

@interface ZMMyselfStarDetailTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *detailImageView;
@property (nonatomic , strong) UILabel     *detailLabel;
@property (nonatomic , strong) UIImageView *arrowImageView;
@property (nonatomic , strong) UIView      *biuLine;
@property (nonatomic , strong) ZMStarComponentView     *starView;
- (void)setDetaillCell:(NSDictionary *)dic;
@end
