//
//  ZMPostEvaluationView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMEvaluationView.h"

@interface ZMPostEvaluationView : UIScrollView


@property(nonatomic,strong)UITextView *suggestTextView;
@property(nonatomic,strong)UILabel    *suggestPlaceHolderLabel;
@property(nonatomic,strong)UILabel    *worldCountLabel;

@property(nonatomic,strong)UIButton    *commitButton;

@property(nonatomic,strong)ZMEvaluationView *goodBtn;
@property(nonatomic,strong)ZMEvaluationView *zhongpingBtn;
@property(nonatomic,strong)ZMEvaluationView *chapingBtn;

//信息
@property(nonatomic,strong)UIView           *startxinxiView;
@property(nonatomic,strong)NSMutableArray   *starxinxiArray;

//关系
@property(nonatomic,strong)UIView           *startgaunxiView;
@property(nonatomic,strong)NSMutableArray   *starguanxiArray;

//价格
@property(nonatomic,strong)UIView           *startjiageView;
@property(nonatomic,strong)NSMutableArray   *starjiageArray;

//项目
@property(nonatomic,strong)UIView           *startxiangmuView;
@property(nonatomic,strong)NSMutableArray   *starxiangmuArray;

@end
