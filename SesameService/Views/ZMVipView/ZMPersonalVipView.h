//
//  ZMPersonalVipView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPersonalVipView : UIView

@property(nonatomic,strong)UIView  *topView;
@property(nonatomic,strong)UIView  *topLine;

@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UIImageView      *stateImageView;
@property(nonatomic,strong)UILabel          *nameLabel;


@property (nonatomic , strong)UIImageView   *memberShipImageView;
@property(nonatomic,strong)UILabel          *memberLabel;


@property(nonatomic,strong)UIButton         *evaluationButton;
@property(nonatomic,strong)UITableView      *personalTableView;

- (void)setTopPer:(NSDictionary *)topDic;
@end
