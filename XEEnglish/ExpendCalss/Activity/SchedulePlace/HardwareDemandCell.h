//
//  HardwareDemandCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface HardwareDemandCell : BaseTVC

@property (nonatomic, strong) UILabel *tipInfoLabel;
@property (nonatomic, strong) UILabel *yesLabel;
@property (nonatomic, strong) UILabel *noLabel;

@property (nonatomic, strong) UIButton *yesButton;
@property (nonatomic, strong) UIButton *noButton;

@property (nonatomic, strong) NSString *valueStr;//提供给外部的值。

@end
