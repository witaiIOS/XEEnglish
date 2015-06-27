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
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *uUserInfoDic = userDic[uUserInfoKey];
        //NSLog(@"token:%@",uUserInfoDic[uUserToken]);
        [[XeeService sharedInstance] modifyPwdWithNewPassword:self.myNewPasswordField.text andOldPassword:self.orgainPasswordField.text andParentId:uUserInfoDic[uUserId] andToken:uUserInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
            
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
