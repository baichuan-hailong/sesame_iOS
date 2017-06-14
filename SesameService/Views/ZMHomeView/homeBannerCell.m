//
//  homeBannerCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "homeBannerCell.h"

@implementation homeBannerCell


- (void)setValueWithArray:(NSArray *)info {

    if (info != nil) {
        
        NSArray *imgArr = (NSArray *)info;
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0; i < imgArr.count; i++) {
            NSString *imgStr   = [NSString stringWithFormat:@"%@",[imgArr objectAt:i][@"image"]];
            [images addObject:imgStr];
        }
        self.dataArray = (NSArray *)images;
        
        [self.bannerView reloadData];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:backColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.bannerView];
        
    }
    return self;
}


- (UIView *)backView {

    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.83)];
        _backView.backgroundColor = [UIColor colorWithHex:@"00bf8f"];
    }
    return _backView;
}

- (ZYBannerView *)bannerView {
    
    if (_bannerView == nil) {
        
        _bannerView = [[ZYBannerView alloc] init];
        _bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.backView.frame.size.height);
        _bannerView.tag        = 1001;
        _bannerView.dataSource = self;
        _bannerView.showFooter = NO;
        _bannerView.shouldLoop = YES;
        _bannerView.autoScroll = YES;
        _bannerView.collectionView.pagingEnabled = YES;
        _bannerView.collectionView.backgroundColor = [UIColor colorWithHex:backColor];
        _bannerView.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, self.backView.frame.size.height);
    }
    return _bannerView;
}


#pragma mark - ZYBannerViewDataSource
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner{
    return self.dataArray.count;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0,0, SCREEN_WIDTH, self.backView.frame.size.height);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.backgroundColor = [UIColor colorWithHex:backColor];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.dataArray objectAt:index]] placeholderImage:[UIImage imageNamed:@""]];
    
    return imageView;
}

- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState {
    
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}




@end
