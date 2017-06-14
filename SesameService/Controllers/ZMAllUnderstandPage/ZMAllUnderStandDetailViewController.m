//
//  ZMAllUnderStandDetailViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderStandDetailViewController.h"
#import "ZMAllUnderStandDetailView.h"
#import "ZMAllUnderStandTopCell.h"
#import "ZMMyAllUnderStandTopCell.h"
#import "ZMAllUnderStandAnswerCell.h"
#import "AVRecorder.h"
#import "ZMLoginViewController.h"
#import "ZMAimAnswererInfoTableViewCell.h"


@interface ZMAllUnderStandDetailViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) ZMAllUnderStandDetailView *currentView;
@property (nonatomic, assign) BOOL                      isShowVoice; //判断是否已弹出语音输入框
@property (nonatomic, strong) AVRecorder                *Recorder;
@property (nonatomic, strong) NSDictionary              *dataSource;
@property (nonatomic, strong) NSMutableArray            *getArray;   //选择答案
@property (nonatomic, strong) NSArray                   *answerArray;
@property (nonatomic, assign) BOOL                      isTextAnswer;//是否文字回答
@property (nonatomic, assign) BOOL                      isGetVoice;  //是否存在录音文件
@property (nonatomic, assign) BOOL                      isStartRecord;  //是否正在录音
@property (nonatomic, strong) MBProgressHUD             *hud;

/** 定时器 **/
@property (nonatomic, assign) BOOL             isPlayRecord;
@property (nonatomic, strong) NSTimer          *timer;
@property (nonatomic, assign) NSInteger        recordTime;
@property (nonatomic, assign) NSInteger        playTime;

@end

@implementation ZMAllUnderStandDetailViewController

- (void)loadView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentView = [[ZMAllUnderStandDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    self.currentView.detailTableView.delegate   = self;
    self.currentView.detailTableView.dataSource = self;
    self.currentView.msgTextField.delegate      = self;
    
    [self.currentView.keyBoardImgBtn addTarget:self action:@selector(toKeyboard)    forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.voiceImgBtn    addTarget:self action:@selector(toVoice)       forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.voiceBtn       addTarget:self action:@selector(answerAction)  forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.sendBtn        addTarget:self action:@selector(sendAnswer)    forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.confirmBtn     addTarget:self action:@selector(confirmAnswer) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.loginBtn       addTarget:self action:@selector(loginAction)   forControlEvents:UIControlEventTouchUpInside];
    
    [self.currentView.startVoiceBtn  addTarget:self action:@selector(startRecord)   forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.stopVoiceBtn   addTarget:self action:@selector(stopRecord)    forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.playVoiceBtn   addTarget:self action:@selector(playRecord)    forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.pauseVoiceBtn  addTarget:self action:@selector(pauseRecord)   forControlEvents:UIControlEventTouchUpInside];
    [self.currentView.repeatVoiceBtn addTarget:self action:@selector(repeatRecord)  forControlEvents:UIControlEventTouchUpInside];
    self.currentView.detailTableView.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"包打听";
    
    [self backButton];
    [self regiestNotification];
    [self loadDataSource];
    // 创建手势关闭键盘
    UITapGestureRecognizer *downKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downKeyBoard:)];
    [self.view addGestureRecognizer:downKeyBoard];
    
    _getArray = [[NSMutableArray alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[AudioPlayer sharedManager] stopPlayRecord:nil]; /** 停止所有播放的录音 */
}

/** 注册通知监听 */
- (void)regiestNotification {

    //注册键盘弹起回收监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册监听语音录制与上传
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mp3UploadComplete:) name:@"mp3UploadComplete" object:nil]; //上传成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mp3UploadFail)      name:@"mp3UploadFail" object:nil];     //上传失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlay)            name:@"endPlay" object:nil];           //播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioTime:)         name:@"audioTime" object:nil];         //录音时间
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allUnderStand_to_answer)  name:@"allUnderStand_to_answer" object:nil];
}

