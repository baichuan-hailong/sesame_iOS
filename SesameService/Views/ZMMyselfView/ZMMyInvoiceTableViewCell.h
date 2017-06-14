//
//  ZMMyInvoiceTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMyInvoiceTableViewCell : UITableViewCell


@property (nonatomic , strong) UILabel     *moneyLabel;
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *timeLabel;

@property (nonatomic , strong) UILabel     *stateLabel;

@property (nonatomic , strong) UIView      *line;
- (void)setInvoiceIntro:(NSDictionary *)invoiceDid;

@end
