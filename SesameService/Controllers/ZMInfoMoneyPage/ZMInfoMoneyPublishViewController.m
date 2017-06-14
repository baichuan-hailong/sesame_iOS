//
//  ZMInfoMoneyPublishViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/4.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInfoMoneyPublishViewController.h"
#import "ZMPublishSuccessViewController.h"
#import "ZMInfoMoneyView.h"

@interface ZMInfoMoneyPublishViewController () <UITextFieldDelegate,
                                                UITextViewDelegate,
                                                UIScrollViewDelegate,
                                                UIPickerViewDelegate,
                                                UIPickerViewDataSource>

@property (nonatomic, strong) ZMInfoMoneyView  *currentView;
@property (nonatomic, strong) NSArray          *project_type;
@property (nonatomic, strong) NSArray          *support_level;
@property (nonatomic, strong) NSArray          *target_amount;
@property (nonatomic, assign) NSInteger        currentChoice;
@property (nonatomic, assign) NSInteger        currentPick;
@property (nonatomic, assign) NSInteger        targetPrice;
@property (nonatomic, assign) NSInteger        supportPrice;
@property (nonatomic, assign) BOOL             isHideName;

@property (nonatomic, assign) NSInteger        typeId;
@property (nonatomic, assign) NSInteger        targetId;
@property (nonatomic, assign) NSInteger        timeStamp;
@property (nonatomic, assign) NSInteger        supportId;
@property (nonatomic, strong) MBProgressHUD    *hud;

/** 城市选择 */
@property (nonatomic, strong) NSDictionary             *cityDic;
@property (nonatomic, strong) NSArray                  *provinceArray;
@property (nonatomic, strong) NSArray                  *cityArray;
@property (nonatomic, strong) NSArray                  *areaArray;


@end

@implementation ZMInfoMoneyPublishViewController {
    
    NSInteger _provinceSelectedRow;
    NSInteger _citySelectedRow;
    NSInteger _areaSelectedRow;
    
    NSString *_selectedProvinceTitle;
    NSString *_selectedCityTitle;
    NSString *_selectedAreaTitle;
}