#pragma mark - dataSource
- (void)loadDataSource {
    
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    NSString *urlStr;
    if (_isMine) {
        urlStr = [NSString stringWithFormat:@"%@/question/my-publish-detail",APIDev];
    } else {
        urlStr = [NSString stringWithFormat:@"%@/question/detail",APIDev];
    }
    NSDictionary *param = @{@"id":_detailId};
    NSLog(@"param %@",param);
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {

        NSLog(@"dataSources : %@",object);
        
        [self.hud removeFromSuperview];
        if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {

            if (![[NSString stringWithFormat:@"%@",object[@"data"]] isEqualToString:@"<null>"]) {
                
                _dataSource  = object[@"data"];
                _answerArray = _dataSource[@"answer_lists"];
                
                
                /** 判断问题状态，改变底Bar */
                if ([[NSString stringWithFormat:@"%@",_dataSource[@"status"]] isEqualToString:@"asked"] ||
                    [[NSString stringWithFormat:@"%@",_dataSource[@"status"]] isEqualToString:@"dealt"]) {
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
                        //已登录
                        if ([[NSString stringWithFormat:@"%@",_dataSource[@"user"][@"user_id"]] isEqualToString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]]] || _isMine) {
                            //本人问题，确认答案，显示确认按钮
                            
                            if ([[NSString stringWithFormat:@"%@",_dataSource[@"is_can_choice"]] isEqualToString:@"1"]) {
                                self.currentView.inputView.alpha = 0;
                                self.currentView.footView.alpha  = 1;
                                self.currentView.confirmBtn.alpha= 1;
                                self.currentView.loginBtn.alpha  = 0;
                                self.currentView.unAuthView.alpha= 0;
                            } else {
                                self.currentView.inputView.alpha = 0;
                                self.currentView.footView.alpha  = 0;
                            }
                            
                            
                        } else {
                            if ([[NSString stringWithFormat:@"%@",_dataSource[@"is_can_answer"]] isEqualToString:@"1"]) {
                                //可以回答
                                self.currentView.inputView.alpha = 1;
                                self.currentView.footView.alpha  = 0;
                                
                                
                            } else {
                                //未认证，不能回答
                                self.currentView.inputView.alpha = 0;
                                self.currentView.footView.alpha  = 1;
                                self.currentView.confirmBtn.alpha= 0;
                                self.currentView.loginBtn.alpha  = 0;
                                self.currentView.unAuthView.alpha= 1;
                            }
                        }
                    } else {
                        //未登录，显示回答按钮，点击跳转登录页
                        self.currentView.inputView.alpha = 0;
                        self.currentView.footView.alpha  = 1;
                        self.currentView.confirmBtn.alpha= 0;
                        self.currentView.loginBtn.alpha  = 1;
                        self.currentView.unAuthView.alpha= 0;
                    }
                    
                } else {
                    //问题结束或过期
                    self.currentView.inputView.alpha = 0;
                    self.currentView.footView.alpha  = 0;
                }
                
                
                
                [UIView animateWithDuration:0.28 animations:^{
                    self.currentView.detailTableView.alpha = 1;
                }];
                [self.currentView.detailTableView reloadData];
                [self.currentView.detailTableView.mj_header endRefreshing];
            }
            
            
        } else {
            [self.currentView.detailTableView.mj_header endRefreshing];
            [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
        }
        
        

    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.currentView.detailTableView.mj_header endRefreshing];
        [self.hud removeFromSuperview];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    [self.currentView.detailTableView.mj_footer endRefreshing];
}

- (void)loadMoreData {

}

#pragma mark - textField
// 发送文字消息
- (BOOL)textFieldShouldReturn:(UITextField *)Textfield {
    
    if (![self.currentView.msgTextField.text isEqualToString:@""]) {

    }
    return YES;
}


