//
//  ZMSelectVipTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSelectVipTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UILabel          *nameLabel;
@property(nonatomic,strong)UILabel          *positionLabel;
@property(nonatomic,strong)UILabel          *companyLabel;

@property(nonatomic,strong)UIView      *line;

@property(nonatomic,strong)UIImageView      *stateImageView;
@property (nonatomic , strong)UIImageView   *memberShipImageView;

- (void)setVip:(NSDictionary *)vipDic;
@end
