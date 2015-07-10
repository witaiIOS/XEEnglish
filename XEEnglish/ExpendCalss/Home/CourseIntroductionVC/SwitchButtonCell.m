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
    if (self.rowOfCell == 0) {
        NSString *status = [NSString stringWithFormat:@"%li",(long)!self.mySwtichBtn.on];
        //NSLog(@"status:%@",status);
        [self.delegate SwitchBtnValueChange:status andRowOfCell:self.rowOfCell];
    }
    else if (self.rowOfCell ==3){
        NSString *status = [NSString stringWithFormat:@"%li",(long)self.mySwtichBtn.on];
        //NSLog(@"status:%@",status);
        [self.delegate SwitchBtnValueChange:status andRowOfCell:self.rowOfCell];
    }
//    NSString *status = [NSString stringWithFormat:@"%li",(long)!self.mySwtichBtn.on];
//    //NSLog(@"status:%@",status);
//    [self.delegate SwitchBtnValueChange:status andRowOfCell:self.rowOfCell];
 
}

@end
