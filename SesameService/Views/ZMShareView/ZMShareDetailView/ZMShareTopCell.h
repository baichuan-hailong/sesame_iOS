//
//  ZMShareTopCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMShareTopCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIView       *backView;
@property (nonatomic, strong) UILabel      *titleLable;
@property (nonatomic, strong) UILabel      *expireLable;

@end
