//
//  ChangePassWordVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ChangePassWordVC.h"
#import "ForgetPassWordVC.h"
#import "XeeService.h"

@interface ChangePassWordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *orgainPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *myNewPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmField;

@end

@implementation ChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
}

#pragma mark - My Action
- (IBAction)keepBtn:(id)sender {
    
    if (self.orgainPasswordField.text.length <= 0) {
        [UIFactory showAlert:@"请输入原始密码"];
        return;
    }
    else if (![self.orgainPasswordField.text isEqualToString:@"123456"]){
        [UIFactory showAlert:@"原始密码输入错误"];
        return;
    }
    else if (self.myNewPasswordField.text.length <= 0){
        [UIFactory showAlert:@"请填写新密码"];
        return;
    }
    else if (self.myNewPasswordField.text.length < 6 ||self.myNewPasswordField.text.length > 20){
        [UIFactory showAlert:@"输入密码不符合规范，请输入6位至20位字符作为密码"];
    }
    else if(self.confirmField.text.length <= 0){
        [UIFactory showAlert:@"请确认密码"];
    }
    else if(![self.myNewPasswordField.text isEqualToString:self.confirmField.text]){
        [UIFactory showAlert:@"确认密码错误"];
    }
    else{
        //密码加密之后上传
        NSString *md5NewString = [NSString md5:self.myNewPasswordField.text];
        
        NSString *md5OldString = [NSString md5:self.orgainPasswordField.text];
        
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *uUserInfoDic = userDic[uUserInfoKey];
        //NSLog(@"token:%@",uUserInfoDic[uUserToken]);
        [self showHudWithMsg:@"上传中..."];
        [[XeeService sharedInstance] modifyPwdWithNewPassword:md5NewString andOldPassword:md5OldString andParentId:uUserInfoDic[uUserId] andToken:uUserInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
            [self hideHud];
            if (!error) {
                NSNumber *r = result[@"result"];
                if (r.integerValue == 0) {
                    [UIFactory showAlert:result[@"resultInfo"]];
        
                }else{
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

- (IBAction)forgetBtn:(id)sender {
    
    //[self.navigationController popViewControllerAnimated:NO];
    ForgetPassWordVC *vc = [[ForgetPassWordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITextField Delegate

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
