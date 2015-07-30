//
//  DropButton.m
//  DropDown1
//
//  Created by houjing on 15/7/29.
//  Copyright (c) 2015年 aprees. All rights reserved.
//

#import "DropButton.h"
//button 高40，宽70
#define KFont 14
#define KImageWith 20
#define KImageHeight 20
#define KTitleHeight 20
#define kTitleWith 50

@implementation DropButton

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置文字
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:KFont];
        //设置图片
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 10, kTitleWith, KTitleHeight);
}

-(CGRect )imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(kTitleWith, 10, KImageWith, KImageHeight);
    
}

@end
