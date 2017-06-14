//
//  ZMStepTwoView.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMStepTwoView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;
@property (nonatomic, strong) UILabel      *topLable;
@property (nonatomic, strong) UILabel      *nameLable;        //客户名称
@property (nonatomic, strong) UITextField  *nameText;
@property (nonatomic, strong) UILabel      *connectLable;     //项目联系人
@property (nonatomic, strong) UITextField  *connectText;
@property (nonatomic, strong) UILabel      *telNumLable;      //联系电话
@property (nonatomic, strong) UITextField  *telNumText;
@property (nonatomic, strong) UILabel      *requireLable;     //客户对服务商行业排名的要求
@property (nonatomic, strong) UITextField  *requireText;

@property (nonatomic, strong) UILabel      *describeLable;    //其他说明（选填）
@property (nonatomic, strong) UITextView   *describeTextView;

@property (nonatomic, strong) UIButton     *nextBtn;

@end
