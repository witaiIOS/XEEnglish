//
//  PhoneLoginVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PhoneLoginVC.h"

@interface PhoneLoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation PhoneLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"手机注册";
}


- (void)initUI
{
    self.phoneTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_phone.png"]];
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.codeTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - My Action

- (IBAction)getCodeAction:(id)sender {
}


- (IBAction)nextAction:(id)sender {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
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
