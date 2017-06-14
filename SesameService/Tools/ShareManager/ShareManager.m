//
//  ShareManager.m
//  biufang
//
//  Created by 杜海龙 on 16/10/25.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "ShareManager.h"


@implementation ShareManager
+(instancetype)defaulShaer {
    static dispatch_once_t onceToken;
    static ShareManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ShareManager alloc] init];
    });
    return instance;
}


/*
 约定
 GBN 赠送Biu房号码
 FDS 房屋详情
 GRE 赠送红包
 */

//好友
-(void)shareWechatSession:(UIViewController *)vc type:(NSString *)type sn:(NSString *)sn token:(NSString *)token biuNumCount:(NSString *)biuNumCount{

    
    NSString *user_id = @"";
    NSString *nickName = @"";
    NSString *avatar = @"";
    
    
    NSString *urlStr;
    NSString *titleStr;
    NSString *contentStr;
    
    
   
}


//shareIcon
//朋友圈
-(void)shareWechatTimeLine:(UIViewController *)vc type:(NSString *)type sn:(NSString *)sn token:(NSString *)token biuNumCount:(NSString *)biuNumCount{

    
    NSString *user_id = @"";
    NSString *nickName = @"";
    NSString *avatar = @"";
    
    
    NSString *urlStr;
    NSString *titleStr;
    NSString *contentStr;
    
    
}


//QQ
-(void)shareQQ:(UIViewController *)vc type:(NSString *)type sn:(NSString *)sn token:(NSString *)token biuNumCount:(NSString *)biuNumCount{

    NSString *user_id = @"";
    NSString *nickName = @"";
    NSString *avatar = @"";
    
    
    NSString *urlStr;
    NSString *titleStr;
    NSString *contentStr;
    
   
}



//QQZone
-(void)shareQQZone:(UIViewController *)vc type:(NSString *)type sn:(NSString *)sn token:(NSString *)token biuNumCount:(NSString *)biuNumCount{
    
    NSString *user_id = @"";
    NSString *nickName = @"";
    NSString *avatar = @"";
    
    
    NSString *urlStr;
    NSString *titleStr;
    NSString *contentStr;
    
    
}


-(void)shareSms:(UIViewController *)vc type:(NSString *)type sn:(NSString *)sn token:(NSString *)token biuNumCount:(NSString *)biuNumCount{

    NSString *user_id = @"";
    NSString *nickName = @"";
    NSString *avatar = @"";
    
    
    NSString *urlStr;
    NSString *titleStr;
    NSString *contentStr;
    
    
    //判断是否能发短息
    if( [MFMessageComposeViewController canSendText] ){
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = [NSArray arrayWithObject:@"选择联系人"];//接收人,可以有很多,放入数组
        NSString *new_url=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        controller.body = [NSString stringWithFormat:@"%@ %@",titleStr,new_url]; //短信内容,自定义即可
        controller.messageComposeDelegate = self; //注意不是delegate
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"邀请好友"];//修改短信界面标题
        //controller.modalPresentationStyle = UIModalPresentationCurrentContext;
        [vc presentViewController:controller animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"抱歉" message:@"短信功能不可用!" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
    }
    
}




 -(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
 
     [controller dismissViewControllerAnimated:YES completion:nil];
     switch (result){
     case MessageComposeResultCancelled:{
     //cancled
     NSLog(@"cancled");
     }
     break;
     //failed
     case MessageComposeResultFailed:{
     NSLog(@"failed");
     
     }
     break;
     //successful
     case MessageComposeResultSent:{
     NSLog(@"successful");
     
     }
     break;
     default:
     break;
     }
 }
 



-(void)shareWebo:(UIViewController *)vc type:(NSString *)type sn:(NSString *)sn token:(NSString *)token biuNumCount:(NSString *)biuNumCount{

}




@end
