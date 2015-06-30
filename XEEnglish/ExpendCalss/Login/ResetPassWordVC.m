//
//  ResetPassWordVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ResetPassWordVC.h"

#import "XeeService.h"

@interface ResetPassWordVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myNewPasswordField;

@property (weak, nonatomic) IBOutlet UITextField *confirmField;

@end

@implementation ResetPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
}

#pragma mark - My Action
- (IBAction)keepBtn:(id)sender {
    
    if([self.myNewPasswordField.text isEqualToString:self.confirmField.text]){
        
        //密码加密之后上传
        NSString *md5String = [self md5:self.myNewPasswordField.text];
        
        [[XeeService sharedInstance] modifyPwdByMobilephoneWithPhoneNumber:@"13797040872" andPassword:md5String andBlock:^(NSDictionary *result, NSError *error) {
            NSNumber *r = result[@"result"];
            if (!error) {
                if (r.integerValue == 0) {
                    //保存完数据之后回到主界面
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    
                }
            }else{
                [UIFactory showAlert:@"网络错误"];
            }
        }];
    }
    
    
    
    
}

- (NSString *)md5:(NSString *)str
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
