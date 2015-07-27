//
//  addStudentBirthday.h
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol AddStudentBirthdayDelegate <NSObject>

@optional
- (void)addStudentBirthdayGetBirthday: (id) sender;

@end

@interface addStudentBirthday : BaseVC
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayDP;
@property (nonatomic, assign) id<AddStudentBirthdayDelegate>delegate;

- (IBAction)getBrithday:(id)sender;

- (IBAction)keepBtnClicked:(id)sender;
@end
