//
//  ForgetPassWordVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ForgetPassWordVC.h"
#import "CountdownButton.h"
#import "ResetPassWordVC.h"

@interface ForgetPassWordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) CountdownButton *getCodeBtn;

@end

@implementation ForgetPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
}

- (void)initUI{
    
    [super initUI];
    
    self.phoneTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_phone.png"]];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.codeTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    
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
    if (self.phoneTF.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (self.phoneTF.text.length <11 ||self.phoneTF.text.length >11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入11位数的手机号" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }else{
        
        if (![self.phoneTF.text hasPrefix:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号只能以\"1\"开头" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        else{
            
            [self.getCodeBtn startCounting];
            
        }
    }
}

- (IBAction)keepBtn:(id)sender {
    
    ResetPassWordVC *vc = [[ResetPassWordVC alloc] init];
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
