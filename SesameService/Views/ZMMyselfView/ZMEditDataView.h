//
//  ZMEditDataView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGTextTagCollectionView.h"
@interface ZMEditDataView : UIScrollView


@property(nonatomic,strong)UITextField *nametextField;

@property(nonatomic,strong)UIView      *maleView;
@property(nonatomic,strong)UIView      *femaleView;
@property(nonatomic,strong)UIImageView *maleImageView;
@property(nonatomic,strong)UIImageView *femaleImageView;

@property(nonatomic,strong)UITextField *telTextField;
@property(nonatomic,strong)UITextField *emailTextField;

@property(nonatomic,strong)UITextField *companyTextField;
@property(nonatomic,strong)UITextField *positionTextField;
@property(nonatomic,strong)UITextField *cityTextField;

@property(nonatomic,strong)TTGTextTagCollectionView *tagView;

@property(nonatomic,strong)UIView  *tagBackView;

/** 选择器 */
@property (nonatomic, strong) UIView       *pickerView;
@property (nonatomic, strong) UIPickerView *infoPicker;
@property (nonatomic, strong) UIButton     *confirmBtn;
@property (nonatomic, strong) UIButton     *cancelBtn;
@end
