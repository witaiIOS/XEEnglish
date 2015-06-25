//
//  LoginVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "LoginVC.h"
#import "XeeService.h"

#import "PhoneLoginVC.h"
#import "ForgetPassWordVC.h"

@interface LoginVC ()<UITextFieldDelegate, PhoneLoginVCDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;


@property (strong, nonatomic) UIScrollView *myScrollView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登陆";
    
}

- (void)initUI
{
    [super initUI];
    
    self.phoneTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_phone.png"]];
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.codeTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
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


- (IBAction)loginAction:(id)sender {
    
    [self hideKeyboard];
    
    if (self.phoneTextField.text.length <= 0) {
        
        [UIFactory showAlert:@"用户名不能为空"];
        return;
        
    }
    else if (self.codeTextField.text.length < 6) {
        
        [UIFactory showAlert:@"密码不能少于6位数"];
        return;
        
    }else{
    
        [[XeeService sharedInstance] loginWithPhoneNumber:self.phoneTextField.text andPassword:self.codeTextField.text andBlock:^(NSDictionary *result, NSError *error) {
            if (!error) {
                
                NSNumber *r = result[@"result"];
                //NSLog(@"result:%@",result);
                if (r.integerValue == 0) {
                    
                    [[UserInfo sharedUser] setUserInfoDicWithWebServiceResult:result];//本地化存储用户信息
                    if ([self.delegate respondsToSelector:@selector(loginVCloginSuccess)]) {
                        [self.delegate loginVCloginSuccess];
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [UIFactory showAlert:result[@"resultInfo"]];
                }
            }else{
                [UIFactory showAlert:@"网络错误"];
            }
        }];
    
    }
}

- (IBAction)forgetPasswordAction:(id)sender {
    
    //忘记密码的去手机注册页面通过获取验证码先登录
    ForgetPassWordVC *forgetPasswordLoginVC = [[ForgetPassWordVC alloc] init];
    [self.navigationController pushViewController:forgetPasswordLoginVC animated:YES];
}

- (IBAction)phoneResigerAction:(id)sender {
    
    //没有注册的去手机注册页面注册
    PhoneLoginVC *phoneLoginVC = [[PhoneLoginVC alloc] init];
    phoneLoginVC.delegate = self;
    [self.navigationController pushViewController:phoneLoginVC animated:YES];
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - PhoneLoginVC delegate
- (void)phoneLoginRegisterSuccessWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password {
    self.phoneTextField.text = phoneNumber;
    self.codeTextField.text = password;
}

@end
