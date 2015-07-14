//
//  ActivityHistoryCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface ActivityHistoryCell : BaseTVC
@property (strong, nonatomic) NSDictionary *activityHistoryInfo;

@property (weak, nonatomic) IBOutlet UILabel *activityHistoryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityHistoryTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityHistoryDeadlineTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityhistorySchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityHistoryPeopleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityHistoryImageView;

@end
