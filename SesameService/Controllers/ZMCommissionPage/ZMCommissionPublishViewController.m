//
//  ZMCommissionPublishViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/4.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionPublishViewController.h"
#import "ZMCommissionPublishView.h"
#import "ZMPublishSuccessViewController.h"

@interface ZMCommissionPublishViewController ()  <UITextFieldDelegate,
                                                  UITextViewDelegate,
                                                  UIScrollViewDelegate,
                                                  UIPickerViewDelegate,
                                                  UIPickerViewDataSource>

@property (nonatomic, strong) ZMCommissionPublishView  *currentView;
@property (nonatomic, strong) NSArray                  *project_type;
@property (nonatomic, copy  ) NSString                 *rewardType;
@property (nonatomic, strong) MBProgressHUD            *hud;

@property (nonatomic, strong) NSDictionary             *cityDic;
@property (nonatomic, strong) NSArray                  *provinceArray;
@property (nonatomic, strong) NSArray                  *cityArray;
@property (nonatomic, strong) NSArray                  *areaArray;



@end

@implementation ZMCommissionPublishViewController {
    
    NSInteger _provinceSelectedRow;
    NSInteger _citySelectedRow;
    NSInteger _areaSelectedRow;
    
    NSString *_selectedProvinceTitle;
    NSString *_selectedCityTitle;
    NSString *_selectedAreaTitle;
}

- (void)loadView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentView = [[ZMCommissionPublishView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    
    self.currentView.projectNameText.delegate  = self;
    self.currentView.projectTypeText.delegate  = self;
    self.currentView.cityText.delegate         = self;
    self.currentView.projectPriceText.delegate = self;
    self.currentView.projectDescribeTextView.delegate = self;
    self.currentView.infoPicker.delegate   = self;
    self.currentView.infoPicker.dataSource = self;
    [self.currentView.nextBtn  addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.funcBtn1 addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.funcBtn2 addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.funcBtn3 addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.funcBtn4 addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.currentView.confirmBtn addTarget:self action:@selector(pickViewConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.cancelBtn addTarget:self action:@selector(pickViewCancel) forControlEvents:UIControlEventTouchUpInside];
    self.currentView.mainScrollerView.alpha = 0;
    
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交佣金需求";
    self.view.backgroundColor = [UIColor whiteColor];
    _rewardType = @"";
    [self loadDataSources];

    //注册键盘弹起回收监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /** 地区XML文件解析 */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"xml"];
    NSData   *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error = nil;
    _cityDic = [XMLReader dictionaryForXMLData:data
                                                 options:XMLReaderOptionsProcessNamespaces
                                                   error:&error];
    
    
    _provinceArray = (NSArray *)_cityDic[@"root"][@"province"];
    _provinceSelectedRow = 0;
    _citySelectedRow     = 0;
    _areaSelectedRow     = 0;
    //CITYLog(@"%@",_provinceArray);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - dataSources
- (void)loadDataSources {
    
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    NSString     *urlStr   = [NSString stringWithFormat:@"%@/common/info-config",APIDev];
    NSDictionary *param = @{@"param":@"commission"};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        _project_type  = object[@"data"][@"project_type"];
        
        [self.hud removeFromSuperview];
        _rewardType = @"negotiable";
        [UIView animateWithDuration:0.28 animations:^{
            self.currentView.mainScrollerView.alpha = 1;
        }];
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud removeFromSuperview];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

#pragma mark- pickerView代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return _provinceArray.count;
    } else if (component == 1) {
        return [[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] count];
    } else {
        return [[[[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] objectAtIndex:_citySelectedRow] objectForKey:@"county" ] count];
    }
}

//每列每行对应显示的数据是什么
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSDictionary *provinceDic = [_provinceArray objectAtIndex:_provinceSelectedRow];
    NSArray *cityArray = [provinceDic objectForKey:@"city"];
    
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%@",[_provinceArray objectAt:row][@"name"]];
            break;
        case 1:{
            return [NSString stringWithFormat:@"%@",[cityArray objectAt:row][@"name"]];
            break;
        }
        case 2:{
            NSArray *areaArr = (NSArray *)[[cityArray objectAtIndex:_citySelectedRow] objectForKey:@"county"];
            return [NSString stringWithFormat:@"%@",[[areaArr objectAt:row] objectForKey:@"name"]];
            break;
        }
        default:
            return [NSString stringWithFormat:@"%@",[[_provinceArray objectAt:row] objectForKey:@"name"]];
            break;
    }
    
}

