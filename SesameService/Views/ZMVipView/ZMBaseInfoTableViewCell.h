//
//  ZMBaseInfoTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMBaseInfoTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel          *leftLabel;
@property(nonatomic,strong)UILabel          *rightLabel;
@property(nonatomic,strong)UIView           *line;

- (void)setBaseInfoCell:(NSDictionary *)baseDic;
@end