#pragma mark - UITableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        
        if (_isMine) {
         
            if ([[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"<null>"] ||
                [[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"(null)"]) {
                
                return 12;
            } else {
                
                /** 指定回答 */
                return SCREEN_WIDTH/12.5;
            }
        } else {
        
            if ([[NSString stringWithFormat:@"%@",_dataSource[@"is_public"]] isEqualToString:@"0"]) {
                
                
                /** 不公开答案 */
                return SCREEN_WIDTH/12.5;
            }  else {
                
                return 12;
            }
        }
        
    } else if (section == 1) {

        NSArray *answerList = (NSArray *)_dataSource[@"answer_lists"];
        
        if ([[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"<null>"] ||
            [[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"(null)"]) {
            
            return 0.0001;
        } else {
            
            /** 指定回答 */
            
            if (answerList.count == 0) {
                return 12.5;
            } else {
                return 0.0001;
            }
            
        }
    } else {
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        if (![[NSString stringWithFormat:@"%@",_dataSource[@"is_public"]] isEqualToString:@"(null)"] &&
            [[NSString stringWithFormat:@"%@",_dataSource[@"is_public"]] isEqualToString:@"0"]) {
            
            UIView *hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/12.5)];
            
            UIImage *img = [UIImage imageNamed:@"au_hideAnswers"];
            UIImageView *tipsImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                                  (SCREEN_WIDTH/12.5 - img.size.height)/2,
                                                                                   img.size.width,
                                                                                   img.size.height)];
            tipsImage.image = img;
            
            UILabel *hideLable = [[UILabel alloc] initWithFrame:CGRectMake(tipsImage.right + 5,
                                                                           0,
                                                                           SCREEN_WIDTH - SCREEN_WIDTH/18.75 - tipsImage.width,
                                                                           SCREEN_WIDTH/12.5)];
            hideLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
            hideLable.textColor = [UIColor colorWithHex:@"666666"];
            hideLable.text = @"该提问者选择了不公开答案";
            
            [hideView addSubview:tipsImage];
            [hideView addSubview:hideLable];
            return hideView;
            
        } else if ((![[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"<null>"] &&
                    ![[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"(null)"])) {
            
            UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/12.5)];
            tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
            tipsLable.text = @"     已指定回答人";
            tipsLable.textColor = [UIColor colorWithHex:@"666666"];
            return tipsLable;
            
        } else {
        
            UIView *footer = [[UIView alloc] init];
            footer.backgroundColor = [UIColor clearColor];
            return footer;
        }

    } else {
        UIView *footer = [[UIView alloc] init];
        footer.backgroundColor = [UIColor clearColor];
        return footer;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return _answerArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (_isMine) {
            
            /** 文字 */
            CGSize   size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, 0);
            CGSize   autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",_dataSource[@"question"]]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85]
                                                         andSize:size];
            
            /** 红色提示文案 */
            CGFloat tipsHeight  = 0.0f;
            if (![[NSString stringWithFormat:@"%@",_dataSource[@"note"]] isEqualToString:@""]) {
                tipsHeight = (SCREEN_WIDTH/31.25) * 2;
            }
            
            /** 图片 */
            NSArray *imgArr   = (NSArray *)_dataSource[@"images"];
            CGFloat imgHeight = 0.0f;
            if (imgArr.count != 0) {
                imgHeight = SCREEN_WIDTH/6.25;
            } else {
                imgHeight = -SCREEN_WIDTH/37.5; //向上移动
            }

            return SCREEN_WIDTH/4.8/*其他*/ + autoSize.height/*文字*/ + imgHeight/*图片*/ + tipsHeight/** 提示 */;
            
        } else {
            
            CGSize   size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, 0);
            CGSize   autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",_dataSource[@"question"]]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85]
                                                         andSize:size];
            NSArray *imgArr    = (NSArray *)_dataSource[@"images"];
            CGFloat imgHeight  = 0.0f;
            if (imgArr.count != 0) {
                imgHeight = SCREEN_WIDTH/6.25;
            } else {
                //没图片
                imgHeight = -SCREEN_WIDTH/37.5; //向上移动
            }
            return SCREEN_WIDTH/3.75/*其他*/ + autoSize.height/*文字*/ + imgHeight/*图片*/;
        }
        
    }  else if (indexPath.section == 1) {
        
        NSArray *answerList = (NSArray *)_dataSource[@"answer_lists"];
    
        if ([[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"<null>"] ||
            [[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"(null)"]) {
            return 0;
        } else {
            if (answerList.count == 0) {
                return SCREEN_WIDTH/5.36;
            } else {
                return 0;
            }
        }
        
    } else {
        
        
        NSDictionary *answerDic = [_answerArray objectAt:indexPath.row];
        
        if ([[NSString stringWithFormat:@"%@",answerDic[@"audio"]] isEqualToString:@""]) {
            /** 文字 */
            CGSize   size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/10.7 - SCREEN_WIDTH/4.86, 0);
            CGSize   autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",answerDic[@"answer"]]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85]
                                                         andSize:size];
            
            /*  赏金 */
            CGFloat rewardHeight;
            if (![[NSString stringWithFormat:@"%@",answerDic[@"reward"]] isEqualToString:@"0"]) {
                rewardHeight = SCREEN_WIDTH/28.85 + SCREEN_WIDTH/37.5;
            } else {
                rewardHeight = 0;
            }
            
            if ([[NSString stringWithFormat:@"%@",answerDic[@"is_show_answer"]] isEqualToString:@"1"]) {
                /** 可见答案 */
                return SCREEN_WIDTH/6.81 + autoSize.height + 10/* 文字 */ + rewardHeight/* 获得赏金 */;
            } else {
                /** 不可见答案 */
                return SCREEN_WIDTH/6.81 + rewardHeight/* 获得赏金 */;
            }
            
            
        } else {
            /** 语音 */
         
            /*  赏金 */
            CGFloat rewardHeight;
            if (![[NSString stringWithFormat:@"%@",answerDic[@"reward"]] isEqualToString:@"0"]) {
                rewardHeight = SCREEN_WIDTH/28.85 + SCREEN_WIDTH/37.5;
            } else {
                rewardHeight = 0;
            }
            
            if ([[NSString stringWithFormat:@"%@",answerDic[@"is_show_answer"]] isEqualToString:@"1"]) {
                /** 可见答案 */
                return SCREEN_WIDTH/6.81 + SCREEN_WIDTH/8.15/* 语音 */ + rewardHeight/* 获得赏金 */;
            } else {
                /** 不可见答案 */
                return SCREEN_WIDTH/6.81 + rewardHeight/* 获得赏金 */;
            }
            
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
       
        static NSString *cellIndentifire = @"cell1";
        
        /** 问题详情 */
        if (_isMine) {
            ZMMyAllUnderStandTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
            if (!cell) {
                cell = [[ZMMyAllUnderStandTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.cancelBtn addTarget:self action:@selector(cancelAskQuestion) forControlEvents:UIControlEventTouchUpInside];
            [cell setValueWithDic:_dataSource];
            return cell;
        } else {
            ZMAllUnderStandTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
            if (!cell) {
                cell = [[ZMAllUnderStandTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValueWithDic:_dataSource];
            return cell;
        }
    } else if (indexPath.section == 1) {
    
        /** 指定回答者 */
        static NSString *cellIndentifire = @"cell2";
        ZMAimAnswererInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMAimAnswererInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        }
        if ([[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"<null>"] ||
            [[NSString stringWithFormat:@"%@",_dataSource[@"aim_answerer_info"]] isEqualToString:@"(null)"]) {
            [cell setValueWithDic:nil];
        } else {
            [cell setValueWithDic:(NSDictionary *)_dataSource[@"aim_answerer_info"]];
        }
        return cell;
    } else {
    
        /** 答案 */
        NSString *cellIndentifire = [NSString stringWithFormat:@"cell%ld%ld", indexPath.section, indexPath.row];
        ZMAllUnderStandAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMAllUnderStandAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        }
        if ([[NSString stringWithFormat:@"%@",_dataSource[@"is_can_choice"]] isEqualToString:@"1"]) {
            //本人问题，确认答案，显示确认按钮
            cell.getBtn.alpha = 1;
        } else {
            cell.getBtn.alpha = 0;
        }
        if (_isMine) {
            UILabel *voiceLable = [[cell.voiceBtn subviews] objectAtIndex:3];
            voiceLable.text = @"点击播放";
        }
        NSLog(@"%ld",indexPath.row);
        cell.getBtn.tag = indexPath.row;
        [cell.getBtn addTarget:self action:@selector(choiceAnswer:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.voiceBtn.tag = indexPath.row;
        [cell.voiceBtn addTarget:self action:@selector(audioPlay:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValueWithDic:[_answerArray objectAt:indexPath.row]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark - inputView 弹起与收回逻辑
//收到键盘弹出通知后的响应
- (void)keyboardWillShow:(NSNotification *)info {
    
    NSDictionary *dict             = info.userInfo;
    CGRect keyboardBounds          = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration                = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardBoundsRect      = [self.view convertRect:keyboardBounds toView:nil];
    double offsetY                 = keyboardBoundsRect.size.height;
    UIViewAnimationOptions options = [dict[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    self.currentView.voiceImgBtn.alpha    = 1;
    self.currentView.keyBoardImgBtn.alpha = 0;
    
    if (self.isShowVoice) {
        
        //切换为文字输入状态
        self.isTextAnswer = YES;
        if (_isStartRecord) {
            [self stopRecord];
        }
        
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
            self.currentView.inputView.transform  = CGAffineTransformMakeTranslation(0, -offsetY + (self.currentView.inputView.height - self.currentView.textView.height));
        } completion:nil];
        
        
    } else {
        
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            
            self.currentView.inputView.transform = CGAffineTransformMakeTranslation(0, -offsetY);
        } completion:nil];
        
    }
}

//隐藏键盘通知的响应
- (void)keyboardWillHide:(NSNotification *)info {
    
    NSDictionary *dict             = info.userInfo;
    double duration                = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [dict[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        self.currentView.inputView.transform         = CGAffineTransformIdentity;
        
    } completion:nil];
}

//关闭键盘
- (void)downKeyBoard:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
    if (self.isShowVoice) {
        
        if (_isStartRecord) {
            [self stopRecord];
        }
        self.isShowVoice = NO;
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.currentView.inputView.frame = CGRectMake(0,
                                                          SCREEN_HEIGHT - SCREEN_HEIGHT/13.34,
                                                          SCREEN_WIDTH,
                                                          SCREEN_WIDTH/2.43);
        }];
    }
}

//切换成键盘输入
- (void)toKeyboard {
    
    self.isTextAnswer = YES;
    self.currentView.voiceBtn.alpha       = 0;
    self.currentView.voiceImgBtn.alpha    = 1;
    self.currentView.keyBoardImgBtn.alpha = 0;
    

    [self.currentView.msgTextField becomeFirstResponder];
    
}

//切换成语音输入
- (void)toVoice {

    self.isTextAnswer = NO;
    self.currentView.voiceImgBtn.alpha    = 0;
    self.currentView.keyBoardImgBtn.alpha = 1;
    
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.38 animations:^{
        
        self.currentView.inputView.frame = CGRectMake(0,
                                                      SCREEN_HEIGHT - SCREEN_WIDTH/1.36,
                                                      SCREEN_WIDTH,
                                                      SCREEN_WIDTH/1.36);
    } completion:^(BOOL finished) {
        self.isShowVoice = YES;
    }];
}

- (void)answerAction {

    self.isShowVoice  = YES;
    self.isTextAnswer = NO;
    [UIView animateWithDuration:0.38 animations:^{
        
        self.currentView.inputView.frame = CGRectMake(0,
                                                      SCREEN_HEIGHT - SCREEN_WIDTH/1.36,
                                                      SCREEN_WIDTH,
                                                      SCREEN_WIDTH/1.36);
    } completion:^(BOOL finished) {
        self.isShowVoice = YES;
    }];
}


#pragma mark - 语音录制
- (AVRecorder *)Recorder {
    
    if (_Recorder == nil) {
        _Recorder = [[AVRecorder alloc] init];
    }
    return _Recorder;
}

- (void)startRecord {
    [self.Recorder startRecord];
    NSLog(@"开始录制");
    _isPlayRecord = NO;
    _isGetVoice = NO;
    _playTime = -1;
    _isStartRecord = YES;
    [self.timer setFireDate:[NSDate distantPast]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.currentView.startVoiceBtn.alpha  = 0;
        self.currentView.stopVoiceBtn.alpha   = 1;
        self.currentView.playVoiceBtn.alpha   = 0;
        self.currentView.pauseVoiceBtn.alpha  = 0;
        self.currentView.repeatVoiceBtn.alpha = 0;
        self.currentView.gifImage.alpha = 1;
        self.currentView.timeLable.alpha = 1;
    }];
}

- (void)stopRecord {
    [self.Recorder stopRecord];
    NSLog(@"停止录制");
    _isStartRecord = NO;
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.currentView.startVoiceBtn.alpha  = 0;
        self.currentView.stopVoiceBtn.alpha   = 0;
        self.currentView.playVoiceBtn.alpha   = 1;
        self.currentView.pauseVoiceBtn.alpha  = 0;
        self.currentView.repeatVoiceBtn.alpha = 1;
        self.currentView.gifImage.alpha = 0;
        self.currentView.timeLable.alpha = 0;
    }];
}