#pragma mark-设置下方的数据刷新
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"%@",[NSString stringWithFormat:@"%ld",row]);
    
    switch (component) {
        case 0:{
            _provinceSelectedRow = row;
            _citySelectedRow = 0;
            _areaSelectedRow = 0;
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        }
        case 1:{
            _citySelectedRow = row;
            _areaSelectedRow = 0;
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        }
        case 2:
            _areaSelectedRow = row;
            break;
        default:
            _provinceSelectedRow = row;
            break;
    }
    [pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:SCREEN_WIDTH/26.78]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

/** pickView Action */
- (void)pickViewConfirm {
    
    NSLog(@"确认");
    _selectedProvinceTitle = [self pickerView:self.currentView.infoPicker titleForRow:_provinceSelectedRow forComponent:0];
    _selectedCityTitle     = [self pickerView:self.currentView.infoPicker titleForRow:_citySelectedRow forComponent:1];
    _selectedAreaTitle     = [self pickerView:self.currentView.infoPicker titleForRow:_areaSelectedRow forComponent:2];
    if ([_selectedProvinceTitle isEqualToString:@"(null)"]) {
        _selectedProvinceTitle = @"";
    }
    if ([_selectedCityTitle isEqualToString:@"(null)"]) {
        _selectedCityTitle = @"";
    }
    if ([_selectedAreaTitle isEqualToString:@"(null)"]) {
        _selectedAreaTitle = @"";
    }
    
    self.currentView.cityText.text = [NSString stringWithFormat:@"%@ %@ %@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.currentView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
}

- (void)pickViewCancel {
    
    NSLog(@"取消");
    [UIView animateWithDuration:0.28 animations:^{
        self.currentView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
}



#pragma mark - textFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    NSLog(@"%ld",textField.tag);
    
    if (textField.tag == 2) {

        /** 弹出地区选择器 */
        [UIView animateWithDuration:0.28 animations:^{
            [self.currentView.infoPicker selectRow:0 inComponent:0 animated:NO];
            self.currentView.pickerView.y = SCREEN_HEIGHT - 240;
        }];
        
        [self.view endEditing:YES];
        return NO;
    } else {
        
        /** 弹出键盘*/
        [UIView animateWithDuration:0.28 animations:^{
            self.currentView.pickerView.y = SCREEN_HEIGHT;
        } completion:^(BOOL finished) {
        }];
        return YES;
    }
}

//限制输入字符数不能大于30个
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 3) {

        NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
        [futureString insertString:string atIndex:range.location];
        NSInteger flag = 0;
        const NSInteger limited = 2;
        
        for (int i = (int)futureString.length - 1; i >= 0; i--) {
            
            if ([futureString characterAtIndex:i] == '.') {
                
                if (flag > limited) {
                    return NO;
                }
                break;
            }
            flag++;
        }
        if ([[NSString stringWithFormat:@"%@%@",textField.text,string] integerValue] < 1000000) {
            return YES;
        } else {
            [toolClass showProgress:@"预估项目标的额位数超出限制，请输入小于100亿的数字" toView:self.view];
            return NO;
        }
        return YES;
        
    }

    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if (range.location >= 30 || str.length >= 31){
        return NO;
        
    } else {
        return YES;
    }

}





#pragma mark - textViewDelegate
//监听输入结束后的内容
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    NSLog(@"%@  %@",textView.text, text);
    //当字符数大于等于300，键盘不能继续输入
    NSString *str = [NSString stringWithFormat:@"%@%@",textView.text,text];
    if (range.location >= 300 || str.length >= 301){
        return NO;
        
    } else {
        return YES;
    }
}

//监听正在输入的内容
-(void)textViewDidChange:(UITextView *)textView {
    
    NSLog(@"%@",textView.text);
    if ([textView.text isEqualToString:@""]) {
        self.currentView.placeholderLable.hidden = NO;
    } else {
        self.currentView.placeholderLable.hidden = YES;
    }
    
    self.currentView.worldCountLabel.text = [NSString stringWithFormat:@"%lu/300",textView.text.length];
    
    //计数lable 变红
    if (textView.text.length >= 300) {
        
        self.currentView.worldCountLabel.textColor = [UIColor redColor];
    } else {
        
        self.currentView.worldCountLabel.textColor = [UIColor grayColor];
    }
}







