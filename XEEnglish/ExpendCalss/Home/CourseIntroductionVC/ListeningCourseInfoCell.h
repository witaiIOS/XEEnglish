//
//  ListeningCourseInfoCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
@protocol InputCourseHoursDelegate <NSObject>

@optional
- (void)inputCourseHours:(id) sender;

@end

@interface ListeningCourseInfoCell : BaseTVC<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UITextField *myPriceTF;

@property (nonatomic, strong) UILabel *myLineLabel;

@property (nonatomic, strong) id<InputCourseHoursDelegate>delegate;
@end
