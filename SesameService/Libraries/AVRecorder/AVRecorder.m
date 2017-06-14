//
//  AVRecorder.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/16.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "AVRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import "lame.h"
#import "AliyunOSSManager.h"

@interface AVRecorder () <AVAudioPlayerDelegate>

/** 录音 **/
@property (nonatomic, strong) AVAudioRecorder  *recorder;

/** 播放 **/
@property (nonatomic, strong) AVAudioPlayer    *player;

/** 定时器 **/
@property (nonatomic, strong) NSTimer          *timer;

/** 录音url **/
@property (nonatomic, strong) NSString         *playName;

/** 参数配置 **/
@property (nonatomic, strong) NSDictionary     *recorderSettingsDict;

@property (nonatomic, strong) AliyunOSSManager *aliyunClient;
@property (nonatomic, strong) NSString         *mp3Name;

/** 定时器 **/
@property (nonatomic, strong) NSTimer          *audioTimer;
@property (nonatomic, assign) NSInteger        audioTime;

@end

@implementation AVRecorder

- (void)startRecord {

    NSLog(@"开始录音");
    
    [self audioTimer];
    [self.audioTimer setFireDate:[NSDate distantPast]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    //AVAudioSessionCategoryPlayAndRecord用于录音和播放
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil) {
        NSLog(@"Error creating session: %@", [sessionError description]);
    }else {
        [session setActive:YES error:nil];
    }

    if (self.recorder) {

        _mp3Name = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
        self.recorder.meteringEnabled = YES; // 打开音量检测
        [self.recorder prepareToRecord];     // 创建文件准备录音
        [self.recorder record];              // 开始录音
    }
}

- (void)stopRecord {

    NSLog(@"结束录音");
    [self.recorder stop];
    self.recorder = nil;
    
    NSDictionary *dic = @{@"time":[NSNumber numberWithInteger:_audioTime]};
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"audioTime" object:nil userInfo:dic];
    [self.audioTimer setFireDate:[NSDate distantFuture]];
}

- (void)playRecord {

    NSLog(@"播放录音");
    
    //*** 默认扬声器播放 ***//
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    NSError *error = nil;
    BOOL success = [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if(!success)
    {
        NSLog(@"error doing outputaudioportoverride - %@", [error localizedDescription]);
    }
    
    
    self.player = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.playName] error:nil];
    self.player.delegate = self;
    [self.player play];
    
    
    
}

- (void)stopPlayRecord {
    
    [self.player stop];
}

- (void)repeatRecord {

    NSLog(@"重新录音");
    _audioTime = 0;
}

- (void)postRecord {

    NSLog(@"发送录音");
    [self audio_PCMtoMP3];
}


#pragma mark - getter
- (AVAudioRecorder *)recorder {

    if (_recorder == nil) {
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.playName = [NSString stringWithFormat:@"%@/play.pcm",docDir];
        
        self.recorderSettingsDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                                     [NSNumber numberWithInt:11025.0],AVSampleRateKey,
                                     [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                     //[NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                                     //[NSNumber numberWithBool:YES],AVLinearPCMIsBigEndianKey,
                                     //[NSNumber numberWithBool:YES],AVLinearPCMIsFloatKey,
                                     [NSNumber numberWithInt:AVAudioQualityMin],AVEncoderAudioQualityKey,
                                     nil];
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.playName]
                                                          settings:self.recorderSettingsDict
                                                          error:nil];
    }
    return _recorder;
}

#pragma mark - 音频处理 && MP3格式转换
- (NSString *)cafPath
{
    NSString *cafPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.caf"];
    return cafPath;
}

- (NSString *)mp3Path
{
    NSString *mp3Path = [NSTemporaryDirectory() stringByAppendingPathComponent:
                        [NSString stringWithFormat:@"%@.mp3",_mp3Name]];
    return mp3Path;
}

- (void)audio_PCMtoMP3
{
    NSString *cafFilePath = self.playName;
    NSString *mp3FilePath = [self mp3Path];
    
    NSLog(@"MP3转换开始");

    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    }
    
    NSLog(@"MP3转换结束");
    
    
    //MP3文件
    //NSData *voiceData = [NSData dataWithContentsOfFile:[self mp3Path]];
    
//    //播放
//    self.player = nil;
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:mp3FilePath] error:nil];
//    self.player.delegate = self;
//    [self.player play];
    
    self.aliyunClient = [[AliyunOSSManager alloc] init];
    [self.aliyunClient initOSSClient];
    [self.aliyunClient upLoadMp3:[NSURL fileURLWithPath:mp3FilePath] withFileName:_mp3Name andLength:[NSString stringWithFormat:@"%ld",_audioTime]];
    
    NSLog(@"mp3 : %@",[NSURL fileURLWithPath:mp3FilePath]);
}


- (void)deleteMp3Cache {
    [self deleteFileWithPath:[self mp3Path]];
}



- (void)deleteFileWithPath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager removeItemAtPath:path error:nil]) {
        
        NSLog(@"删除以前的mp3文件");
    }
}


- (NSTimer *)audioTimer {

    if (_audioTimer == nil) {
        _audioTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(workTime) userInfo:nil repeats:YES];
        _audioTime = 0;
    }
    return _audioTimer;
}

- (void)workTime {
    _audioTime++;
}



#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    //音频播放结束 && 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"endPlay" object:nil];
}


@end
