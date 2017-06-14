//
//  ZMMyPayMentAccountView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMyPayMentAccountView : UIScrollView

//户名
@property (nonatomic , strong) UILabel     *collectionTypeLabel;
@property (nonatomic , strong) UITextField *collectionTypeView;


//银行名称
@property (nonatomic , strong) UILabel     *personRealNameLabel;
@property (nonatomic , strong) UITextField *personRealNameTextField;

//银行卡号
@property (nonatomic , strong) UILabel     *accountLabel;
@property (nonatomic , strong) UITextField *accountTextField;

//开户行
@property (nonatomic , strong) UILabel     *telLabel;
@property (nonatomic , strong) UITextField *telTextField;

@property (nonatomic , strong) UILabel     *tipLabel;
@end