- (void)playRecord {
    [self.Recorder playRecord];
    NSLog(@"播放录音");
    
    _playTime     = _recordTime;
    _isPlayRecord = YES;
    [self.timer setFireDate:[NSDate distantPast]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.currentView.startVoiceBtn.alpha  = 0;
        self.currentView.stopVoiceBtn.alpha   = 0;
        self.currentView.playVoiceBtn.alpha   = 0;
        self.currentView.pauseVoiceBtn.alpha  = 1;
        self.currentView.repeatVoiceBtn.alpha = 1;
        self.currentView.gifImage.alpha = 1;
        self.currentView.timeLable.alpha = 1;
    }];
}

- (void)pauseRecord {
    [self.Recorder stopPlayRecord];
    NSLog(@"暂停播放");
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.currentView.startVoiceBtn.alpha  = 0;
        self.currentView.stopVoiceBtn.alpha   = 0;
        self.currentView.playVoiceBtn.alpha   = 1;
        self.currentView.pauseVoiceBtn.alpha  = 0;
        self.currentView.repeatVoiceBtn.alpha = 1;
        self.currentView.gifImage.alpha = 0;
        self.currentView.timeLable.alpha = 0;
    }];
}

- (void)repeatRecord {
    
    NSLog(@"重新录制");
    _playTime   = 0;
    _recordTime = 0;
    [self pauseRecord];
    [self.Recorder repeatRecord];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.currentView.startVoiceBtn.alpha  = 1;
        self.currentView.stopVoiceBtn.alpha   = 0;
        self.currentView.playVoiceBtn.alpha   = 0;
        self.currentView.pauseVoiceBtn.alpha  = 0;
        self.currentView.repeatVoiceBtn.alpha = 0;
        self.currentView.gifImage.alpha = 0;
        self.currentView.timeLable.alpha = 0;
    }];
}

