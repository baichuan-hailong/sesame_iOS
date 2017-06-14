//
//  ZMAgentViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentViewController.h"
#import "ZMAgentView.h"
#import "ZMAgentViewCell.h"
#import "ZMAgentDetailViewController.h"
#import "ZMAgentPublishViewController.h"

@interface ZMAgentViewController () <UITableViewDelegate,
                                     UITableViewDataSource>

@property (nonatomic, strong) ZMAgentView *currentView;


@end

@implementation ZMAgentViewController

- (void)loadView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentView = [[ZMAgentView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    self.currentView.agentTableView.delegate   = self;
    self.currentView.agentTableView.dataSource = self;
    [self rightButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"寻找代理";
}


#pragma mark - UITableView Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH/2.35 + 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifire = @"cell";
    ZMAgentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMAgentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithDic:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZMAgentDetailViewController *agentDetailView = [[ZMAgentDetailViewController alloc] init];
    [agentDetailView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:agentDetailView animated:YES];
}





#pragma maek - cuntomMethod
- (void)rightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/23.43]];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightBtnAction {
    
    NSLog(@"发布代理");
    ZMAgentPublishViewController *publishView = [[ZMAgentPublishViewController alloc] init];
    UINavigationController *publishNC = [[UINavigationController alloc] initWithRootViewController:publishView];
    [publishView setHidesBottomBarWhenPushed:YES];
    [self presentViewController:publishNC animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
