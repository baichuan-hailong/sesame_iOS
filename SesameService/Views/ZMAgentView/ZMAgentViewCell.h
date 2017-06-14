//
//  ZMAgentViewCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAgentViewCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIView        *backView;

@property (nonatomic, strong) UILabel       *titleLable;      //标题

@property (nonatomic, strong) UIView        *agentAreaView;   //代理区域
@property (nonatomic, strong) UIImageView   *agentAreaImg;
@property (nonatomic, strong) UILabel       *agentAreaLable;
@property (nonatomic, strong) UIView        *agentPriceView;  //代理价格
@property (nonatomic, strong) UIImageView   *agentPriceImg;
@property (nonatomic, strong) UILabel       *agentPriceLable;

@property (nonatomic, strong) UILabel       *detailLable;     //信息

@property (nonatomic, strong) UIView        *footView;
@property (nonatomic, strong) UILabel       *publishLable;



@end
