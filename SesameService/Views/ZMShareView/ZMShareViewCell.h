//
//  ZMShareViewCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMShareViewCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIView        *backView;

@property (nonatomic, strong) UIImageView   *avatarImage;
@property (nonatomic, strong) UILabel       *nickNameLable;
@property (nonatomic, strong) UIImageView   *certificalImage;
@property (nonatomic, strong) UIImageView   *vipImage;

@property (nonatomic, strong) UILabel       *titleLable;      //标题
@property (nonatomic, strong) UILabel       *detailLable;     //信息
@property (nonatomic, strong) UILabel       *contentLable;    //内容

@property (nonatomic, strong) UIImageView   *lineImage;       //分割线
@property (nonatomic, strong) UILabel       *unitPrice;       //单价
@property (nonatomic, strong) UIButton      *buyBtn;          //购买按钮


@end
