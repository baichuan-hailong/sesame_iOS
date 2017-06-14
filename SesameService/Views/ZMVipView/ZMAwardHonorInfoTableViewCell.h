//
//  ZMAwardHonorInfoTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAwardHonorInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView          *leftView;
@property(nonatomic,strong)UIView          *rightView;

- (void)setAwardHonor:(NSDictionary *)leftDic right:(NSDictionary *)rightDic;
- (void)setAwardHonor:(NSDictionary *)leftDic;
@end
