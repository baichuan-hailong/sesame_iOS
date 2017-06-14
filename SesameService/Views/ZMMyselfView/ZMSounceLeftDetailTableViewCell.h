//
//  ZMSounceLeftDetailTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSounceLeftDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel          *timeLabel;
@property(nonatomic,strong)UILabel          *moneyLabel;

@property(nonatomic,strong)UILabel          *questionLabel;

@property(nonatomic,strong)UIImageView      *stateImageView;
@property(nonatomic,strong)UILabel          *stateLabel;

@property(nonatomic,strong)UIButton         *bottomButton;

@property(nonatomic,strong)UILabel          *noteLabel;

- (void)setMyAsk:(NSDictionary *)leftDic;
@end
