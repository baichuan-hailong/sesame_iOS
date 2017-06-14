//
//  ZMStepOneView.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGTextTagCollectionView.h"

@interface ZMStepOneView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;
@property (nonatomic, strong) UILabel      *topLable;
@property (nonatomic, strong) UILabel      *projectNameLable; //项目名称
@property (nonatomic, strong) UITextField  *projectNameText;
@property (nonatomic, strong) UILabel      *priceLable;       //合同金额
@property (nonatomic, strong) UITextField  *priceText;
@property (nonatomic, strong) UILabel      *cityLable;        //所在城市
@property (nonatomic, strong) UITextField  *cityText;
@property (nonatomic, strong) UILabel      *projectTypeLable; //选择业务类型
@property (nonatomic, strong) UITextField  *projectTypeText;

@property (nonatomic, strong) UILabel                  *choiceLable;    //标签栏
@property (nonatomic, strong) UIView                   *tagBackView;
@property (nonatomic, strong) TTGTextTagCollectionView *tagView;

@property (nonatomic, strong) UILabel      *projectDescribeLable;    //项目描述
@property (nonatomic, strong) UITextView   *projectDescribeTextView;

@property (nonatomic, strong) UIButton     *nextBtn;

@end