#pragma mark - customMethod
- (void)endEdit {
    
    /** 收回键盘 */
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.28 animations:^{
        self.currentView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
    
}

- (void)nextStep {
    
    for (int i = 1; i <= 4; i++) {
        UITextView *currentText = (UITextView *)[self.currentView viewWithTag:i];
        
        if (i == 4) {
            if ([self.currentView.priceText.text isEqualToString:@""] &&
                ([_rewardType isEqualToString:@"fixed_value"] || [_rewardType isEqualToString:@"fixed_percent"] )) {
                [toolClass showProgress:@"请填写期望佣金" toView:self.view];
                return;
            }
        } else {
        
            if ([currentText.text isEqualToString:@""]) {
                
                switch (i) {
                    case 1:
                        [toolClass showProgress:@"请填写项目名称" toView:self.view];
                        break;
                    case 2:
                        [toolClass showProgress:@"请选择业务区域" toView:self.view];
                        break;
                    case 3:
                        [toolClass showProgress:@"请填写预估项目标的额" toView:self.view];
                        break;
                        
                    default:
                        break;
                }
                return;
            }
        }
    }
    
    if (self.currentView.projectDescribeTextView.text.length < 20) {
        [toolClass showProgress:@"项目说明请至少填写20字" toView:self.view];
        
    } else if ([_rewardType isEqualToString:@"fixed_value"] &&
               [self.currentView.priceText.text floatValue] > [self.currentView.projectPriceText.text floatValue]) {
        [toolClass showProgress:@"期望佣金金额不可大于预估标的额" toView:self.view];
        
    } else {
        
        self.currentView.nextBtn.userInteractionEnabled = NO;
        [self.view addSubview:self.hud];
        [self.hud show:YES];
        
        CGFloat fix_value   = 0.0f;
        CGFloat fix_percent = 0.0f;
        if ([_rewardType isEqualToString:@"fixed_value"]) {
            fix_value   = [self.currentView.priceText.text floatValue];
        } else if ([_rewardType isEqualToString:@"fixed_percent"]) {
            fix_percent = [self.currentView.priceText.text floatValue]/100.0;
        }
        
        NSString     *urlStr = [NSString stringWithFormat:@"%@/info/create",APIDev];
        NSDictionary *param  = @{@"category":@"2",
                                 @"title":self.currentView.projectNameText.text,
                                 @"type":[NSNumber numberWithInteger:0],
                                 @"target_amount_value":[NSNumber numberWithFloat:[self.currentView.projectPriceText.text floatValue]],
                                 @"biz_locate":[NSString stringWithFormat:@"%@^%@^%@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle],
                                 @"reward_type":_rewardType,
                                 @"reward_value":[NSNumber numberWithFloat:fix_value],
                                 @"reward_percent":[NSNumber numberWithFloat:fix_percent],
                                 @"description":self.currentView.projectDescribeTextView.text};
        NSLog(@"param %@",param);
        
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            
            [self.hud removeFromSuperview];
            self.currentView.nextBtn.userInteractionEnabled = YES;
            if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
                
                ZMPublishSuccessViewController *successView = [[ZMPublishSuccessViewController alloc] init];
                successView.detailId = [NSString stringWithFormat:@"%@",object[@"data"][@"id"]];
                successView.from = @"commission";
                [self.navigationController pushViewController:successView animated:YES];
                
            } else {
                [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.hud removeFromSuperview];
            self.currentView.nextBtn.userInteractionEnabled = NO;
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }
}

- (void)choiceAction:(UIButton *)sender {

    for (int i = 1; i < 5; i++) {
        
        UIButton *currentBtn = (UIButton *)[self.currentView viewWithTag:1000 + i];
        UIImageView *imgView = [[currentBtn subviews] objectAtIndex:0];
        if (1000 + i == sender.tag) {
            imgView.image = [UIImage imageNamed:@"symbol_select"];
        } else {
            imgView.image = [UIImage imageNamed:@"symbol_noSelect"];
        }
    }
    
    if (sender.tag == 1001) {
        _rewardType = @"fixed_value";
    } else if (sender.tag == 1002) {
        _rewardType = @"fixed_percent";
    } else if (sender.tag == 1003) {
        _rewardType = @"market_avg";
    } else if (sender.tag == 1004) {
        _rewardType = @"negotiable";
    }
    
    if (sender.tag == 1001) {
        
        [UIView animateWithDuration:0.18 animations:^{
            self.currentView.priceLable.alpha = 1;
            self.currentView.priceText.alpha  = 1;
            self.currentView.priceLable.text = @"请填写佣金金额（万元）";
            self.currentView.priceText.placeholder = @"请输入数字";
            
            self.currentView.projectDescribeLable.y = self.currentView.priceText.bottom + SCREEN_WIDTH/37.5;
            self.currentView.projectDescribeTextView.y = self.currentView.projectDescribeLable.bottom + SCREEN_WIDTH/37.5;
            self.currentView.worldCountLabel.y = self.currentView.projectDescribeTextView.bottom + SCREEN_WIDTH/75;
            self.currentView.nextBtn.y = self.currentView.worldCountLabel.bottom + SCREEN_WIDTH/18.75;
            
            self.currentView.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.currentView.nextBtn.frame) + 20);
        }];

    } else if (sender.tag == 1002) {
    
        [UIView animateWithDuration:0.18 animations:^{
            self.currentView.priceLable.alpha = 1;
            self.currentView.priceText.alpha  = 1;
            self.currentView.priceLable.text = @"请填写佣金比例（%）";
            self.currentView.priceText.placeholder = @"请输入0-100的数字";
            
            self.currentView.projectDescribeLable.y = self.currentView.priceText.bottom + SCREEN_WIDTH/37.5;
            self.currentView.projectDescribeTextView.y = self.currentView.projectDescribeLable.bottom + SCREEN_WIDTH/37.5;
            self.currentView.worldCountLabel.y = self.currentView.projectDescribeTextView.bottom + SCREEN_WIDTH/75;
            self.currentView.nextBtn.y = self.currentView.worldCountLabel.bottom + SCREEN_WIDTH/18.75;
            
            self.currentView.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.currentView.nextBtn.frame) + 20);
        }];
        
    } else {
    
        [UIView animateWithDuration:0.18 animations:^{
            self.currentView.priceLable.alpha = 0;
            self.currentView.priceText.alpha  = 0;
            self.currentView.projectDescribeLable.y = self.currentView.funcBtn2.bottom + SCREEN_WIDTH/37.5;
            self.currentView.projectDescribeTextView.y = self.currentView.projectDescribeLable.bottom + SCREEN_WIDTH/37.5;
            self.currentView.worldCountLabel.y = self.currentView.projectDescribeTextView.bottom + SCREEN_WIDTH/75;
            self.currentView.nextBtn.y = self.currentView.worldCountLabel.bottom + SCREEN_WIDTH/18.75;
            
            self.currentView.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.currentView.nextBtn.frame) + 20);
        }];

    }
}



