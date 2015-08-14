//
//  DepositTimeVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//
#define TransferReceiveTime  @"TransferReceiveTime"
#define TransferSendTime     @"TransferSendTime"
#define DepositStartTime     @"DepositStartTime"
#define DepositEndTime       @"DepositEndTime"

#import "DepositTimeVC.h"

@interface DepositTimeVC ()

@property (weak, nonatomic) IBOutlet UIDatePicker *setDepositTimeDP;
@property (strong, nonatomic) NSString *myDate;

@end

@implementation DepositTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _nTitle;
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
    
    [self.delegate DepositTimeVCSetTime:self.myDate index:_index];
    [self.navigationController popViewControllerAnimated:YES];
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
