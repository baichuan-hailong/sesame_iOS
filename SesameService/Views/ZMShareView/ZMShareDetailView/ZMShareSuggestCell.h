//
//  ZMShareSuggestCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMShareSuggestCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIView        *backView;
@property (nonatomic, strong) UIImageView   *avatarImage;
@property (nonatomic, strong) UILabel       *nickNameLable;
@property (nonatomic, strong) UIImageView   *certificalImage;
@property (nonatomic, strong) UIImageView   *vipImage;

@property (nonatomic, strong) UILabel       *vipLevel;
@property (nonatomic, strong) UILabel       *telNum;
@property (nonatomic, strong) UILabel       *certifical;

@end