//发送语音
- (void)postRecord {
    NSLog(@"发送录音");
    
    //发送回答（语音或者文字发送其中一个）
    [self.Recorder postRecord];
}

#pragma mark - 计时器
- (NSTimer *)timer {
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(workTime) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)workTime {
    
    if (_isPlayRecord) {
        if (_playTime > 0) {
            _playTime--;
        }
    } else {
        _playTime++;
    }
    NSInteger min    = (NSInteger)(_playTime % (3600)) / 60;
    NSInteger second = (NSInteger)(_playTime % 60);
    self.currentView.timeLable.text = [NSString stringWithFormat:@"%.2lu:%.2lu",(long)min,(long)second];
}



#pragma maek - 发送回答
- (void)sendAnswer {

    if (self.isTextAnswer) {
    
        /** 发送文字 */
        [self.view addSubview:self.hud];
        [self.hud show:YES];
        
        NSString     *urlStr   = [NSString stringWithFormat:@"%@/answer/create",APIDev];
        NSDictionary *param = @{@"question_id":_detailId,
                                @"answer":self.currentView.msgTextField.text};
        
        NSLog(@"param %@",param);
        
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
            
            NSLog(@"dataSources : %@",object);
            [self.hud removeFromSuperview];
            if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
                
                [self loadDataSource];
                [toolClass showProgress:@"发送成功" toView:self.view];
                self.currentView.msgTextField.text = @"";
            } else {
                [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.hud removeFromSuperview];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
        
    } else {
    
        /** 发送语音 */
        if (_isGetVoice) {
            [self postRecord];
            [self.view addSubview:self.hud];
            [self.hud show:YES];
        }
    }
}

