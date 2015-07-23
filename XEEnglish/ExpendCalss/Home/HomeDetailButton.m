//
//  HomeDetailButton.m
//  XEEnglish
//
//  Created by houjing on 15/7/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeDetailButton.h"

#define KFont 12
#define KImageWith 40
#define KImageHeight 40
#define KTitleHeight 20
#define kTitleWith 50

@implementation HomeDetailButton

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置文字
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:KFont];
        //设置图片
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(8, 5+KImageHeight+5, kTitleWith, KTitleHeight);
}

-(CGRect )imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(15, 5, KImageWith, KImageHeight);
    
}

@end
