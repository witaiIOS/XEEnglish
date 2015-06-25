//
//  ListeningCourseInfoCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ListeningCourseInfoCell.h"

@implementation ListeningCourseInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, 80, 30)];
        self.myLabel.textColor = [UIColor blackColor];
        self.myLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.myLabel];
        
        
        self.myPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2, 6, kScreenWidth/2 - 40, 30)];
        self.myPriceTF.textColor = [UIColor grayColor];
        self.myPriceTF.font = [UIFont systemFontOfSize:14];
        self.myPriceTF.textAlignment = NSTextAlignmentRight;
        self.myPriceTF.keyboardType = UIKeyboardTypeDefault;
        self.myPriceTF.delegate = self;
        
        [self.contentView addSubview:self.myPriceTF];
        
        self.myLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 39, 60, 1)];
        self.myLineLabel.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:self.myLineLabel];
        
    }
    
    return self;
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
