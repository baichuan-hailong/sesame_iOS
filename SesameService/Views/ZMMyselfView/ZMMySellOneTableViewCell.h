//
//  ZMMySellOneTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMySellOneTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *comTimeLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;


@property (nonatomic , strong) UIImageView *lineImg;

@property (nonatomic , strong) UILabel     *stateLabel;
@property (nonatomic , strong) UIButton    *cancleBtn;

@property (nonatomic , strong) UILabel     *leftTipLabel;
@property (nonatomic , strong) UILabel     *rightTipLabel;


- (void)setSellOne:(NSDictionary *)dic;
@end
