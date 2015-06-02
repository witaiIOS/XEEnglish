//
//  ResetPassWordVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ResetPassWordVC.h"

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
    
    
    
    //保存完数据之后回到主界面
    [self.navigationController popToRootViewControllerAnimated:YES];
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
