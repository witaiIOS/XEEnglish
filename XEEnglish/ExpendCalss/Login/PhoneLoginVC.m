//
//  PhoneLoginVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PhoneLoginVC.h"
#import "CountdownButton.h"

#import "ResetPassWordVC.h"

#import "XeeService.h"

@interface PhoneLoginVC ()<UITextFieldDelegate>
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

#pragma mark - My Action

- (void)getCodeAction:(id)sender {
    if (self.phoneTextField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (self.phoneTextField.text.length <11 ||self.phoneTextField.text.length >11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入11位数的手机号" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }else{
        
        if (![self.phoneTextField.text hasPrefix:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号只能以\"1\"开头" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }else{
            
            [self.getCodeBtn startCounting];
            
            [[XeeService sharedInstance] checkPhoneWithPhoneNumber:self.phoneTextField.text andBlock:^(NSDictionary *result, NSError *error) {
                if (!error) {
                    
                    NSNumber *r = result[@"result"] ; //[result objectForKey:@"result"];
                    
                    if (r.integerValue == 0) {//成功
                        [UIFactory showAlert:result[@"resultInfo"]];
                    }
                    else{
                        [UIFactory showAlert:result[@"resultInfo"]];
                    }
                }
                else{
                }
            }];
        }
    }
}


- (IBAction)nextAction:(id)sender {
    
    [[XeeService sharedInstance] checkCodeWithPhoneNumber:self.phoneTextField.text andCode:self.codeTextField.text andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *r = result[@"result"];
            if (r.integerValue == 0) {
                //用验证码校验完登陆成功后去设置密码
                ResetPassWordVC *setPassWordVC = [[ResetPassWordVC alloc] init];
                [self.navigationController pushViewController:setPassWordVC animated:YES];
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
