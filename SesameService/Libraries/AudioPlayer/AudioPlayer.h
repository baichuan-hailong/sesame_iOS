//
//  AudioPlayer.h
//  SesameService
//
//  Created by 娄耀文 on 17/5/9.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayer : NSObject

+ (AudioPlayer *)sharedManager;
- (void)playRecord:(NSString *)audioUrl withBtn:(UIButton *)audioBtn;     //播放录音
- (void)stopPlayRecord:(UIButton *)audioBtn; //停止播放

@end
