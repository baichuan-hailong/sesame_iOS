//
//  ZMVipView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMVipView : UIView
@property(nonatomic,strong)UIButton    *lefrButton;
@property(nonatomic,strong)UIButton    *rightButton;
@property(nonatomic,strong)UIView      *tipLine;

@property(nonatomic,strong)UIScrollView      *bottomScrollView;

@property(nonatomic,strong)UITableView      *leftTableView;
@property(nonatomic,strong)UITableView      *rightTableView;


@property(nonatomic,strong)UIView           *pickBackView;
@property(nonatomic,strong)UIPickerView     *pickView;
@end