//语音上传完成
- (void)mp3UploadComplete:(NSNotification *)info {
    
    NSDictionary *dic = (NSDictionary *)info.userInfo;
    NSLog(@"输出语音地址 : %@ %@",dic[@"url"],dic[@"time"]);
    
    
    NSString     *urlStr   = [NSString stringWithFormat:@"%@/answer/create",APIDev];
    NSDictionary *param = @{@"question_id":_detailId,
                            @"audio":[NSString stringWithFormat:@"%@",dic[@"name"]],
                            @"audio_time":[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",dic[@"time"]] integerValue] - 1]};
    
    NSLog(@"param %@",param);
    
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        
        NSLog(@"dataSources : %@",object);
        [self.hud removeFromSuperview];
        if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
            
            [self repeatRecord];
            self.isShowVoice = NO;
            [UIView animateWithDuration:0.3 animations:^{
                
                self.currentView.inputView.frame = CGRectMake(0,
                                                              SCREEN_HEIGHT - SCREEN_HEIGHT/13.34,
                                                              SCREEN_WIDTH,
                                                              SCREEN_WIDTH/2.43);
            }];

            [self loadDataSource];
            [toolClass showProgress:@"发送成功" toView:self.view];
        } else {
            [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
        }
 
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud removeFromSuperview];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

//语音上传失败
- (void)mp3UploadFail{
    
    [toolClass showProgress:@"发送失败" toView:self.view];
}

#pragma mark - customMethod
- (void)loginAction {

    NSLog(@"跳转登录");
    ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
    loginView.entranceType = @"allUnderStand_to_answer";
    UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self presentViewController:loginNC animated:YES completion:nil];
}

/** 撤销打听 */
- (void)cancelAskQuestion {
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil message:@"再等等可能就有答案了哦\n您确定要撤销答案吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定撤销" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self.view addSubview:self.hud];
        [self.hud show:YES];
        
        NSString     *urlStr   = [NSString stringWithFormat:@"%@/question/close",APIDev];
        NSDictionary *param = @{@"id":[NSNumber numberWithInteger:[_detailId integerValue]]};
        NSLog(@"param %@",param);
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
            
            NSLog(@"dataSources : %@",object);
            [self.hud removeFromSuperview];
            if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
                
                [toolClass showProgress:@"问题已经取消" toView:self.view];
                [self loadDataSource];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelQuestionRefresh" object:nil];
            } else {
                [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.hud removeFromSuperview];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"再等等" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];

    NSLog(@"撤销包打听");
    
}



