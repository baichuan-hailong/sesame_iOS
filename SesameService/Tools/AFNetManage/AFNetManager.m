//
//  AFNetManager.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "AFNetManager.h"

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

#import "UIImage+Image.h"

#import "DeviceInfoManage.h"

@implementation AFNetManager
#pragma mark - shareManager
/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */

+(instancetype)shareManager{
    
    static AFNetManager  *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:API]];
    });
    manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:API]];
    return manager;
}


#pragma mark - 重写initWithBaseURL
/**
 *
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */

-(instancetype)initWithBaseURL:(NSURL *)url{
    
    if (self = [super initWithBaseURL:url]) {
        
        //NSAssert(url,@"您需要为您的请求设置baseUrl");
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 3;
        self.requestSerializer                 = [AFJSONRequestSerializer serializer];
        self.responseSerializer                = [AFJSONResponseSerializer serializer];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        //User-Agent
        [self.requestSerializer setValue:[NSString stringWithFormat:@"sesame/%@ (iPhone %@;%@)",VERSION,[DeviceInfoManage deviceModelName],[DeviceInfoManage getDeviceInfo]] forHTTPHeaderField:@"User-Agent"];
        [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]] forHTTPHeaderField:@"Authorization"];
        
    }
    return self;
}


#pragma mark - 网络请求的类方法---get/post

/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */

+(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress{
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    switch (type) {
        case HttpRequestTypeGet:{
            [[AFNetManager shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                [CheckTokenManage chekcToken:error];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
            break;
        }
        case HttpRequestTypePost:{
            [[AFNetManager shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                [CheckTokenManage chekcToken:error];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
        }
    }
}






















//POST---POST
+(id)postRequextwithUrlString:(NSString *)urlString withParaments:(NSString *)paraments{
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",APIDev,urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]] forHTTPHeaderField:@"Authorization"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //User-Agent
    [request setValue:[NSString stringWithFormat:@"sesame/%@ (iPhone %@;%@)",VERSION,[DeviceInfoManage deviceModelName],[DeviceInfoManage getDeviceInfo]] forHTTPHeaderField:@"User-Agent"];
    
    NSData   *bodyData = [paraments dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSData *reveiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dic   = [NSJSONSerialization JSONObjectWithData:reveiveData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",dic);
    return dic;
}



#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm  width        图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 *
 */
+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            //image的分类方法
            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            NSData * imgData = UIImageJPEGRepresentation(resizedImage, .5);
            //拼接data
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}


@end
