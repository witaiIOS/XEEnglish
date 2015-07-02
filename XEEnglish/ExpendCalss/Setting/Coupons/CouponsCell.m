//
//  CouponsCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CouponsCell.h"

@implementation CouponsCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_iconButton setImage:[UIImage imageNamed:@"chekbox.png"] forState:UIControlStateNormal];
    [_iconButton setImage:[UIImage imageNamed:@"chekbox_select.png"] forState:UIControlStateSelected];
}


@end
