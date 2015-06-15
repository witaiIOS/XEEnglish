//
//  otherRequireCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "otherRequireCell.h"

@implementation otherRequireCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.otherRequire = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, self.frame.size.height)];
    self.otherRequire.text = @"请输入－－";
    self.otherRequire.textColor = [UIColor darkGrayColor];
    self.otherRequire.backgroundColor = [UIColor whiteColor];
    self.otherRequire.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //self.otherRequire.delegate =self;//在场馆预定界面设置代理，以便输入时，输入框能上移。
    
    [self addSubview:self.otherRequire];
    
    return self;
}


//#pragma mark - UITextField Delegate
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    [textField becomeFirstResponder];
//    if ([textField.text isEqualToString:@"请输入－－"]) {
//        textField.text = @"";
//    }
//}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if ([string isEqualToString:@"\n"]) {
//        [textField resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}


@end
