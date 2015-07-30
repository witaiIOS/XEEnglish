//
//  PhotoMonthButton.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PhotoMonthButton.h"

#define KFont 12
#define KImageWith 90
#define KImageHeight 110
#define KTitleHeight 20
#define kTitleWith 90

@implementation PhotoMonthButton

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置文字
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:KFont];
        //设置图片
        self.imageView.contentMode=UIViewContentModeScaleToFill;
    }
    return self;
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(5, 5+KImageHeight+5, kTitleWith, KTitleHeight);
}

-(CGRect )imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(5, 5, KImageWith, KImageHeight);
    
}

@end
