//
//  ZMPublishSuccessViewController.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPublishSuccessViewController : UIViewController

@property (nonatomic, strong) NSString     *from;
@property (nonatomic, strong) NSString     *detailId;
@property (nonatomic, strong) NSDictionary *moreInfoDic;

@property (nonatomic, strong) UIImageView  *topImageView;
@property (nonatomic, strong) UILabel     *titleLable;
@property (nonatomic, strong) UILabel     *tipsLable;

@property (nonatomic, strong) UIButton    *checkBtn;    //查看
@property (nonatomic, strong) UIButton    *perfectBtn;  //完善资料
@property (nonatomic, strong) UIButton    *detailBtn;   //查看详情
@property (nonatomic, strong) UIButton    *againBtn;    //在发一条
@property (nonatomic, strong) UIButton    *backBtn;     //返回首页
@property (nonatomic, strong) UIButton    *callBtn;

@end
