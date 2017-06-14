//
//  CheckTokenManage.m
//  biufang
//
//  Created by 杜海龙 on 16/10/29.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "CheckTokenManage.h"

@implementation CheckTokenManage



+ (void)chekcToken:(NSError *)error{
    //NSLog(@"error --- %@",error);
    if ([[NSString stringWithFormat:@"%@",error.localizedDescription] isEqualToString:@"Request failed: unauthorized (401)"]) {
        NSLog(@"-----------------Request failed: unauthorized (401)-----------------");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_LOGIN];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenFailureAction"
                                                            object:nil];
    }
}


+ (void)chekcToken:(NSError *)error type:(NSString *)type viewController:(UIViewController *)viewController{

    if ([[NSString stringWithFormat:@"%@",error.localizedDescription] isEqualToString:@"Request failed: unauthorized (401)"]) {
        
    }
}



@end
