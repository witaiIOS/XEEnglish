//
//  DatePickerCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
@protocol DatePickerCellChangeDateMarkDelegate <NSObject>

@optional
- (void)changeDateMark:(id) sender andRowOfCell:(NSInteger)row;

@end


@interface DatePickerCell : BaseTVC<UITextFieldDelegate>
//设置代理方法的标记，标记被点击的cell
@property (nonatomic, assign) NSInteger rowOfCell;
@property (nonatomic, strong) UITextField *datePickerTF;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
//改变预定场馆界面的开始时间和结束时间的标记和代理，changeDateMark为0改变开始时间，为1改变结束时间
@property (nonatomic, assign) id<DatePickerCellChangeDateMarkDelegate>delegate;
@end
