//
//  CommentButton.m
//  XEEnglish
//
//  Created by houjing on 15/7/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#define kFont 12
#define KImageWith 40
#define KImageHeight 40
#define KTitleHeight 20
#define kTitleWith 40

#import "CommentButton.h"

@implementation CommentButton

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:kFont];
        //设置图片自适应
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(5, 5, kTitleWith, KTitleHeight);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(5, 5+KTitleHeight+5, KImageWith, KImageHeight);
}


@end
