//
//  HardwareDemandCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"
//#import "RadioBox.h"
//#import "RadioGroup.h"
//#import "TNCheckBoxGroup.h"
@protocol HardwareDemandCellSetNeedProjectorAndTeacherDelegate <NSObject>

@optional
- (void)setNeedProjectorAndTeacher:(id) sender andRowOfCell:(NSInteger)row;

@end

@interface HardwareDemandCell : BaseTVC
//设置代理方法的标记，标记被点击的cell
@property (nonatomic, assign) NSInteger rowOfCell;

@property (nonatomic, strong) UILabel *tipInfoLabel;
@property (nonatomic, strong) UILabel *yesLabel;
@property (nonatomic, strong) UILabel *noLabel;
//
@property (nonatomic, strong) UIButton *yesButton;
@property (nonatomic, strong) UIButton *noButton;
//@property (nonatomic, strong) RadioBox *boxNeed;
//@property (nonatomic, strong) RadioBox *boxUnNeed;

//@property (nonatomic, strong) RadioGroup *boxGroup;

//@property (nonatomic, strong) TNCircularCheckBox *banana;
//@property (nonatomic, strong) TNCircularCheckBox *strawberry;
//@property (nonatomic, strong) TNCheckBoxGroup *tnCheckBoxGroup;

//@property (nonatomic, strong) NSString *valueStr;//提供给外部的值。
@property (nonatomic, assign) id<HardwareDemandCellSetNeedProjectorAndTeacherDelegate>delegate;

@end
