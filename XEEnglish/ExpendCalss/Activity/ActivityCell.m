//
//  ActivityCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityCell.h"


@implementation ActivityCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _activityTitleLabel.text = _activityInfo[@"title"];
    _activityTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", _activityInfo[@"start_time"], _activityInfo[@"end_time"]];
    _activityDeadlineTimeLabel.text = _activityInfo[@"deadline"];
    _activitySchoolLabel.text = _activityInfo[@"address"];
    _activityPeopleLabel.text = [NSString stringWithFormat:@"人数%@/%@", _activityInfo[@"sum_current"], _activityInfo[@"sum_max"]];
    
    [_activityImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,_activityInfo[@"image_url"]]] placeholderImage:[UIImage imageNamed:@"course7.png"]];
    //NSLog(@"%@",_activityInfo[@"image_url"]);
    
    //判断，人数满了之后将按钮置灰
    if ([self.activityInfo[@"sum_current"] isEqualToString:self.activityInfo[@"sum_max"]]) {
        [self.reserveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.reserveBtn setBackgroundColor:[UIColor grayColor]];
        self.reserveBtn.enabled = NO;
    }
    else{
        [self.reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.reserveBtn setBackgroundColor:[UIColor orangeColor]];
        self.reserveBtn.enabled = YES;
    }
}

- (IBAction)reserveButtonClicked:(id)sender {
    
    NSString *activityId = self.activityInfo[@"activity_id"];
    
    [self.delegate activityReserveBtnPressed:activityId];
}

@end
