//
//  SwitchButtonCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@protocol SwitchButtonCellSwitchBtnValueChangeDelegate <NSObject>

@optional
- (void)SwitchBtnValueChange:(id) sender andRowOfCell:(NSInteger ) rowOfCell;

@end

@interface SwitchButtonCell : BaseTVC
@property (nonatomic, assign) NSInteger rowOfCell;

@property (weak, nonatomic) IBOutlet UILabel *myTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *myDetailLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwtichBtn;

- (IBAction)mySwitchBtnValueChange:(id)sender;
@end
