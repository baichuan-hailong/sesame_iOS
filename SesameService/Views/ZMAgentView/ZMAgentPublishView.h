//
//  ZMAgentPublishView.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAgentPublishView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollerView;
@property (nonatomic, strong) UILabel      *titleLable;        //标题
@property (nonatomic, strong) UITextField  *titleText;
@property (nonatomic, strong) UILabel      *areaLable;         //代理区域
@property (nonatomic, strong) UITextField  *areaText;
@property (nonatomic, strong) UILabel      *moneyLable;        //佣金
@property (nonatomic, strong) UITextField  *moneyText;
@property (nonatomic, strong) UILabel      *describeLable;     //项目说明
@property (nonatomic, strong) UITextView   *describeTextView;
@property (nonatomic, strong) UILabel      *connectLable;      //联系人
@property (nonatomic, strong) UITextField  *connectText;
@property (nonatomic, strong) UILabel      *phoneLable;        //联系电话
@property (nonatomic, strong) UITextField  *phoneText;

@property (nonatomic, strong) UIButton     *submitBtn;

@end
