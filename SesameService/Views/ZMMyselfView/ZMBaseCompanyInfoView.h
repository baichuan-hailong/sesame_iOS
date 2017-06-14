//
//  ZMBaseCompanyInfoView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGTextTagCollectionView.h"

@interface ZMBaseCompanyInfoView : UIScrollView
//企业名称
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UITextField *nametextField;

//公司性质
@property(nonatomic,strong)UILabel *xingzhiLabel;
@property(nonatomic,strong)UITextField *companyXingzhitextField;

//所在城市
@property(nonatomic,strong)UILabel *cityLabel;
@property(nonatomic,strong)UITextField *citytextField;


//联系人信息
@property(nonatomic,strong)UIView  *contactView;
@property(nonatomic,strong)UILabel *contactLabel;
//name
@property(nonatomic,strong)UILabel     *contactNameLabel;
@property(nonatomic,strong)UITextField *contactNameextField;
//职务
@property(nonatomic,strong)UILabel     *positionLabel;
@property(nonatomic,strong)UITextField *positionTextField;
//tel
@property(nonatomic,strong)UILabel     *telLabel;
@property(nonatomic,strong)UITextField *telTextField;



@property(nonatomic,strong)UIView  *mainSellView;
@property(nonatomic,strong)UILabel *mainSellLabel;
@property(nonatomic,strong)UIView  *tagBackView;
@property(nonatomic,strong)TTGTextTagCollectionView *tagView;



/** 选择器 */
@property (nonatomic, strong) UIView       *pickerView;
@property (nonatomic, strong) UIPickerView *infoPicker;
@property (nonatomic, strong) UIButton     *confirmBtn;
@property (nonatomic, strong) UIButton     *cancelBtn;


@end
