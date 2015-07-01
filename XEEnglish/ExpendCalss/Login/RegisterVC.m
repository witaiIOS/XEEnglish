//
//  RegisterVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "RegisterVC.h"
#import "XeeService.h"

@interface RegisterVC ()<UITextFieldDelegate, UIAlertViewDelegate>

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
        //密码加密之后上传
        NSString *md5String = [NSString md5:self.passwordTF.text];
        
        [[XeeService sharedInstance] registerWithPhoneNumber:_phoneNumber andName:self.nameTF.text andPassword:md5String andInvitation_code:self.recommendcodeTF.text andBlock:^(NSDictionary *result, NSError *error) {
            if (!error) {
                NSNumber *r = result[@"result"];
                
                if (r.integerValue == 0) {
                    [UIFactory showAlert:result[@"resultInfo"] tag:1000 delegate:self];
                    //[UIFactory showAlert:result[@"resultInfo"]];
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

/*- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}*/

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

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        
        if ([self.delegate respondsToSelector:@selector(registerSuccessWithPhoneNumber:andPassword:)]) {
            [self.delegate registerSuccessWithPhoneNumber:_phoneNumber andPassword:self.passwordTF.text];
        }                
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

@end