#pragma maek - 键盘事件通知
//收到键盘弹出通知后的响应
- (void)keyboardWillShow:(NSNotification *)info {
    
    NSDictionary *dict             = info.userInfo;
    CGRect keyboardBounds          = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration                = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardBoundsRect      = [self.view convertRect:keyboardBounds toView:nil];
    double offsetY                 = keyboardBoundsRect.size.height;
    UIViewAnimationOptions options = [dict[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        UIView *currentView = [self getFirstResponder];
        if (currentView == self.currentView.projectDescribeTextView) {
            
            NSInteger diff = currentView.bottom - (SCREEN_HEIGHT - offsetY);
            [self.currentView.mainScrollerView setContentOffset:CGPointMake(0, diff + 116) animated:YES];
        }
        
    } completion:nil];
}

//隐藏键盘通知的响应
- (void)keyboardWillHide:(NSNotification *)info {
    
    NSDictionary *dict             = info.userInfo;
    double duration                = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [dict[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        //UIView *currentView = [self getFirstResponder];
        //currentView.transform = CGAffineTransformIdentity;;
        
    } completion:nil];
}


- (UIView *) getFirstResponder
{
    if (self.currentView.isFirstResponder) {
        return self.currentView;
    }
    
    for (UIView *subView in self.currentView.subviews) {
        UIView *firstResponder = [subView performSelector:@selector(firstResponder)];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}


#pragma mark - getter
- (MBProgressHUD *)hud {
    
    if (_hud == nil) {
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}



- (void)dealloc {


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
