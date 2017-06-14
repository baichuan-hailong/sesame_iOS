//
//  ZMBuyOneLitterTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMBuyOneLitterTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *buyLabel;
@property (nonatomic , strong) UILabel     *numberLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;


@property (nonatomic , strong) UILabel     *stateLabel;



- (void)setBuyTipOne:(NSDictionary *)dic;
@end
