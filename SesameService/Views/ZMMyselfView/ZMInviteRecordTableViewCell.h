//
//  ZMInviteRecordTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMInviteRecordTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *nameLabel;
@property (nonatomic , strong) UILabel     *telLabel;
@property (nonatomic , strong) UILabel     *timeLabel;

@property (nonatomic , strong) UILabel     *moneyTipLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;

-(void)setRecord:(NSDictionary *)recDic;

@end
