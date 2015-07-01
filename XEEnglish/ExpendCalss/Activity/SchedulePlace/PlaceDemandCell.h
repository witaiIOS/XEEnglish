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
- (void)setPersonNumAndArea:(id) sender andRowOfCell:(NSInteger)row;

@end
@interface PlaceDemandCell : BaseTVC<UITextFieldDelegate>
//设置代理方法的标记，标记被点击的cell
@property (nonatomic, assign) NSInteger rowOfCell;
@property (nonatomic, strong) UILabel *tipInfoLabel;
@property (nonatomic, strong) UITextField *peopleAndPlaceTF;

@property (nonatomic, assign) id<PlaceDemandCellSetPersonNumAndAreaDelegate>delegate;

@end
