//
//  ZMAllUnderStandTopCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/17.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PYPhotoBrowser.h>

@interface ZMAllUnderStandTopCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIImageView    *avatarImage;
@property (nonatomic, strong) UIImageView    *certificalImage;
@property (nonatomic, strong) UIImageView    *vipImage;
@property (nonatomic, strong) UILabel        *nickNameLable;
@property (nonatomic, strong) UILabel        *priceLable;
@property (nonatomic, strong) UILabel        *contentLable;
@property (nonatomic, strong) PYPhotosView   *photosView;
@property (nonatomic, strong) UIImageView    *tipsImage;
@property (nonatomic, strong) UILabel        *tipsLable;


@end
