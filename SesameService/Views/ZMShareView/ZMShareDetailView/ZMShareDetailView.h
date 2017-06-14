//
//  ZMShareDetailView.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMShareDetailView : UIView

@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic, strong) UIView      *footView;
@property (nonatomic, strong) UILabel     *priceLable;
@property (nonatomic, strong) UIButton    *serviceBtn;
@property (nonatomic, strong) UIButton    *buyBtn;


@end
