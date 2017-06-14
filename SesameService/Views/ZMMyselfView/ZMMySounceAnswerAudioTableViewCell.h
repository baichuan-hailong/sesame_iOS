//
//  ZMMySounceAnswerAudioTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMMySounceAnswerAudioTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel          *timeLabel;
//voiceBtn
@property(nonatomic,strong)UIButton          *voiceBtn;

@property(nonatomic,strong)UILabel          *countLabel;

- (void)setAudo:(NSDictionary *)audioDic;
@end
