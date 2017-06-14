//
//  ZMMySounceAnswerTextTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMySounceAnswerTextTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel          *timeLabel;
@property(nonatomic,strong)UILabel          *answerLabel;

- (void)setTextSounce:(NSDictionary *)textDic;
@end
