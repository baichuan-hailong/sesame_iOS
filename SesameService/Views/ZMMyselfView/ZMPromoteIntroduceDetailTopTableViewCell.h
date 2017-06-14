//
//  ZMPromoteIntroduceDetailTopTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPromoteIntroduceDetailTopTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *timeLabel;
@property (nonatomic , strong) UILabel     *closeLabel;

@property (nonatomic , strong) UILabel     *stateLabel;

- (void)setTopDetail:(NSDictionary *)dic isLeft:(BOOL)isLeft;
@end