#pragma mark - 监听登陆成功之后跳转
- (void)allUnderStand_to_answer {

    //登录成功之后刷新页面
    [self loadDataSource];
}







- (void)choiceAnswer:(UIButton *)sender {
    
    NSLog(@"选择答案");
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:2];
    ZMAllUnderStandAnswerCell *cell = [self.currentView.detailTableView cellForRowAtIndexPath:indexPath];
    UIImageView *imgView = [[cell.getBtn subviews] objectAtIndex:0];
    
    NSString *answerId = [NSString stringWithFormat:@"%@",[_answerArray objectAt:sender.tag][@"id"]];
    if ([_getArray containsObject:answerId]) {
        imgView.image = [UIImage imageNamed:@"symbol_noSelect"];
        [_getArray removeObject:answerId];
    } else {
        imgView.image = [UIImage imageNamed:@"symbol_select"];
        [_getArray addObject:answerId];
    }
    NSLog(@"选择答案 %@",_getArray);
}

- (void)confirmAnswer {
    
    NSLog(@"确认答案");
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    NSString     *urlStr   = [NSString stringWithFormat:@"%@/answer/choice-accept",APIDev];
    NSDictionary *param = @{@"question_id":_detailId,
                            @"answer_ids":_getArray};
    NSLog(@"param %@",param);
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        
        NSLog(@"dataSources : %@",object);
        [self.hud removeFromSuperview];
        if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
            
            [_getArray removeAllObjects];
            [self loadDataSource];
        } else {
            [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
        }
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud removeFromSuperview];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - AVRecord 录音状态通知
//语音播放结束
- (void)endPlay {

    [UIView animateWithDuration:0.18 animations:^{
        
        self.currentView.startVoiceBtn.alpha  = 0;
        self.currentView.stopVoiceBtn.alpha   = 0;
        self.currentView.playVoiceBtn.alpha   = 1;
        self.currentView.pauseVoiceBtn.alpha  = 0;
        self.currentView.repeatVoiceBtn.alpha = 1;
        self.currentView.gifImage.alpha = 0;
        self.currentView.timeLable.alpha = 0;
    }];
}

//获取录音时间
- (void)audioTime:(NSNotification *)info {

    NSLog(@"录音时长  %@",info.userInfo);
    _isGetVoice = YES;
    _recordTime = [[NSString stringWithFormat:@"%@",info.userInfo[@"time"]] integerValue];
}


#pragma mark - 播放网络语音
- (void)audioPlay:(UIButton *)sender {

    NSLog(@"%@",[_answerArray objectAt:sender.tag][@"audio"]);
    [[AudioPlayer sharedManager] playRecord:[NSString stringWithFormat:@"%@",[_answerArray objectAt:sender.tag][@"audio"]]
                                    withBtn:sender];
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

- (void)backButton {
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 64, 64);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,-50, 0, 10);
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
}

- (void)backAction {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMySounceAc" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
