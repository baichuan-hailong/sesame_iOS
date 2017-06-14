//
//  homeStarVipCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeStarVipCell : UICollectionViewCell <ZYBannerViewDelegate,
                                                   ZYBannerViewDataSource>

- (void)setValueWithArray:(NSArray *)info;

@property (nonatomic, strong) UIView       *backView;

/** contentView */
@property (nonatomic, strong) NSArray      *dataArray;
@property (nonatomic, strong) ZYBannerView *starCycleView;

@end
