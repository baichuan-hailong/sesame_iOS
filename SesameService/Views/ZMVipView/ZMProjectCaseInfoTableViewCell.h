//
//  ZMProjectCaseInfoTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMProjectCaseInfoTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel          *leftLabel;
@property(nonatomic,strong)UILabel          *rightLabel;


- (void)setCaseInfoCell:(NSDictionary *)caseDic row:(NSInteger)row;
@end
