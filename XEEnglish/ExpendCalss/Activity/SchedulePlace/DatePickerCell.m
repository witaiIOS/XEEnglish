//
//  DatePickerCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DatePickerCell.h"

@implementation DatePickerCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 100, 30)];
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        self.dateLabel.textColor = [UIColor darkGrayColor];
        self.dateLabel.font = [UIFont systemFontOfSize:14];
        self.dateLabel.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.dateLabel];
        
        self.datePickerTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, 160, 30)];
        self.datePickerTF.textAlignment = NSTextAlignmentRight;
        self.datePickerTF.textColor =[UIColor darkGrayColor];
        self.datePickerTF.font = [UIFont systemFontOfSize:14];
        self.datePickerTF.backgroundColor = [UIColor whiteColor];
        self.datePickerTF.borderStyle = UITextBorderStyleNone;
        self.datePickerTF.keyboardType = UIKeyboardTypeDefault;
        self.datePickerTF.delegate = self;
        
        [self addSubview:self.datePickerTF];
    }
    
    return self;
}


#pragma mark - My Action
- (void)confirmBtnActon:(id)sender{
    [self.datePickerTF resignFirstResponder];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    self.datePickerTF.text = [dateFormatter stringFromDate:self.datePicker.date];
}

- (void)cancelBtnActon:(id)sender{
    [self.datePickerTF resignFirstResponder];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.datePicker = [[UIDatePicker alloc] init];
    
    self.datePickerTF.inputView = self.datePicker;
    
    UIToolbar *accessoryView = [[UIToolbar alloc] init];
    accessoryView.frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
    accessoryView.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width/2, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor orangeColor]];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnActon:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height-30, self.frame.size.width/2, 30)];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor orangeColor]];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnActon:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *confirmBtnItem = [[UIBarButtonItem alloc] initWithCustomView:confirmBtn];
    
    UIBarButtonItem *spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    accessoryView.items=@[spaceBtn,cancelBtnItem,spaceBtn,confirmBtnItem,spaceBtn];
    
    self.datePickerTF.inputAccessoryView =accessoryView;
}



@end