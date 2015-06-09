//
//  DatePickerCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"



@interface DatePickerCell : BaseTVC<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *datePickerTF;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end
