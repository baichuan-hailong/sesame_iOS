
//
//  ZMUploadCardViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/12.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUploadCardViewController.h"
#import "ZMUploadCardView.h"

@interface ZMUploadCardViewController ()
@property (nonatomic,strong)ZMUploadCardView *uploadCardView;

@end

@implementation ZMUploadCardViewController

-(void)loadView{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.uploadCardView = [[ZMUploadCardView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.uploadCardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"上传名片";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
