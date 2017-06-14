//
//  ZMInvoiceDetailTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMInvoiceDetailTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;
@property (nonatomic , strong) UILabel     *rightLabel;


@property (nonatomic , strong) UIView      *line;
- (void)setInvoiceDetail:(NSDictionary *)invoiceDetailDid;

@end
