//
//  SettingSignatureVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SettingSignatureVC.h"

@interface SettingSignatureVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *mySignatureTextView;

@end

@implementation SettingSignatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改个性签名";
}



#pragma mark - My Action
- (IBAction)keepBtn:(id)sender {
    
    
}


#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([self.mySignatureTextView.text isEqualToString:@"请输入您的个性签名"]) {
        self.mySignatureTextView.text = @"";
        self.mySignatureTextView.textColor = [UIColor darkGrayColor];
    }
    [self.mySignatureTextView becomeFirstResponder];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.mySignatureTextView resignFirstResponder];
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
