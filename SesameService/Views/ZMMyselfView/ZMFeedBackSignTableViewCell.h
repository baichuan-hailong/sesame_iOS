//
//  ZMFeedBackSignTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/6/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMFeedBackSignTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;
@property (nonatomic , strong) UILabel     *rightLabel;

@property (nonatomic , strong) UIView      *line;

- (void)setFeedBack:(NSDictionary *)dic;

@end
