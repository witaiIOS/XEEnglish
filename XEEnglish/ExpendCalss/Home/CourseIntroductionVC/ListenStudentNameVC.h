//
//  ListenStudentNameVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol ListenStudentNameVCGetStudentNameDelegate <NSObject>

@optional
- (void)getStudentName:(id) sender;

@end

@interface ListenStudentNameVC : BaseVC

@property (weak, nonatomic) IBOutlet UITextField *studentNameTF;
@property (nonatomic, assign) id<ListenStudentNameVCGetStudentNameDelegate>delegate;

- (IBAction)keepBtn:(id)sender;

@end
