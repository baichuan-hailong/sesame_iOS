//
//  ZMUserDataHeaderTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMUserDataHeaderTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;

@property (nonatomic , strong) UIImageView *headerImageView;

@property (nonatomic , strong) UIImageView *arrowImageView;

- (void)setAvatar:(NSString *)userType;
@end
