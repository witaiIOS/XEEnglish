//
//  AddStudentVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol AddStudentVCDelegate <NSObject>

@optional
- (void)addStudentVCGetStudentName:(id) sender;

@end

@interface AddStudentVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *studentTF;
@property (nonatomic, assign) id<AddStudentVCDelegate>delegate;

- (IBAction)keepBtnClicked:(id)sender;
@end
