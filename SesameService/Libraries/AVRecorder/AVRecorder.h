//
//  AVRecorder.h
//  SesameService
//
//  Created by 娄耀文 on 17/3/16.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVRecorder : NSObject

- (void)startRecord;    //开始录音
- (void)stopRecord;     //结束录音
- (void)playRecord;     //播放录音
- (void)stopPlayRecord; //停止播放
- (void)repeatRecord;   //重新录制
- (void)postRecord;     //发送录音

@end
