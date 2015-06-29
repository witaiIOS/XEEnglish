//
//  FeedBackVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FeedBackVC.h"
#import "XeeService.h"

@interface FeedBackVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *feedTV;

@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)submitBtnClicked:(id)sender {
    if ([self.feedTV.text isEqualToString:@"请输入您的宝贵意见"]) {
        [UIFactory showAlert:@"意见不能为空"];
    }
    else{
        [self addFeedback];
        self.feedTV.text = @"请输入您的宝贵意见";
    }
    
}

#pragma mark -Web
- (void)addFeedback{
    
    NSDictionary *userInfo = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userDetailInfo = userInfo[uUserInfoKey];
    [[XeeService sharedInstance] addFeedbackWithBugInfo:self.feedTV.text andParentId:userDetailInfo[uUserId] andToken:userDetailInfo[uUserToken] andBolck:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                [UIFactory showAlert:result[@"resultInfo"]];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请输入您的宝贵意见"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.feedTV resignFirstResponder];
        return NO;
    }
    return YES;
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
