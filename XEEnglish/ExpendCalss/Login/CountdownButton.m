//
//  CountdownButton.m
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CountdownButton.h"
@interface CountdownButton()
@property (nonatomic, strong) NSString *titleFormat;    //倒计时格式
@property (nonatomic, strong) NSString *normalTitle;//获取验证码
@property (nonatomic, weak) NSTimer *mTimer;

@end

@implementation CountdownButton

- (id)initWithFrame:(CGRect)frame
               time:(float)time
             normal:(NSString *)normalTitle
      countingTitle:(NSString *)countingTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleFormat = [countingTitle stringByAppendingString:@"%.fs"];
        self.mTimeInterVal = time;
        self.mOriginalTime = time;
        self.normalTitle = normalTitle;
        [self setTitle:normalTitle forState:UIControlStateNormal];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return self;

}


- (void)timeMethod{
    
    self.mTimeInterVal--;
    if (self.mTimeInterVal < 0) {
        [self.mTimer invalidate];
        [self setMTimer:nil];
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
        self.enabled = YES;
    }else{
        [self setTitle:[NSString stringWithFormat:self.titleFormat,self.mTimeInterVal] forState:UIControlStateNormal];
    }
}


- (void)startCounting{
    
    self.mTimeInterVal = self.mOriginalTime;
    self.mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
    self.enabled = NO;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (self.mTimer) {
        [self.mTimer invalidate];
        [self setMTimer:nil];
    }
}



@end
