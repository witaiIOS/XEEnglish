//
//  PlaceDemandCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
@protocol PlaceDemandCellSetPersonNumAndAreaDelegate <NSObject>

@optional
- (void)setPersonNumAndArea:(id) sender;

@end
@interface PlaceDemandCell : BaseTVC<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *tipInfoLabel;
@property (nonatomic, strong) UITextField *peopleAndPlaceTF;

@property (nonatomic, assign) id<PlaceDemandCellSetPersonNumAndAreaDelegate>delegate;

@end
