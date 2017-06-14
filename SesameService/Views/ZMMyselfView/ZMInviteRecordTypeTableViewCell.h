//
//  ZMInviteRecordTypeTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/6/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMInviteRecordTypeTableViewCell : UITableViewCell

@property (nonatomic , strong) UILabel     *telLabel;
@property (nonatomic , strong) UILabel     *timeLabel;

@property (nonatomic , strong) UILabel     *moneyTipLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;

-(void)setRecord:(NSDictionary *)recDic;
@end
