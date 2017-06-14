//
//  ZMPayTypeTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPayTypeTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *payImageView;
@property (nonatomic , strong) UILabel     *payLabel;
@property (nonatomic , strong) UIImageView *arrowImageView;
@property (nonatomic , strong) UIView      *line;
- (void)setPayType:(NSDictionary *)dic;
@end
