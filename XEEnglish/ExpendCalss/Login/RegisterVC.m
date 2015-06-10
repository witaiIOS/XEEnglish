//
//  RegisterVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "RegisterVC.h"
#import "XeeService.h"

@interface RegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@property (weak, nonatomic) IBOutlet UITextField *recommendcodeTF;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
}

- (void)initUI{
    
    [super initUI];
    
    self.nameTF.leftView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTF.leftView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.confirmPasswordTF.leftView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.confirmPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.recommendcodeTF.leftView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.recommendcodeTF.leftViewMode = UITextFieldViewModeAlways;
}


- (IBAction)registerBtn:(id)sender {
    
    if(self.nameTF.text.length <= 0){
        [UIFactory showAlert:@"请填写用户名"];
        return;
    }
    else if (self.passwordTF.text.length <= 0){
        [UIFactory showAlert:@"密码不能为空"];
        return;
    }
    else if(self.passwordTF.text.length <6 ||self.passwordTF.text.length >20){
        [UIFactory showAlert:@"请输入6位至20位字符作为密码"];
        return;
    }
    else if (self.confirmPasswordTF.text.length <= 0){
        [UIFactory showAlert:@"请确认密码"];
        return;
    }
    else if (![self.passwordTF.text isEqualToString:self.confirmPasswordTF.text]){
        [UIFactory showAlert:@"确认密码错误"];
        return;
    }
    //还差推荐信息的判断
    else{
        [[XeeService sharedInstance] registerWithPhoneNumber:@"13797040872" andName:self.nameTF.text andPassword:self.passwordTF.text andInvitation_code:self.confirmPasswordTF.text andBlock:^(NSDictionary *result, NSError *error) {
            if (!error) {
                NSNumber *r = result[@"result"];
                
                if (r.integerValue == 0) {
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
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
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
