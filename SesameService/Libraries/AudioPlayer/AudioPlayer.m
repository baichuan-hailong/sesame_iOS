//
//  AudioPlayer.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/9.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer () <AVAudioPlayerDelegate>

/** 播放 **/
@property (nonatomic, strong) AVAudioPlayer    *player;
/** 定时器 **/
@property (nonatomic, strong) NSTimer          *timer;
/** 录音url **/
@property (nonatomic, strong) NSString         *playName;

@property (nonatomic, strong) UIButton                     *lastBtn;
@property (nonatomic, strong) UIImageView                  *voiceImageView;
@property (nonatomic, strong) UIActivityIndicatorView      *loadingView;
@property (nonatomic, strong) UIImageView                  *gifImageView;

@end

@implementation AudioPlayer

+ (AudioPlayer *)sharedManager {
    
    static AudioPlayer *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)playRecord:(NSString *)audioUrl withBtn:(UIButton *)audioBtn {

    if (self.lastBtn == audioBtn) {
        
        [self.player stop];
        
        self.voiceImageView = (UIImageView *)[[audioBtn subviews] objectAtIndex:0];
        self.loadingView    = (UIActivityIndicatorView *)[[audioBtn subviews] objectAtIndex:1];
        self.gifImageView   = (UIImageView *)[[audioBtn subviews] objectAtIndex:2];
        self.voiceImageView.alpha = 1;
        self.loadingView.alpha    = 0;
        self.gifImageView.alpha   = 0;
        self.lastBtn = nil;
        
    } else {
        
        //////
        
        self.voiceImageView = nil;
        self.loadingView    = nil;
        self.gifImageView   = nil;
        self.playName = audioUrl;
        //*** 默认扬声器播放 ***//
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [audioSession setActive:YES error:nil];
        
        NSError *error = nil;
        BOOL success = [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
        if(!success) {
            NSLog(@"error doing outputaudioportoverride - %@", [error localizedDescription]);
        }
        
        
        self.voiceImageView = (UIImageView *)[[self.lastBtn subviews] objectAtIndex:0];
        self.loadingView    = (UIActivityIndicatorView *)[[self.lastBtn subviews] objectAtIndex:1];
        self.gifImageView   = (UIImageView *)[[self.lastBtn subviews] objectAtIndex:2];
        self.voiceImageView.alpha = 1;
        self.loadingView.alpha    = 0;
        self.gifImageView.alpha   = 0;
        
        /** 获取播放按钮子视图 */
        self.lastBtn = audioBtn;
        self.voiceImageView = (UIImageView *)[[self.lastBtn subviews] objectAtIndex:0];
        self.loadingView    = (UIActivityIndicatorView *)[[self.lastBtn subviews] objectAtIndex:1];
        self.gifImageView   = (UIImageView *)[[self.lastBtn subviews] objectAtIndex:2];
        
        self.voiceImageView.alpha = 0;
        self.loadingView.alpha    = 1;
        [self.loadingView startAnimating];
        self.gifImageView.alpha   = 0;
        
        //创建一个线程队列
        dispatch_queue_t queue = dispatch_queue_create("audio", NULL);
        
        //开启多线程
        dispatch_async(queue, ^{
            
            //将数据保存到本地指定位置
            NSData   *audioData = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:self.playName]];
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath, @"audioTemp"];
            [audioData writeToFile:filePath atomically:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([NSThread isMainThread]) {
                    
                    //回到主线程，播放本地音乐
                    self.voiceImageView.alpha = 0;
                    self.loadingView.alpha    = 0;
                    self.gifImageView.alpha   = 1;
                    NSURL * url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"play.gif" ofType:nil]];
                    [self.gifImageView yh_setImage:url];
                    
                    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                    self.player = nil;
                    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
                    self.player.delegate = self;
                    [self.player play];
                }
            });
        });
        
        //////
    }
    
}



- (void)stopPlayRecord:(UIButton *)audioBtn {
    [self.player stop];
    self.voiceImageView.alpha = 1;
    self.loadingView.alpha    = 0;
    self.gifImageView.alpha   = 0;
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    //音频播放结束
    NSLog(@"播放完成");
    self.voiceImageView.alpha = 1;
    self.loadingView.alpha    = 0;
    self.gifImageView.alpha   = 0;
}


@end
