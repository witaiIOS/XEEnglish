//
//  LoginVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "LoginVC.h"
#import "PhoneLoginVC.h"

@interface LoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (strong, nonatomic) UIScrollView *myScrollView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTitleBar];
}

- (void)initTitleBar
{
    self.title = @"登陆";
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, self.view.frame.size.width/8, 30)];
    //[leftBtn setTitle:@"" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_backButtonBg.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
- (void)initUI
{
    self.phoneTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_phone.png"]];
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.codeTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_course@2x.png"]];
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
}


#pragma mark - My Action

- (void)leftClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginAction:(id)sender {
    
    
}

- (IBAction)forgetPasswordAction:(id)sender {
}

- (IBAction)phoneResigerAction:(id)sender {
    PhoneLoginVC *phoneLoginVC = [[PhoneLoginVC alloc] init];
    
    UINavigationController *phoneLoginNC = [[UINavigationController alloc] initWithRootViewController:phoneLoginVC];
    [self presentViewController:phoneLoginNC animated:YES completion:nil];
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
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
