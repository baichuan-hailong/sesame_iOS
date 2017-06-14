//
//  ZMInvitationMoneyTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMInvitationMoneyTableViewCell : UITableViewCell
//84
@property (nonatomic , strong) UILabel     *countLabel;
@property (nonatomic , strong) UILabel     *countTipLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;
@property (nonatomic , strong) UILabel     *moneyTipLabel;

- (void)setTopMoney:(NSDictionary *)topDic;
@end
