//
//  ZMMyAllUnderStandTopCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/5/12.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PYPhotoBrowser.h>

@interface ZMMyAllUnderStandTopCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UILabel      *timeLable;
@property (nonatomic, strong) UILabel      *priceLable;
@property (nonatomic, strong) UILabel      *contentLable;
@property (nonatomic, strong) PYPhotosView *photosView;
@property (nonatomic, strong) UIImageView  *tipsImage;
@property (nonatomic, strong) UILabel      *tipsLable;
@property (nonatomic, strong) UILabel      *endTipsLable;
@property (nonatomic, strong) UIButton     *cancelBtn;


@end
