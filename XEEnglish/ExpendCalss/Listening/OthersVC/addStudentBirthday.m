//
//  addStudentBirthday.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "addStudentBirthday.h"

@interface addStudentBirthday ()
@property (nonatomic, strong) NSString *brithday;
@end

@implementation addStudentBirthday

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置生日";
    self.birthdayDP.maximumDate = [NSDate date];//设置最大日期为当前日期
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
}


- (IBAction)getBrithday:(id)sender {
    
    NSDate *selectedDate = [self.birthdayDP date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.brithday = [dateFormatter stringFromDate:selectedDate];
}

- (IBAction)keepBtnClicked:(id)sender {
    
    [self.delegate addStudentBirthdayGetBirthday:self.brithday];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
