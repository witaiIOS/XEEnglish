//
//  FeedBackVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *feedTV;

@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)submitBtnClicked:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"建议已提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}



#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请输入您的宝贵意见"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
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
