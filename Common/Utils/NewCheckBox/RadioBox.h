//
//  RadioBox.h
//
//  Created by 凌洛寒 on 14-5-14.
//  Copyright (c) 2014年 凌洛寒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioBox : UIControl

@property (nonatomic, assign, getter = isOn) BOOL on;//复选框状态
@property (nonatomic) BOOL isClick;
@property (nonatomic, strong) UIColor *onTintColor;//选中时的颜色
@property (nonatomic, strong) UIColor *tintColor;//正常状态的颜色
@property (nonatomic, strong) UIColor *boxColor;//盒子颜色
@property (nonatomic, strong) UIColor *boxBgColor;//盒子的背景色

@property (nonatomic, strong) UIColor *textColor;//字体颜色
@property (nonatomic, strong) UIFont *textFont;//字体大小
@property (nonatomic, strong) NSString *text;//显示的字
@property (nonatomic) NSInteger value;


- (void)setOn:(BOOL)on;//设置状态

@end
