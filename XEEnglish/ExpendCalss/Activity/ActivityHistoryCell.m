//
//  ActivityHistoryCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityHistoryCell.h"

@implementation ActivityHistoryCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //NSLog(@"info:%@",self.activityHistoryInfo);
    
    _activityHistoryTitleLabel.text = _activityHistoryInfo[@"title"];
    _activityHistoryTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", _activityHistoryInfo[@"start_time"], _activityHistoryInfo[@"end_time"]];
    _activityHistoryDeadlineTimeLabel.text = _activityHistoryInfo[@"deadline"];
    _activityhistorySchoolLabel.text = _activityHistoryInfo[@"address"];
    _activityHistoryPeopleLabel.text = [NSString stringWithFormat:@"人数%@/%@", _activityHistoryInfo[@"sum_current"], _activityHistoryInfo[@"sum_max"]];
    
    [_activityHistoryImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,_activityHistoryInfo[@"image_url"]]] placeholderImage:[UIImage imageNamed:@"course7.png"]];
}

@end
