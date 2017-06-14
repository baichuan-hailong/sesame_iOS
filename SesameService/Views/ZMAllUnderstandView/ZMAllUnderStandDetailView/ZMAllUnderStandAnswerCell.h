//
//  ZMAllUnderStandAnswerCell.h
//  SesameService
//
//  Created by 娄耀文 on 17/4/18.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAllUnderStandAnswerCell : UITableViewCell

- (void)setValueWithDic:(NSDictionary *)info;

@property (nonatomic, strong) UIImageView    *avatarImage;
@property (nonatomic, strong) UILabel        *nickNameLable;
@property (nonatomic, strong) UIImageView    *certificalImage;
@property (nonatomic, strong) UIImageView    *vipImage;
@property (nonatomic, strong) UILabel        *timeLable;
@property (nonatomic, strong) UILabel        *companyLable;

/** 语音 */
@property (nonatomic, strong) UIView         *voiceView;
@property (nonatomic, strong) UIButton       *voiceBtn;
@property (nonatomic, strong) UILabel        *voiceLable;
@property (nonatomic, strong) UILabel        *secondLable;

/** 文字 */
@property (nonatomic, strong) UILabel        *contentLable;

/** 赏金 */
@property (nonatomic, strong) UILabel        *priceLable;

/** 选择答案按钮 */
@property (nonatomic, strong) UIButton       *getBtn;



@end
