//
//  AliyunOSSManager.m
//  biufang
//
//  Created by 杜海龙 on 16/10/12.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "AliyunOSSManager.h"
#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>

NSString  * const AccessKey          = @"LTAIwxlB7qnGi5bs";
NSString  * const SecretKey          = @"CYvWQwWgcBvlgspn6yES6z4dplwuL2";
NSString  * const multipartUploadKey = @"multipartUploadObject";

NSString  * const endPoint           = @"http://oss-cn-beijing.aliyuncs.com";

OSSClient * client;

static dispatch_queue_t queue4demo;


@implementation AliyunOSSManager

- (void)initOSSClient{

    NSString *endpoint = endPoint;

    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
}


//upload headerImage
- (void)upLoadMp3:(NSURL *)mp3Url withFileName:(NSString *)fileName andLength:(NSString *)lenght {

    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 必填字段
    put.bucketName = @"sesame-dev";
    put.objectKey  = [NSString stringWithFormat:@"attachments/answer/%@.mp3",fileName];
    put.uploadingFileURL = mp3Url;

    
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };

    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
            NSLog(@"upload object success!");
            //上传完成，发送通知
            NSDictionary *dic = @{@"url":[NSString stringWithFormat:@"http://zm-dn.wanbangbang.cn/attachments/answer/%@.mp3",fileName],
                                  @"time":lenght,
                                  @"name":[NSString stringWithFormat:@"%@.mp3",fileName]};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mp3UploadComplete" object:nil userInfo:dic];
            
        } else {
            NSLog(@"upload object failed, error: %@", task.error);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mp3UploadFail" object:nil];
        }
        return nil;
    }];
    // [putTask waitUntilFinished];
    // [put cancel];
}




//oss
- (void)creatOSSClient:(NSString *)prefix{
    
    self.questionFileImagesArray = [NSMutableArray array];
    
    // Federation鉴权,建议通过访问远程业务服务器获取签名
    id<OSSCredentialProvider> credential2 = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        
         NSLog(@"oss ------------------------------------------------------------------------- oss");
         
         NSString *urlStr      = [NSString stringWithFormat:@"%@/common/get-sts?prefix=%@",APIDev,prefix];
         NSLog(@"url -------------------------------------------------------------------------- %@",urlStr);
         NSURL *url            = [NSURL URLWithString:urlStr];
         NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]] forHTTPHeaderField:@"Authorization"];
         //[request setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]] forHTTPHeaderField:@"Authorization"];
        
        
         OSSTaskCompletionSource * tcs  = [OSSTaskCompletionSource taskCompletionSource];
         NSURLSession * session         = [NSURLSession sharedSession];
         NSURLSessionTask * sessionTask = [session dataTaskWithRequest:request
         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             if (error) {
                 [tcs setError:error];
                 return;
             }
                 [tcs setResult:data];
                 }];
                 [sessionTask resume];
                 [tcs.task waitUntilFinished];
             if (tcs.task.error) {
                 NSLog(@"get token error: %@", tcs.task.error);
                 return nil;
             } else {
             
                 NSDictionary * object = [NSJSONSerialization JSONObjectWithData:tcs.task.result
                 options:kNilOptions
                 error:nil];
                 NSLog(@"%@",object);
                 OSSFederationToken * token = [OSSFederationToken new];
                 token.tAccessKey = object[@"data"][@"AccessKeyId"];
                 token.tSecretKey = object[@"data"][@"AccessKeySecret"];
                 token.tToken     = object[@"data"][@"SecurityToken"];
                 token.expirationTimeInGMTFormat = object[@"data"][@"Expiration"];
                 return token;
             }
    }];
    
    
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential2];
    
}


