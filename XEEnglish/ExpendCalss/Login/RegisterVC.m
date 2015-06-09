//
//  RegisterVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()<UITextFieldDelegate>

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
    
    
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
