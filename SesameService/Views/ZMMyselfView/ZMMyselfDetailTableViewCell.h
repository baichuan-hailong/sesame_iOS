//
//  ZMMyselfDetailTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMyselfDetailTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *detailImageView;
@property (nonatomic , strong) UILabel     *detailLabel;
@property (nonatomic , strong) UIImageView *arrowImageView;
@property (nonatomic , strong) UIView      *biuLine;
@property (nonatomic , strong) UILabel     *rightLabel;
- (void)setDetaillCell:(NSDictionary *)dic;
@end
