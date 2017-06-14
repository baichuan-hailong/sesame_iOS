//
//  ZMCommissionDetailMoreTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCommissionDetailMoreTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;
@property (nonatomic , strong) UIImageView *arrowImageView;

@property (nonatomic , strong) UILabel     *rightLabel;
@property (nonatomic , strong) UIView      *line;
- (void)setMoreTiele:(NSDictionary *)dic;
@end
