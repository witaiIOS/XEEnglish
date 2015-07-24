//
//  SwicthCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface SwicthCell : BaseTVC

@property (weak, nonatomic) IBOutlet UILabel *myTipLabel;

@property (weak, nonatomic) IBOutlet UISwitch *mySwitchBtn;

@property (weak, nonatomic) IBOutlet UILabel *myDetailLabel;

- (IBAction)mySwitchBtnValueChange:(id)sender;

@end
