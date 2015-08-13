//
//  SetInfoVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SetInfoVC.h"

@interface SetInfoVC ()<UITextFieldDelegate>

@end

@implementation SetInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _nTitle;
    self.infoTF.placeholder = _nplaceholder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)keepBtn:(id)sender {
    if ([self.index isEqualToString:@"ParentName"]) {
        [self.delegate SetInfoVCInputInfo:self.infoTF.text index:0];
    }
    else if ([self.index isEqualToString:@"ParentPhone"]){
        [self.delegate SetInfoVCInputInfo:self.infoTF.text index:1];
    }
    else if ([self.index isEqualToString:@"ChildrenName"]){
        [self.delegate SetInfoVCInputInfo:self.infoTF.text index:2];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
