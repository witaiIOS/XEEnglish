//
//  ListenCourseVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@interface ListenCourseVC : BaseVC
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseHourPrice;

- (IBAction)courseTypeClicked:(id)sender;

- (IBAction)schoolSelectedClicked:(id)sender;

- (IBAction)listenAtSchoolClicked:(id)sender;
- (IBAction)listenAtHomeClicked:(id)sender;


- (IBAction)applyBtnClicked:(id)sender;

@end
