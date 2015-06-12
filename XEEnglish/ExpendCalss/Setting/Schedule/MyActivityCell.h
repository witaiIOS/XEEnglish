//
//  MyActivityCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface MyActivityCell : BaseTVC

@property (nonatomic, strong) NSDictionary *activityinfo;

@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDeadlineTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activitySchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPeopleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;

- (IBAction)CancelButtonClicked:(id)sender;


@end