- (void)loadView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentView = [[ZMInfoMoneyView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    
    self.currentView.projectNameText.delegate  = self;
    self.currentView.cityText.delegate         = self;
    self.currentView.projectTypeText.delegate  = self;
    self.currentView.projectPriceText.delegate = self;
    self.currentView.expireTimeText.delegate   = self;
    self.currentView.nameText.delegate         = self;
    self.currentView.positionText.delegate     = self;
    self.currentView.telText.delegate          = self;
    self.currentView.supportText.delegate      = self;
    self.currentView.projectDescribeTextView.delegate = self;
    self.currentView.infoPicker.delegate   = self;
    self.currentView.infoPicker.dataSource = self;
    [self.currentView.nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.choiceBtn addTarget:self action:@selector(hideName) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.confirmBtn addTarget:self action:@selector(pickViewConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.cancelBtn addTarget:self action:@selector(pickViewCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.timeConfirmBtn addTarget:self action:@selector(timePickViewConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.timeCancelBtn addTarget:self action:@selector(timePickViewCancel) forControlEvents:UIControlEventTouchUpInside];
    self.currentView.mainScrollerView.alpha = 0;
    
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布信息";
    self.view.backgroundColor = [UIColor whiteColor];
    _isHideName = YES;
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



#pragma mark - dataSources
- (void)loadDataSources {

    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    NSString     *urlStr   = [NSString stringWithFormat:@"%@/common/info-config",APIDev];
    NSDictionary *param = @{@"param":@"info"};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        _project_type  = object[@"data"][@"project_type"];
        _support_level = object[@"data"][@"support_level"];
        _target_amount = object[@"data"][@"target_amount"];
        
        [self.hud removeFromSuperview];
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    //列数
    if (_currentChoice == 9) {
        return 3;
    } else {
        return 1;
    }
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if (_currentChoice == 9) {
        if (component == 0) {
            return _provinceArray.count;
        } else if (component == 1) {
            return [[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] count];
        } else {
            return [[[[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] objectAtIndex:_citySelectedRow] objectForKey:@"county" ] count];
        }
    } else if (_currentChoice == 1) {
        return _project_type.count;
    } else if (_currentChoice == 2) {
        return _target_amount.count;
    } else if (_currentChoice == 3) {
        return _support_level.count;
    } else {
        return 0;
    }
}

//每列每行对应显示的数据是什么
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (_currentChoice == 9) {
        
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
        
    } else if (_currentChoice == 1) {
        return [NSString stringWithFormat:@"%@",[_project_type objectAt:row][@"title"]];
    } else if (_currentChoice == 2) {
        return [NSString stringWithFormat:@"%@",[_target_amount objectAt:row][@"title"]];
    } else if (_currentChoice == 3) {
        return [NSString stringWithFormat:@"%@",[_support_level objectAt:row][@"title"]];
    } else {
        return @"";
    }
}

#pragma mark-设置下方的数据刷新
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"%@",[NSString stringWithFormat:@"%ld",row]);
    _currentPick = row;
    
    if (_currentChoice == 9) {
        
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
        
    } else if (_currentChoice == 1) {

        self.currentView.projectTypeText.text = [NSString stringWithFormat:@"%@",[_project_type objectAt:row][@"title"]];
        _typeId = [[NSString stringWithFormat:@"%@",[_project_type objectAt:row][@"id"]] integerValue];
        NSLog(@"%ld",_typeId);
    } else if (_currentChoice == 2) {
        self.currentView.projectPriceText.text = [NSString stringWithFormat:@"%@",[_target_amount objectAt:row][@"title"]];
        _targetPrice  = [[NSString stringWithFormat:@"%@",[_target_amount objectAt:_currentPick][@"add_price"]] integerValue];
        _targetId = [[NSString stringWithFormat:@"%@",[_target_amount objectAt:row][@"id"]] integerValue];
        NSLog(@"%ld",_targetId);
    } else if (_currentChoice == 3) {
        self.currentView.supportText.text = [NSString stringWithFormat:@"%@",[_support_level objectAt:row][@"title"]];
        _supportPrice = [[NSString stringWithFormat:@"%@",[_support_level objectAt:_currentPick][@"add_price"]] integerValue];
        _supportId = [[NSString stringWithFormat:@"%@",[_support_level objectAt:row][@"id"]] integerValue];
        NSLog(@"%ld",_supportId);
    }
    self.currentView.basePriceLable.text = [NSString stringWithFormat:@"¥%ld",_targetPrice + _supportPrice + 100];
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

    if (_currentChoice == 9) {
        
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
        
    } else if (_currentChoice == 1) {
        self.currentView.projectTypeText.text = [NSString stringWithFormat:@"%@",[_project_type objectAt:_currentPick][@"title"]];
        _typeId = [[NSString stringWithFormat:@"%@",[_project_type objectAt:_currentPick][@"id"]] integerValue];
        NSLog(@"%ld",_typeId);
    } else if (_currentChoice == 2) {
        self.currentView.projectPriceText.text = [NSString stringWithFormat:@"%@",[_target_amount objectAt:_currentPick][@"title"]];
        _targetPrice  = [[NSString stringWithFormat:@"%@",[_target_amount objectAt:_currentPick][@"add_price"]] integerValue];
        _targetId = [[NSString stringWithFormat:@"%@",[_target_amount objectAt:_currentPick][@"id"]] integerValue];
        NSLog(@"%ld",_targetId);
    } else if (_currentChoice == 3) {
        self.currentView.supportText.text = [NSString stringWithFormat:@"%@",[_support_level objectAt:_currentPick][@"title"]];
        _supportPrice = [[NSString stringWithFormat:@"%@",[_support_level objectAt:_currentPick][@"add_price"]] integerValue];
        _supportId = [[NSString stringWithFormat:@"%@",[_support_level objectAt:_currentPick][@"id"]] integerValue];
        NSLog(@"%ld",_supportId);
    }
    self.currentView.basePriceLable.text = [NSString stringWithFormat:@"¥%ld",_targetPrice + _supportPrice + 100];
    [UIView animateWithDuration:0.28 animations:^{
        self.currentView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        _currentPick = 0;
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
        _currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
}

/** timePickView Action */
- (void)timePickViewConfirm {

    [UIView animateWithDuration:0.28 animations:^{
        self.currentView.timeView.y = SCREEN_HEIGHT;
    }];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.currentView.expireTimeText.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.currentView.datePicker.date]];
    NSLog(@"标准时间 %@",[formatter stringFromDate:self.currentView.datePicker.date]);
    

    NSDate *date = self.currentView.datePicker.date;
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    _timeStamp = timeSp;
    NSLog(@"转时间戳 %ld",_timeStamp);
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    NSLog(@"当前时间 %@",timeString);
}

- (void)timePickViewCancel {
    
    NSLog(@"取消");
    [UIView animateWithDuration:0.28 animations:^{
        self.currentView.timeView.y = SCREEN_HEIGHT;
    }];
}

#pragma mark - 是否匿名
- (void)hideName {

    UIImageView *imgView = [[self.currentView.choiceBtn subviews] objectAtIndex:0];
    if (_isHideName) {
        imgView.image = [UIImage imageNamed:@"symbol_noSelect"];
        _isHideName = NO;
    } else {
        imgView.image = [UIImage imageNamed:@"symbol_select"];
        _isHideName = YES;
    }
}


#pragma mark - textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    /** 视图弹起 */
    [UIView animateWithDuration:0.38 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"%ld",textField.tag);
    
    if (textField.tag == 9 ||
        textField.tag == 2 ||
        textField.tag == 3 ||
        textField.tag == 8) {
        
        if (textField.tag == 9) {
            _currentChoice = 9;
        } else if (textField.tag == 2) {
            _currentChoice = 1;
        } else if (textField.tag == 3) {
            _currentChoice = 2;
        } else {
            _currentChoice = 3;
        }

        /** 弹出选择器 */
        [UIView animateWithDuration:0.28 animations:^{
            [self.currentView.infoPicker selectRow:0 inComponent:0 animated:NO];
            self.currentView.pickerView.y = SCREEN_HEIGHT - 240;
        }];
        
        [self.view endEditing:YES];
        return NO;
    } else if (textField.tag == 4) {
        
        /** 弹出时间选择器 */
        [UIView animateWithDuration:0.28 animations:^{
            self.currentView.timeView.y = SCREEN_HEIGHT - 240;
        }];
        
        [self.view endEditing:YES];
        return NO;
    } else {
        
        /** 弹出键盘*/
        [UIView animateWithDuration:0.28 animations:^{
            self.currentView.pickerView.y = SCREEN_HEIGHT;
            self.currentView.timeView.y = SCREEN_HEIGHT;
        } completion:^(BOOL finished) {
            _currentPick = 0;
        }];
        return YES;
    }
    
    
}

//限制输入字符数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if (textField.tag == 1) {
        
        /** 项目名称 */
        if (range.location >= 30 || str.length >= 31){
            
            return NO;
        } else {
            
            return YES;
        }
    } else if (textField.tag == 5 || textField.tag == 6) {
        
        /** 姓名和职位限制字符数 */
        if (range.location >= 15 || str.length >= 16){
            
            return NO;
        } else {
            
            return YES;
        }
    }
    return YES;
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
        self.currentView.timeView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        _currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
}

