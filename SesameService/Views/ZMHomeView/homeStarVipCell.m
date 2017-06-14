//
//  homeStarVipCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "homeStarVipCell.h"

@implementation homeStarVipCell

- (void)setValueWithArray:(NSArray *)info {
    
    //NSLog(@"~~~~~~%@",info);
    self.dataArray = (NSArray *)info;
    
//    self.dataArray = @[@"http://sc.jb51.net/uploads/allimg/150709/14-150FZ94211O4.jpg",
//                       @"http://img1.3lian.com/2015/w7/98/d/84.jpg",
//                       @"http://img4.duitang.com/uploads/blog/201311/13/20131113184407_WsxaM.jpeg",
//                       @"http://img1.3lian.com/2015/a1/22/d/186.jpg",
//                       @"http://t1.niutuku.com/960/32/32-321326.jpg",
//                       @"http://img1.3lian.com/2015/a1/114/d/70.jpg",
//                       @"http://sc.jb51.net/uploads/allimg/150709/14-150FZ94211O4.jpg",
//                       @"http://img1.3lian.com/2015/w7/98/d/84.jpg",
//                       @"http://img4.duitang.com/uploads/blog/201311/13/20131113184407_WsxaM.jpeg",
//                       @"http://img1.3lian.com/2015/a1/22/d/186.jpg",
//                       @"http://t1.niutuku.com/960/32/32-321326.jpg",
//                       @"http://img1.3lian.com/2015/a1/114/d/70.jpg"];
    
    [self.starCycleView reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:backColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.starCycleView];
        
    }
    return self;
}

- (UIView *)backView {
    
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.57)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}


/** cycleView */
- (ZYBannerView *)starCycleView {
    
    if (_starCycleView == nil) {
        
        _starCycleView = [[ZYBannerView alloc] init];
        _starCycleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.57);
        _starCycleView.tag        = 1002;
        _starCycleView.dataSource = self;
        _starCycleView.showFooter = NO;
        _starCycleView.shouldLoop = NO;
        _starCycleView.autoScroll = NO;
        _starCycleView.collectionView.pagingEnabled = NO;
        _starCycleView.pageControl.alpha = 0;
        _starCycleView.backgroundColor = [UIColor whiteColor];
        _starCycleView.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3.26, SCREEN_WIDTH/2.57);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _starCycleView.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        [_starCycleView addSubview:line];
    }
    return _starCycleView;
}


#pragma mark - ZYBannerViewDataSource
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner{
    return self.dataArray.count;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    
    //背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3.26, self.starCycleView.frame.size.height)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH/3.26 - 10, self.starCycleView.frame.size.height - 10)];
    mainView.backgroundColor = [UIColor colorWithHex:@"fafafa"];
    mainView.layer.cornerRadius = 4;
    [backView addSubview:mainView];
    
    //头像
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake((mainView.frame.size.width - SCREEN_WIDTH/6.82)/2,
                                 SCREEN_WIDTH/31.25,
                                 SCREEN_WIDTH/6.82,
                                 SCREEN_WIDTH/6.82);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 2;
    imageView.layer.borderColor = [UIColor colorWithHex:@"bbbbbb"].CGColor;
    imageView.layer.borderWidth = 0.5;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"avatar"]]]
                 placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
    
    //姓名
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.frame = CGRectMake(5, CGRectGetMaxY(imageView.frame) + 5, mainView.frame.size.width - 10, SCREEN_WIDTH/28.85);
    nameLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85 weight:3];
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.textColor = [UIColor colorWithHex:@"333333"];
    if ([[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"type"]] isEqualToString:@"1"]) {
        nameLable.alpha = 1;
    } else {
        nameLable.alpha = 0;
    }
    nameLable.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"person_name"]];
    
    
    //企业会员
    UILabel *company = [[UILabel alloc] init];
    company.numberOfLines = 0;
    company.textAlignment = NSTextAlignmentCenter;
    company.textColor = [UIColor colorWithHex:@"333333"];
    
    CGSize companySize1 = CGSizeMake(mainView.frame.size.width - 10, 0);
    CGSize companyAutoSize1 = [company actualSizeOfLable:[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"corp_name"]]
                                                 andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85 weight:3] andSize:companySize1];
    company.frame = CGRectMake(5,
                               CGRectGetMaxY(imageView.frame) + 5,
                               mainView.frame.size.width - 10,
                               companyAutoSize1.height);
    if ([[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"type"]] isEqualToString:@"1"]) {
        company.alpha = 0;
    } else {
        company.alpha = 1;
    }
    
    
    
    //职位
    UILabel *posiLable = [[UILabel alloc] init];
    posiLable.frame = CGRectMake(5, CGRectGetMaxY(nameLable.frame) + 5, mainView.frame.size.width - 10, SCREEN_WIDTH/28.85);
    posiLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/34.1];
    posiLable.textAlignment = NSTextAlignmentCenter;
    posiLable.textColor = [UIColor colorWithHex:@"333333"];
    if ([[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"type"]] isEqualToString:@"1"]) {
        posiLable.alpha = 1;
    } else {
        posiLable.alpha = 0;
    }
    posiLable.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"title"]];
    
    //公司
    UILabel *companyLable = [[UILabel alloc] init];
    companyLable.numberOfLines = 0;
    companyLable.textAlignment = NSTextAlignmentCenter;
    companyLable.textColor = [UIColor colorWithHex:@"989BA4"];
    
    CGSize companySize2 = CGSizeMake(mainView.frame.size.width - 10, 0);
    CGSize companyAutoSize2 = [companyLable actualSizeOfLable:[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"corp_name"]]
                                                      andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/37.5] andSize:companySize2];
    companyLable.frame = CGRectMake(5,
                                    CGRectGetMaxY(posiLable.frame) + 5,
                                    mainView.frame.size.width - 10,
                                    companyAutoSize2.height);
    if ([[NSString stringWithFormat:@"%@",[self.dataArray objectAt:index][@"type"]] isEqualToString:@"1"]) {
        companyLable.alpha = 1;
    } else {
        companyLable.alpha = 0;
    }
    
    
    [mainView addSubview:imageView];
    [mainView addSubview:nameLable];
    [mainView addSubview:posiLable];
    [mainView addSubview:companyLable];
    [mainView addSubview:company];
    return backView;
}

- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState {
    
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动查看更多";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放查看更多";
    }
    return nil;
}


@end
