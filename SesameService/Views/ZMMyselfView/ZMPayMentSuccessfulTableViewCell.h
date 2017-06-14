//
//  ZMPayMentSuccessfulTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPayMentSuccessfulTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;
@property (nonatomic , strong) UILabel     *rightLable;
@property (nonatomic , strong) UIView     *line;
- (void)setAccont:(NSDictionary *)accDic;
@end
