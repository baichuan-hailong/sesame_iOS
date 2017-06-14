//
//  ZMMyCreditRightTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMyCreditRightTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *detailLabel;
@property (nonatomic , strong) UIImageView *arrowImageView;
@property (nonatomic , strong) UIView      *biuLine;
@property (nonatomic , strong) UILabel     *rightLabel;
- (void)setDetaillCell:(NSDictionary *)dic;
@end
