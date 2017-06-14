//
//  ZMTradingOrderTopTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMTradingOrderTopTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;
@property (nonatomic , strong) UILabel     *rightLabel;
- (void)setDetail:(NSDictionary *)detailDid;
@end
