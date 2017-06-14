//
//  ZMprojectCaseShowTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/31.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMprojectCaseShowTableViewCell : UITableViewCell
//@property (nonatomic , strong) UILabel     *nameLabel;
@property(nonatomic,strong)UIView *line;
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *timeLabel;
@property (nonatomic , strong) UIButton    *deleteBtn;
- (void)setProjectCase:(NSDictionary *)caseDic;
@end
