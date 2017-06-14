//
//  ZMMoreProjectInfoViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMoreProjectInfoViewController.h"
#import "ZMMoreProjectInfoView.h"

#import "ZMMySellSecondTableViewCell.h"

@interface ZMMoreProjectInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMMoreProjectInfoView *moreProjectInfoView;

@property (nonatomic , strong) NSArray            *moreArray;
@end

@implementation ZMMoreProjectInfoViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.moreProjectInfoView    = [[ZMMoreProjectInfoView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.moreProjectInfoView;
    self.moreProjectInfoView.moreProjectInfoTableView.delegate   = self;
    self.moreProjectInfoView.moreProjectInfoTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多项目信息";
    
    if (_isSell&&[self.states isEqualToString:@"submit_pending"]) {
        [self rightButton];
    }
    
    self.moreArray =      @[@{@"left":@"标的金额",@"right":@"500W"},
                            @{@"left":@"项目面积",@"right":@"280亩"},
                            @{@"left":@"开工时间",@"right":@"2017年10月"},
                            @{@"left":@"项目所在地",@"right":@"河北永清"},
                            @{@"left":@"甲方名称",@"right":@"河北某公司"},
                            @{@"left":@"工期",@"right":@"2年"}];
}

- (void)rightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [rightButton setImage:[UIImage imageNamed:@"editMoreProject"] forState:UIControlStateNormal];
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //rightButton.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightBtnAction{

    NSLog(@"edit");
}


#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.moreArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*46;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *oneIndentifire = @"oneCell";
    NSDictionary *sellDetailDic = self.moreArray[indexPath.row];
    ZMMySellSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneIndentifire];
    if (!cell) {
        cell = [[ZMMySellSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setInvoiceDetail:sellDetailDic];
    if (indexPath.row==self.moreArray.count-1) {
        cell.line.alpha = 0;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"more");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
