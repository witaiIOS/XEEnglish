//
//  MyActivityCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyActivityCell.h"

@implementation MyActivityCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.activityTitleLabel.text = self.activityinfo[@"title"];
    self.activityTimeLabel.text = [NSString stringWithFormat:@"%@~%@",self.activityinfo[@"start_time"],self.activityinfo[@"end_time"]];
    self.activityDeadlineTimeLabel.text = self.activityinfo[@"deadline"];
    [self.activityImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.activityinfo[@"image_url"]]] placeholderImage:[UIImage imageNamed:@"course7.png"]];
    
    self.activitySchoolLabel.text = self.activityinfo[@"address"];
    self.activityPeopleLabel.text = [NSString stringWithFormat:@"%@/%@",self.activityinfo[@"sum_current"],self.activityinfo[@"sum_max"]];
}

- (IBAction)CancelButtonClicked:(id)sender {
}
@end
