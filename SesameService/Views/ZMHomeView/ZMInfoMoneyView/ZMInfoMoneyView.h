//
//  ZMInfoMoneyView.h
//  SesameService
//
//  Created by 娄耀文 on 17/5/4.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMInfoMoneyView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;

/** 项目信息 */
@property (nonatomic, strong) UILabel      *projectNameLable;  //项目名称
@property (nonatomic, strong) UITextField  *projectNameText;
@property (nonatomic, strong) UILabel      *cityLable;         //所在区域
@property (nonatomic, strong) UITextField  *cityText;
@property (nonatomic, strong) UILabel      *projectType;       //项目类型
@property (nonatomic, strong) UITextField  *projectTypeText;
@property (nonatomic, strong) UILabel      *projectPriceLable; //预估项目标的额
@property (nonatomic, strong) UITextField  *projectPriceText;
@property (nonatomic, strong) UILabel      *tipsLable1;
@property (nonatomic, strong) UILabel      *expireTimeLable;   //消息有效期
@property (nonatomic, strong) UITextField  *expireTimeText;

/** 甲方联系人 */
@property (nonatomic, strong) UILabel      *titleViewLable;
@property (nonatomic, strong) UILabel      *nameLable;      //项目名称
@property (nonatomic, strong) UITextField  *nameText;
@property (nonatomic, strong) UILabel      *positionLable;  //项目名称
@property (nonatomic, strong) UITextField  *positionText;
@property (nonatomic, strong) UILabel      *telLable;       //项目名称
@property (nonatomic, strong) UITextField  *telText;
@property (nonatomic, strong) UILabel      *tipsLable2;


/** 项目说明 */
@property (nonatomic, strong) UIView       *titleView2;
@property (nonatomic, strong) UILabel      *projectDescribeLable;    //项目描述
@property (nonatomic, strong) UITextView   *projectDescribeTextView;
@property (nonatomic, strong) UILabel      *placeholderLable;
@property (nonatomic,strong ) UILabel      *worldCountLabel;

@property (nonatomic, strong) UILabel      *supportLable;            //项目名称
@property (nonatomic, strong) UITextField  *supportText;
@property (nonatomic, strong) UILabel      *tipsLable3;

/** 发布信息 */
@property (nonatomic, strong) UIView       *titleView3;
@property (nonatomic, strong) UILabel      *basePriceTips;
@property (nonatomic, strong) UILabel      *basePriceLable;
@property (nonatomic, strong) UILabel      *tipsLable4;
@property (nonatomic, strong) UIButton     *choiceBtn;
@property (nonatomic, strong) UIButton     *nextBtn;

/** 选择器 */
@property (nonatomic, strong) UIView       *pickerView;
@property (nonatomic, strong) UIPickerView *infoPicker;
@property (nonatomic, strong) UIButton     *confirmBtn;
@property (nonatomic, strong) UIButton     *cancelBtn;

/** 时间选择器 */
@property (nonatomic, strong) UIView       *timeView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton     *timeConfirmBtn;
@property (nonatomic, strong) UIButton     *timeCancelBtn;




@end
