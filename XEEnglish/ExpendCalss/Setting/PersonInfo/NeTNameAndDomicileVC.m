//
//  NeTNameAndDomicileVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NeTNameAndDomicileVC.h"

@interface NeTNameAndDomicileVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myInfoField;

@end

@implementation NeTNameAndDomicileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _nTitle;
    self.myInfoField.placeholder = _nplaceholder;
}


- (IBAction)keepBtn:(id)sender {
    
    
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
