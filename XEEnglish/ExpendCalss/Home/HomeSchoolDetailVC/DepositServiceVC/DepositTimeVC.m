//
//  DepositTimeVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DepositTimeVC.h"

@interface DepositTimeVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *setDepositTimeDP;
@property (strong, nonatomic) NSString *myDate;

@end

@implementation DepositTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预定托管时间";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.setDepositTimeDP.minimumDate = [NSDate date];
}

- (IBAction)setDepositTime:(id)sender {
    
    NSDate *selectDate = [self.setDepositTimeDP date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    self.myDate = [dateFormatter stringFromDate:selectDate];
    
}

- (IBAction)keepBtn:(id)sender {
    
    [self.delegate DepositTimeVCSetTime:self.myDate];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
