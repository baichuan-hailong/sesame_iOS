//
//  ZMShareDetailCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMShareDetailCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;
- (void)setValueWithDic:(NSDictionary *)info ofSection:(NSInteger)section;

@property (nonatomic, strong) UIView  *line;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *contentLable;

@end
