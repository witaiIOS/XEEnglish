//
//  CountdownButton.h
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownButton : UIButton
@property (nonatomic) float mTimeInterVal;

@property (nonatomic) float mOriginalTime;


- (id)initWithFrame:(CGRect )frame
               time:(float )time
             normal:(NSString *)normalTitle
      countingTitle:(NSString *)countingTitle;

- (void)startCounting;

@end
