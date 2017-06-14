//
//  ZMAwardHonorShowTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/31.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAwardHonorShowTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *line;
@property (nonatomic , strong) UIImageView *awardImageView;
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *timeLabel;
@property (nonatomic , strong) UIButton    *deleteBtn;
- (void)setAwardHonor:(NSDictionary *)awardDic;
@end
