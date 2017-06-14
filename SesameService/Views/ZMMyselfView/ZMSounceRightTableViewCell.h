//
//  ZMSounceRightTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PYPhotoBrowser.h>

@interface ZMSounceRightTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UILabel          *nameLabel;
@property(nonatomic,strong)UIImageView      *memberShipImageView;
@property(nonatomic,strong)UILabel          *moneyLabel;

@property(nonatomic,strong)UILabel          *questionLabel;
@property (nonatomic, strong) PYPhotosView   *photosView;

@property(nonatomic,strong)UIImageView      *stateImageView;
@property(nonatomic,strong)UILabel          *stateLabel;

@property(nonatomic,strong)UIView      *line;

- (void)setMyAnswer:(NSDictionary *)rightDic;

- (void)setMyDetailAnswer:(NSDictionary *)rightDic;
@end
