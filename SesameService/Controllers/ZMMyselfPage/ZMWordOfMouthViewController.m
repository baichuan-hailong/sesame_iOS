//
//  ZMWordOfMouthViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMWordOfMouthViewController.h"
#import "ZMWordOfMouthView.h"
#import "ZMWordOfMouthTableViewCell.h"

@interface ZMWordOfMouthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMWordOfMouthView *wordOfMouthView;
@end

@implementation ZMWordOfMouthViewController
- (void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.wordOfMouthView = [[ZMWordOfMouthView alloc] initWithFrame:SCREEN_BOUNDS];
    self.wordOfMouthView.mouthTableView.delegate   = self;
    self.wordOfMouthView.mouthTableView.dataSource = self;
    self.view = self.wordOfMouthView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的口碑";
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*126;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifire = @"mouthCell";
    ZMWordOfMouthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMWordOfMouthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.startsView starInit:3];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelected");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
