//
//  ZMMySellSecondPartyATableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/18.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMySellSecondPartyATableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;
@property (nonatomic , strong) UILabel     *rightLabel;
@property (nonatomic , strong) UILabel     *rightTitleLabel;
@property (nonatomic , strong) UILabel     *rightDownLabel;


@property (nonatomic , strong) UIView      *line;
- (void)setInvoiceDetail:(NSDictionary *)invoiceDetailDid;
@end
