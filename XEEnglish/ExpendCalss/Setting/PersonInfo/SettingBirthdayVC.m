//
//  SettingBirthdayVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SettingBirthdayVC.h"

@interface SettingBirthdayVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *myBirthdayPicker;
@property (strong, nonatomic) NSString *myDate;

@end

@implementation SettingBirthdayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改生日";
    self.myBirthdayPicker.maximumDate = [NSDate date];//设置最大日期为当前日期
    //self.myBirthdayPicker.backgroundColor = [UIColor whiteColor];
}

#pragma mark - My Action
- (IBAction)ChangeDateAction:(id)sender {
    NSDate *select = [self.myBirthdayPicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     self.myDate =  [dateFormatter stringFromDate:select];
    
    //NSLog(@"%@",self.myDate);
}


- (IBAction)keepBtn:(id)sender {
    
    [self.delegate ChangeBirthday:self.myDate];
    [self.navigationController popViewControllerAnimated:YES];
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
