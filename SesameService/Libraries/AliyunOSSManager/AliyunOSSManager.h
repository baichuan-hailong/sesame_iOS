//
//  AliyunOSSManager.h
//  biufang
//
//  Created by 杜海龙 on 16/10/12.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliyunOSSManager : NSObject
//Question
@property (nonatomic,strong)NSMutableArray *questionFileImagesArray;

//init
- (void)initOSSClient;
- (void)upLoadMp3:(NSURL *)mp3Url withFileName:(NSString *)fileName andLength:(NSString *)lenght;



//oss
- (void)creatOSSClient:(NSString *)prefix;

- (void)uploadObjectAsyncResister:(NSData *)imageData path:(NSString *)path;

//array
- (void)uploadObjectAsyncResister:(NSData *)imageData path:(NSString *)path index:(NSInteger)index total:(NSInteger)total;

//Question
- (void)uploadQuestionAsyncResister:(NSData *)imageData path:(NSString *)path index:(NSInteger)index total:(NSInteger)total;
@end
