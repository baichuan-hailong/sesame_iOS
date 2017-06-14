//
//  ZMOrderProgressTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/17.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMOrderProgressTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *timeLabel;
@property (nonatomic , strong) UILabel     *noteLabel;
@property (nonatomic , strong) UIView      *leftPoint;
@property (nonatomic , strong) UIView      *leftLine;
@property (nonatomic , strong) UIView      *botLine;

@property (nonatomic , strong) UIView      *shutterView;

- (void)setOrProNote:(NSDictionary *)noteDic;
@end
