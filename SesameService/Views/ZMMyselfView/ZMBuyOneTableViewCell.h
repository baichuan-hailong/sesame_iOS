//
//  ZMBuyOneTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMBuyOneTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *buyLabel;
@property (nonatomic , strong) UILabel     *numberLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;


@property (nonatomic , strong) UIImageView *lineImg;

@property (nonatomic , strong) UILabel     *stateLabel;

@property (nonatomic , strong) UIButton    *tousuBtn;
@property (nonatomic , strong) UIButton    *pingjiaBtn;

- (void)setBuyTipOne:(NSDictionary *)dic;
@end
