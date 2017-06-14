//
//  homeMenuBtnCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeMenuBtnCell : UICollectionViewCell

@property (nonatomic, strong) UIView   *backView;

@property (nonatomic, strong) UIButton *infoMoneyBtn;   //赚信息费
@property (nonatomic, strong) UIButton *commissionBtn;  //赚佣金
@property (nonatomic, strong) UIButton *marketingBtn;   //赚推介费
@property (nonatomic, strong) UIButton *findBtn;        //包打听
@property (nonatomic, strong) UIButton *guideBtn;       //新手指南
@property (nonatomic, strong) UIButton *serviceBtn;     //在线客服

@end
