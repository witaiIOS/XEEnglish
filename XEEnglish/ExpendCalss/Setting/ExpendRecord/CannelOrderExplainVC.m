//
//  CannelOrderExplainVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CannelOrderExplainVC.h"
#import "XeeService.h"

@interface CannelOrderExplainVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *explainTextView;

@end

@implementation CannelOrderExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"取消订单说明";
    
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    //添加键盘上的done按钮
    [self addKeyboardDone];
}

#pragma mark - AddKeyboardDone
- (void)addKeyboardDone{
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(dismissKeyBoard)];
    
    NSArray * buttonsArray = @[btnSpace, doneButton];;
    [topView setItems:buttonsArray];
    [self.explainTextView setInputAccessoryView:topView];//当文本输入框加上topView
    topView = nil;
}

-(IBAction)dismissKeyBoard
{
    [self.explainTextView resignFirstResponder];
}

#pragma mark - My Action
- (IBAction)submitBtnClicked:(id)sender {
    
    if ([self.explainTextView.text length] <= 0) {
        [UIFactory showAlert:@"请填写取消订单说明"];
    }
    else{
        [self CancelOrderWithWeb];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Web
- (void)CancelOrderWithWeb{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    NSString *niceExplain = [self.explainTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self showHudWithMsg:@"上传中..."];
    [[XeeService sharedInstance] cancelOrderWithParentId:userInfoDic[uUserId] andRelationId:self.expendRecordInfoDic[@"order_id"] andRemark:niceExplain andType:@"4" andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"resulr:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                [UIFactory showAlert:result[@"resultInfo"]];
            }else{
                [UIFactory showAlert:result[@"未知错误"]];
            }
        }else{
            [UIFactory showAlert:result[@"网络错误"]];
        }
    }];
}


#pragma mark - UITextViewDelegate
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    
//    [textView becomeFirstResponder];
//}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
}


@end