- (void)nextStep {
    
    NSLog(@"提交");
    
    for (int i = 1; i <= 9; i++) {
        UITextView *currentText = (UITextView *)[self.currentView viewWithTag:i];
        if ([currentText.text isEqualToString:@""]) {
         
            switch (i) {
                case 1:
                    [toolClass showProgress:@"请填写项目名称" toView:self.view];
                    break;
                case 2:
                    [toolClass showProgress:@"请选择项目类型" toView:self.view];
                    break;
                case 3:
                    [toolClass showProgress:@"请填写预计标的额" toView:self.view];
                    break;
                case 4:
                    [toolClass showProgress:@"请填写消息有效期" toView:self.view];
                    break;
                case 5:
                    [toolClass showProgress:@"请填写姓名" toView:self.view];
                    break;
                case 6:
                    [toolClass showProgress:@"请填写职务" toView:self.view];
                    break;
                case 7:
                    [toolClass showProgress:@"请填写电话" toView:self.view];
                    break;
                case 8:
                    [toolClass showProgress:@"请选择为信息购买者提供的支持" toView:self.view];
                    break;
                case 9:
                    [toolClass showProgress:@"请选择所在城市" toView:self.view];
                    break;
                    
                default:
                    break;
            }
            return;
        }
    }
    
    if (self.currentView.projectDescribeTextView.text.length < 20) {
        [toolClass showProgress:@"项目说明请至少填写20字" toView:self.view];
    } else {
        
        self.currentView.nextBtn.userInteractionEnabled = NO;
        [self.view addSubview:self.hud];
        [self.hud show:YES];
        
        NSString     *urlStr   = [NSString stringWithFormat:@"%@/info/create",APIDev];
        NSDictionary *param = @{@"category":@"1",
                                @"title":self.currentView.projectNameText.text,
                                @"type":[NSNumber numberWithInteger:_typeId],
                                @"target_amount":[NSNumber numberWithInteger:_targetId],
                                @"expire_time":[NSNumber numberWithInteger:_timeStamp],
                                @"demander_name":self.currentView.nameText.text,
                                @"demander_title":self.currentView.positionText.text,
                                @"demander_tel":self.currentView.telText.text,
                                @"description":self.currentView.projectDescribeTextView.text,
                                @"support_level":[NSNumber numberWithInteger:_supportId],
                                @"mask":_isHideName ? @"1" : @"0",
                                @"biz_locate":[NSString stringWithFormat:@"%@^%@^%@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle]};
        
        NSLog(@"param %@",param);
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            
            self.currentView.nextBtn.userInteractionEnabled = YES;
            [self.hud removeFromSuperview];
            if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
                
                ZMPublishSuccessViewController *successView = [[ZMPublishSuccessViewController alloc] init];
                successView.detailId = [NSString stringWithFormat:@"%@",object[@"data"][@"id"]];
                successView.from = @"info";
                successView.moreInfoDic = @{@"title":self.currentView.projectNameText.text,
                                            @"fee":[NSString stringWithFormat:@"%ld",_supportPrice + _targetPrice + 100],
                                            @"mask":_isHideName ? @"1" : @"0"};
                [self.navigationController pushViewController:successView animated:YES];
                
            } else {
                [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            self.currentView.nextBtn.userInteractionEnabled = YES;
            [self.hud removeFromSuperview];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
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
            [self.currentView.mainScrollerView setContentOffset:CGPointMake(0, diff + 100) animated:YES];
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
