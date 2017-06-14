//
//  ZMCommissionView.h
//  SesameService
//
//  Created by 娄耀文 on 17/5/4.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCommissionPublishView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;
@property (nonatomic, strong) UILabel      *topLable;

@property (nonatomic, strong) UILabel      *projectNameLable;  //项目名称
@property (nonatomic, strong) UITextField  *projectNameText;
@property (nonatomic, strong) UILabel      *projectType;       //项目类型
@property (nonatomic, strong) UITextField  *projectTypeText;
@property (nonatomic, strong) UILabel      *cityLable;         //所在区域
@property (nonatomic, strong) UITextField  *cityText;
@property (nonatomic, strong) UILabel      *projectPriceLable; //预估项目标的额
@property (nonatomic, strong) UITextField  *projectPriceText;

@property (nonatomic, strong) UILabel      *commissionLable;   //期望佣金
@property (nonatomic, strong) UIButton     *funcBtn1;
@property (nonatomic, strong) UIButton     *funcBtn2;
@property (nonatomic, strong) UIButton     *funcBtn3;
@property (nonatomic, strong) UIButton     *funcBtn4;
@property (nonatomic, strong) UILabel      *priceLable;         //填写佣金
@property (nonatomic, strong) UITextField  *priceText;

@property (nonatomic, strong) UILabel      *projectDescribeLable;    //项目描述
@property (nonatomic, strong) UITextView   *projectDescribeTextView;
@property (nonatomic, strong) UILabel      *placeholderLable;
@property (nonatomic,strong ) UILabel      *worldCountLabel;

@property (nonatomic, strong) UIButton     *nextBtn;

/** 选择器 */
@property (nonatomic, strong) UIView       *pickerView;
@property (nonatomic, strong) UIPickerView *infoPicker;
@property (nonatomic, strong) UIButton     *confirmBtn;
@property (nonatomic, strong) UIButton     *cancelBtn;

@end
