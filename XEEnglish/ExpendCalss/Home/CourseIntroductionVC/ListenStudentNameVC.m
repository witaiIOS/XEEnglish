//
//  ListenStudentNameVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ListenStudentNameVC.h"

@interface ListenStudentNameVC ()<UITextFieldDelegate>

@end

@implementation ListenStudentNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学生姓名";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
}


#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)keepBtn:(id)sender {
    
    [self.delegate getStudentName:self.studentNameTF.text];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
