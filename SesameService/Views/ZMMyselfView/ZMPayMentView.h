//
//  ZMPayMentView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPayMentView : UIView

//收款方式
@property (nonatomic , strong) UILabel     *collectionTypeLabel;
@property (nonatomic , strong) UILabel     *collectionLabel;

//收款人
@property (nonatomic , strong) UILabel     *personLabel;
@property (nonatomic , strong) UILabel     *personContentLabel;

//账号
@property (nonatomic , strong) UILabel     *accountLabel;
@property (nonatomic , strong) UILabel     *accountContentLabel;

//手机号
@property (nonatomic , strong) UILabel     *telLabel;
@property (nonatomic , strong) UILabel     *telContentLabel;

//change
@property (nonatomic , strong) UIButton    *changeButton;




@end
