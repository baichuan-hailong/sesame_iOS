//
//  ZMMyselfPersonTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMyselfPersonTableViewCell : UITableViewCell
//headerImage
@property (nonatomic , strong) UIImageView *headerImageViwe;
//nameLabel
@property (nonatomic , strong) UILabel     *nameLabel;
@property (nonatomic , strong) UILabel    *lookPersonInfoLabel;
@property (nonatomic , strong) UIImageView *memberShipImageView;

@property (nonatomic , strong) UIImageView *stateImageView;

@property (nonatomic , strong) UIImageView *arrowImageView;
- (void)setPersonCell:(NSDictionary *)personDic;
@end
