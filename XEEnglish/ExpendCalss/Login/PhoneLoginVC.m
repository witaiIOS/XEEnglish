//
//  PhoneLoginVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PhoneLoginVC.h"
#import "CountdownButton.h"

#import "RegisterVC.h"

#import "XeeService.h"

@interface PhoneLoginVC ()<UITextFieldDelegate, RegisterVCDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) CountdownButton *getCodeBtn;

@end

@implementation PhoneLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"手机注册";
}


- (void)initUI
{
    [super initUI];
    self.phoneTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_phone.png"]];
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.codeTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.getCodeBtn = [[CountdownButton alloc] initWithFrame:CGRectMake(210, 80, 90, 40) time:60 normal:@"获取验证码" countingTitle:@"重新获取"];
    [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getCodeBtn setBackgroundColor:[UIColor orangeColor]];
    //self.getCodeBtn.layer.cornerRadius = 4.0;
    [self.getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getCodeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hideKeyboard];
}

#pragma mark -myself
- (void)hideKeyboard {
    if ([self.phoneTextField isFirstResponder]) {
        [self.phoneTextField resignFirstResponder];
    }
    else if ([self.codeTextField isFirstResponder]) {
        [self.codeTextField resignFirstResponder];
    }
    
}


#pragma mark - My Action

- (void)getCodeAction:(id)sender {
    if (self.phoneTextField.text.length <= 0) {
        
        [UIFactory showAlert:@"手机号不能为空"];
        return;
        
    }
    if (self.phoneTextField.text.length <11 ||self.phoneTextField.text.length >11) {
        
        [UIFactory showAlert:@"请输入11位数的手机号"];
        return;
        
    }else{
        
        if (![self.phoneTextField.text hasPrefix:@"1"]) {
            
            [UIFactory showAlert:@"手机号只能以\"1\"开头"];
            return;
            
        }else{
            
            [self.getCodeBtn startCounting];
            
            [[XeeService sharedInstance] checkPhoneWithPhoneNumber:self.phoneTextField.text andSign:@"2" andBlock:^(NSDictionary *result, NSError *error) {
                if (!error) {
                    
                    NSNumber *r = result[@"result"];
                    
                    if (r.integerValue == 0) {//成功
                        //[UIFactory showAlert:result[@"resultInfo"]];
                    }
                    else{
                        [UIFactory showAlert:result[@"resultInfo"]];
                    }
                }
                else{
                    [UIFactory showAlert:@"网络错误"];
                }

            }];
        }
    }
}


- (IBAction)nextAction:(id)sender {
    
    [self hideKeyboard];
    
    if(self.codeTextField.text.length <= 0){
        [UIFactory showAlert:@"请输入验证码"];
        return;
    }
    else if (self.codeTextField.text.length != 6){
        [UIFactory showAlert:@"验证码输入错误"];
        return;
    }
    else{
        
        [[XeeService sharedInstance] checkCodeWithPhoneNumber:self.phoneTextField.text andCode:self.codeTextField.text andSign:@"2" andBlock:^(NSDictionary *result, NSError *error) {
            
            if (!error) {
                NSNumber *r = result[@"result"];
                if (r.integerValue == 0) {
                    //用验证码校验完登陆成功后去设置密码
                    RegisterVC *registerVC = [[RegisterVC alloc] init];
                    registerVC.phoneNumber = self.phoneTextField.text;
                    registerVC.delegate = self;
                    [self.navigationController pushViewController:registerVC animated:YES];
                }
                else {
                    [UIFactory showAlert:result[@"resultInfo"]];
                }
            }
            else {
                [UIFactory showAlert:@"网络错误"];
            }

        }];
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;

}

#pragma mark - RegisterVC delegate
- (void)registerSuccessWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password {
    if ([self.delegate respondsToSelector:@selector(phoneLoginRegisterSuccessWithPhoneNumber:andPassword:)]) {
        
        [self.delegate phoneLoginRegisterSuccessWithPhoneNumber:phoneNumber andPassword:password];
    }
}


@end
