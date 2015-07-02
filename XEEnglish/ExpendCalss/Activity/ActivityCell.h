//
//  ActivityCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@protocol ActivityCellActivityReserveBtnPressedDelegate <NSObject>

- (void)activityReserveBtnPressed:(id)sender;

@end

@interface ActivityCell : BaseTVC

@property (strong, nonatomic) NSDictionary *activityInfo;

@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDeadlineTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activitySchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPeopleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;

@property (nonatomic, assign) id<ActivityCellActivityReserveBtnPressedDelegate>delegate;

- (IBAction)reserveButtonClicked:(id)sender;

@end
