//
//  ZMAimAnswererInfoTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAimAnswererInfoTableViewCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIImageView    *avatarImage;
@property (nonatomic, strong) UILabel        *nickNameLable;
@property (nonatomic, strong) UIImageView    *certificalImage;
@property (nonatomic, strong) UIImageView    *vipImage;
@property (nonatomic, strong) UILabel        *companyLable;

@end
