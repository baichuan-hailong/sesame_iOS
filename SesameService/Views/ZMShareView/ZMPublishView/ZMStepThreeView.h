//
//  ZMStepThreeView.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMStepThreeView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;
@property (nonatomic, strong) UILabel      *topLable;
@property (nonatomic, strong) UILabel      *relationLable;    //您与此项目的关系
@property (nonatomic, strong) UITextField  *relationText;
@property (nonatomic, strong) UILabel      *supportLable;     //是否提供其他支持
@property (nonatomic, strong) UITextField  *supportText;
@property (nonatomic, strong) UILabel      *getPriceLable;    //佣金
@property (nonatomic, strong) UITextField  *getPriceText;
@property (nonatomic, strong) UILabel      *describe1Lable;   //说明1
@property (nonatomic, strong) UILabel      *expireLable;      //有效期
@property (nonatomic, strong) UITextField  *expireText;
@property (nonatomic, strong) UILabel      *priceLable;       //价格
@property (nonatomic, strong) UITextField  *priceText;

@property (nonatomic, strong) UILabel      *describe2Lable;   //说明2

@property (nonatomic, strong) UIButton     *submitBtn;

@end
