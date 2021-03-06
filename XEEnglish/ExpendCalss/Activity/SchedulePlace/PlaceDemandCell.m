//
//  PlaceDemandCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PlaceDemandCell.h"

@implementation PlaceDemandCell

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
        self.tipInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, 80, 30)];
        self.tipInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.tipInfoLabel.textColor = [UIColor darkGrayColor];
        self.tipInfoLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.tipInfoLabel];
        
        self.peopleAndPlaceTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, 190, 30)];
        self.peopleAndPlaceTF.textAlignment = NSTextAlignmentCenter;
        self.peopleAndPlaceTF.textColor = [UIColor darkGrayColor];
        self.peopleAndPlaceTF.font = [UIFont systemFontOfSize:14];
        self.peopleAndPlaceTF.borderStyle = UITextBorderStyleNone;
        [self.peopleAndPlaceTF setBackgroundColor:RGBCOLOR(245, 245, 245)];
        self.peopleAndPlaceTF.keyboardType = UIKeyboardTypeDefault;
        self.peopleAndPlaceTF.delegate = self;
        
        [self addSubview:self.peopleAndPlaceTF];
    }
    
    return self;
}

#pragma mark － UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        //设置代理方法，修改场馆预定的人数和面积的值
        [self.delegate setPersonNumAndArea:self.peopleAndPlaceTF.text andRowOfCell:self.rowOfCell];
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置代理方法，修改场馆预定的人数和面积的值
    [self.delegate setPersonNumAndArea:self.peopleAndPlaceTF.text andRowOfCell:self.rowOfCell];
    [textField resignFirstResponder];
}

@end