#pragma mark - upload Image
- (void)uploadObjectAsyncResister:(NSData *)imageData path:(NSString *)path{
    
    NSString *filename = [NSString stringWithFormat:@"%@-%@.png",[self ret16bitString],[self timestamp]];
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    
    put.bucketName = AliBucket;
    put.objectKey = [NSString stringWithFormat:@"%@%@",path,filename];
    NSLog(@"filename --- %@%@.png",path,filename);
    //put.uploadingFileURL = [NSURL fileURLWithPath:@"<filepath>"];
    put.uploadingData = imageData;
    
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // current、currentTotal、total
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
            if ([path isEqualToString:AVATAR]) {
                [self updateAvatar:filename];
            }else if ([path isEqualToString:ResourceUser]){
                NSDictionary *dic = @{@"fileName":[NSString stringWithFormat:@"%@",filename]};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addAwardHonorSuccessful" object:dic userInfo:nil];
            }
        } else {
            NSLog(@"upload object failed!%@" , task.error);
            if ([path isEqualToString:AVATAR]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadAvatarFailed" object:nil];
            }else if ([path isEqualToString:ResourceUser]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addAwardHonorFailed" object:nil userInfo:nil];
            }
            
        }
        return nil;
    }];
    // [putTask waitUntilFinished];
    // [put cancel];
}



#pragma mark - Save
- (void)updateAvatar:(NSString *)fileName {
    
    NSDictionary *parDic = @{@"avatar":fileName};
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/upload-avatar",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"avatar ------ %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            //save
            [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"avatar"] forKey:Person_avatar];
            //bug
            [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"avatar"]  forKey:Com_avatar];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadAvatarSuccessful" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadAvatarFailed" object:nil];
        }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadAvatarFailed" object:nil];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    
}



#pragma mark - Type
- (void)uploadObjectAsyncResister:(NSData *)imageData path:(NSString *)path index:(NSInteger)index total:(NSInteger)total{
    
    NSString *filename = [NSString stringWithFormat:@"%@-%@.png",[self ret16bitString],[self timestamp]];
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    
    put.bucketName = AliBucket;
    put.objectKey = [NSString stringWithFormat:@"%@%@",path,filename];
    NSLog(@"filename --- %@%@.png",path,filename);
    //put.uploadingFileURL = [NSURL fileURLWithPath:@"<filepath>"];
    put.uploadingData = imageData;
    
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // current currentTotal total
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
            //ResourceUser
            if ([path isEqualToString:ResourceUser]) {
                if (index==0) {
                    [[NSUserDefaults standardUserDefaults] setObject:filename forKey:@"personcardIDOn"];
                    NSLog(@"upload object success!------on");
                }else if (index==1){
                    [[NSUserDefaults standardUserDefaults] setObject:filename  forKey:@"personcardIDOff"];
                    NSLog(@"upload object success!------off");
                }
                if (index==total-1) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"cardIDUploadSuccessful" object:nil];
                    NSLog(@"upload object success!------post");
                }
            }
            NSLog(@"upload object success!");
           
        } else {
            NSLog(@"upload object failed!%@" , task.error);
            [put cancel];
            
            //ResourceUser
            if ([path isEqualToString:ResourceUser]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cardIDUploadFailed" object:nil];
            }
        }
        return nil;
    }];
    // [putTask waitUntilFinished];
    // [put cancel];
}


#pragma mark - Question
- (void)uploadQuestionAsyncResister:(NSData *)imageData path:(NSString *)path index:(NSInteger)index total:(NSInteger)total{
    
    NSString *filename = [NSString stringWithFormat:@"%@-%@.png",[self ret16bitString],[self timestamp]];
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    
    put.bucketName = AliBucket;
    put.objectKey = [NSString stringWithFormat:@"%@%@",path,filename];
    NSLog(@"filename --- %@%@.png",path,filename);
    put.uploadingData = imageData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
        
            NSLog(@"upload object success!");
            [self.questionFileImagesArray addObject:filename];
            
            //Question
            if ([path isEqualToString:QUESTION]&&(self.questionFileImagesArray.count==total)) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadQuestionImageSuccessful" object:self.questionFileImagesArray];
            }
            
        } else {
            NSLog(@"upload object failed!%@" , task.error);
            [put cancel];
            
            //Question
            if ([path isEqualToString:QUESTION]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadQuestionImageFailed" object:nil];
            }
        }
        return nil;
    }];
    // [putTask waitUntilFinished];
    // [put cancel];
}




#pragma mark - System
-(NSString *)ret16bitString{
    char data[16];
    for (int x=0;x<16;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:16 encoding:NSUTF8StringEncoding];
}

- (NSString *)timestamp{
    NSTimeInterval a=[[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];//转为字符型
    return timeString;
}





@end
