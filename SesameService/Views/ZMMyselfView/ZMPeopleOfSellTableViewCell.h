//
//  ZMPeopleOfSellTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPeopleOfSellTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headerImageViwe;
@property (nonatomic , strong) UIImageView *stateImageView;
//nameLabel
@property (nonatomic , strong) UILabel     *nameLabel;
@property (nonatomic , strong) UIImageView *memberShipImageView;

@property (nonatomic , strong) UIView      *line;
@property (nonatomic , strong) UILabel     *levelLabel;
@property (nonatomic , strong) UILabel     *telLabel;
@property (nonatomic , strong) UILabel     *isCerLabel;

- (void)setAsker:(NSDictionary *)askDic mask:(NSString *)mask;

@end
