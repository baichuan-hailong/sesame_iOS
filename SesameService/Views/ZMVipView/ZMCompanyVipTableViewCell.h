//
//  ZMCompanyVipTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGTextTagCollectionView.h"

@interface ZMCompanyVipTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UIImageView      *stateImageView;
@property(nonatomic,strong)UILabel          *companyLabel;
@property (nonatomic , strong)UIImageView   *memberShipImageView;


@property(nonatomic,strong)UILabel          *renameLabel;
@property(nonatomic,strong)UILabel          *listLabel;

@property(nonatomic,strong)TTGTextTagCollectionView *tagView;

@property(nonatomic,strong)UIView      *line;
- (void)setCompanyVip:(NSDictionary *)leftDic mainBizArray:(NSArray *)mainBizArray;
@end
