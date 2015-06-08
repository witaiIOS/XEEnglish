//
//  ActivityContentCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityContentCell.h"

@implementation ActivityContentCell

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
        self.activityContent = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, self.frame.size.height)];
        self.activityContent.delegate = self;
        self.activityContent.font = [UIFont systemFontOfSize:14];
        self.activityContent.textColor = [UIColor darkGrayColor];
        self.activityContent.backgroundColor = [UIColor whiteColor];
        self.activityContent.text = @"请输入－－";
        self.activityContent.keyboardType = UIKeyboardTypeDefault;
        
        [self addSubview:self.activityContent];
    }
    
    
    return self;
}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [textView becomeFirstResponder];
    
    if ([textView.text isEqualToString:@"请输入－－"]) {
        textView.text = @"";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



@end
