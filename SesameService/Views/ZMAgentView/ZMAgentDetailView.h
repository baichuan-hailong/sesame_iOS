//
//  ZMAgentDetailView.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGTextTagCollectionView.h"

@interface ZMAgentDetailView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;

@property (nonatomic, strong) UIView       *topView;
@property (nonatomic, strong) UIImageView  *avatarImage;
@property (nonatomic, strong) UIImageView  *vipImage;
@property (nonatomic, strong) UILabel      *companyLable;
@property (nonatomic, strong) UILabel      *creditLable;
@property (nonatomic, strong) UILabel      *starTipsLable;
@property (nonatomic, strong) UIView       *starView;
@property (nonatomic, strong) TTGTextTagCollectionView *tagView;


@property (nonatomic, strong) UIView       *footView;
@property (nonatomic, strong) UILabel      *titleLable;
@property (nonatomic, strong) UIImageView  *tipsImage1;
@property (nonatomic, strong) UIImageView  *tipsImage2;
@property (nonatomic, strong) UIImageView  *tipsImage3;
@property (nonatomic, strong) UIImageView  *tipsImage4;
@property (nonatomic, strong) UILabel      *cityLable;
@property (nonatomic, strong) UILabel      *moneyLable;
@property (nonatomic, strong) UILabel      *connectLable;
@property (nonatomic, strong) UILabel      *phoneLable;
@property (nonatomic, strong) UILabel      *detailLable;


@property (nonatomic, strong) UIView       *timeView;
@property (nonatomic, strong) UILabel      *timeLable;




@end
