//
//  SwicthCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SwicthCell.h"

@implementation SwicthCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
}

- (IBAction)mySwitchBtnValueChange:(id)sender {
    if (self.rowOfCell == 0) {
        NSString *status = [NSString stringWithFormat:@"%li",(long)!self.mySwitchBtn.on];
        //NSLog(@"status:%@",status);
        [self.delegate SwicthCellSwitchBtnValueChange:status andRowOfCell:self.rowOfCell];
    }
    else if (self.rowOfCell ==3){
        NSString *status = [NSString stringWithFormat:@"%li",(long)self.mySwitchBtn.on];
        //NSLog(@"status:%@",status);
        [self.delegate SwicthCellSwitchBtnValueChange:status andRowOfCell:self.rowOfCell];
    }
}
@end
