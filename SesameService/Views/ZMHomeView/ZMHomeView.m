//
//  ZMHomeView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMHomeView.h"
#import "homeBannerCell.h"
#import "homeMenuBtnCell.h"
#import "homeStarVipCell.h"
#import "homeBusinessCell.h"
#import "homeHeadView.h"
#import "homeFootView.h"

@implementation ZMHomeView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.homeCollectionView];
}


#pragma mark - getter
- (UICollectionView *)homeCollectionView {
    
    if (_homeCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing      = 0.0f; //上下
        layout.minimumInteritemSpacing = 0.0f;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:layout];
        _homeCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _homeCollectionView.backgroundColor = [UIColor colorWithHex:backColor];
        _homeCollectionView.alwaysBounceVertical = YES;
        
        //*** 注册自定义Cell ***//
        [_homeCollectionView registerClass:[homeBannerCell   class]   forCellWithReuseIdentifier:@"homeBannerCell"];
        [_homeCollectionView registerClass:[homeMenuBtnCell  class]   forCellWithReuseIdentifier:@"homeMenuBtnCell"];
        [_homeCollectionView registerClass:[homeStarVipCell  class]   forCellWithReuseIdentifier:@"homeStarVipCell"];
        [_homeCollectionView registerClass:[homeBusinessCell class]   forCellWithReuseIdentifier:@"homeBusinessCell"];
        
        [_homeCollectionView registerClass:[homeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeHeadView"];
        [_homeCollectionView registerClass:[homeFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFootView"];
    }
    return _homeCollectionView;
}


@end
