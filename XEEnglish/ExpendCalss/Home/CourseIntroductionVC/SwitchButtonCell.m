//
//  SwitchButtonCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SwitchButtonCell.h"

@implementation SwitchButtonCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
}

- (IBAction)mySwitchBtnValueChange:(id)sender {
    
    [self.delegate SwitchBtnValueChange:sender andRowOfCell:self.rowOfCell];
}
@end
