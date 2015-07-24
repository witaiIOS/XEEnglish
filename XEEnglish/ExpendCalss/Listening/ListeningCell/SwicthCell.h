//
//  SwicthCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@protocol SwicthCellDelegate <NSObject>

@optional
- (void)SwicthCellSwitchBtnValueChange:(id) sender andRowOfCell:(NSInteger ) rowOfCell;

@end

@interface SwicthCell : BaseTVC

@property (nonatomic, assign) NSInteger rowOfCell;

@property (weak, nonatomic) IBOutlet UILabel *myTipLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *myDetailLabel;

@property (nonatomic, assign) id<SwicthCellDelegate>delegate;

- (IBAction)mySwitchBtnValueChange:(id)sender;

@end
