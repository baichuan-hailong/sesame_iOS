//
//  ZMUserDataCerTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMUserDataCerTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *leftLabel;

@property (nonatomic , strong) UILabel     *rightLabel;

@property (nonatomic , strong) UIImageView *arrowImageView;

- (void)setMoreTiele:(NSDictionary *)dic;

@end
