//
//  ZMInformationTranTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMInformationTranTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;

@property (nonatomic , strong) UILabel     *moneyLabel;

@property (nonatomic , strong) UILabel     *bottonLabel;
@property (nonatomic , strong) UILabel     *rightLabel;

@property (nonatomic , strong) UIView      *line;

- (void)setInfoTran:(NSDictionary *)dic isLeft:(BOOL)isleft;
@end
