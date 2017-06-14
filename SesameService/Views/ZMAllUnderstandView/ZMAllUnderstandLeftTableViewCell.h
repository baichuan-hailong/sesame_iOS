//
//  ZMAllUnderstandLeftTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAllUnderstandLeftTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UIImageView      *stateImageView;

@property(nonatomic,strong)UILabel          *nameLabel;
@property (nonatomic , strong)UIImageView   *memberShipImageView;

@property(nonatomic,strong)UILabel          *moneyLabel;
@property(nonatomic,strong)UILabel          *answerLabel;

@property(nonatomic,strong)UILabel          *questionLabel;
@property(nonatomic,strong)UILabel          *stateLabel;

- (void)setLeftAllUnderstan:(NSDictionary *)leftDic;

@end
