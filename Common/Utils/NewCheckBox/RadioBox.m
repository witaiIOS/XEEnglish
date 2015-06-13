//
//  RadioBox.m
//
//  Created by 凌洛寒 on 14-5-14.
//  Copyright (c) 2014年 凌洛寒. All rights reserved.
//

#import "RadioBox.h"


#define RadioBoxMaxWidth 31.0f
#define RadioBoxMinWidth 20.0f

@interface RadioBox ()

@property (nonatomic, strong) UIView *containerView;//容器视图
@property (nonatomic, strong) UIView *onBoxView;//外框选中的视图
@property (nonatomic, strong) UIView *offBoxView;//外框未选中的仕途
@property (nonatomic, strong) UIView *offKnobView;//关闭球心
@property (nonatomic, strong) UIView *knobView;//开启球心
@property (nonatomic, strong) UILabel *lbText;//文字

- (void)commonInit;//

- (CGRect)roundRect:(CGRect)frameOrBounds;//frame

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer;//手势识别器

@end

@implementation RadioBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[self roundRect:frame]];
    if (self) {
        [self commonInit];
        self.isClick = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
        self.isClick = NO;
    }
    
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:[self roundRect:bounds]];
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:[self roundRect:frame]];
    
    [self setNeedsLayout];
}


-(void)setText:(NSString *)text
{
    if (_text != text) {
        _text = text;
        
        _lbText.text = text;
    }
}

-(void)setTextColor:(UIColor *)textColor
{
    _lbText.textColor = textColor;
}

-(void)setTextFont:(UIFont *)textFont
{
    _lbText.font = textFont;
}

- (void)setOnTintColor:(UIColor *)onTintColor
{
    if (_onTintColor != onTintColor) {
        _onTintColor = onTintColor;
        
        _onBoxView.backgroundColor = onTintColor;
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        
        _offBoxView.backgroundColor = tintColor;
    }
}


- (void)setBoxColor:(UIColor *)boxColor
{
    if (_boxColor != boxColor) {
        _boxColor = boxColor;
        
        _knobView.backgroundColor = _boxColor;
    }
}

- (void)setBoxBgColor:(UIColor *)boxBgColor
{
    if (_boxBgColor != boxBgColor) {
        _boxBgColor = boxBgColor;
        
        _offKnobView.backgroundColor = _boxBgColor;
    }
}


//////
- (CGRect)roundRect:(CGRect)frameOrBounds
{
    CGRect newRect = frameOrBounds;
    
    if (newRect.size.height > RadioBoxMaxWidth) {
        newRect.size.height = RadioBoxMaxWidth;
    }
    
    if (newRect.size.height < RadioBoxMinWidth) {
        newRect.size.height = RadioBoxMinWidth;
    }
    
    if (newRect.size.width < RadioBoxMinWidth) {
        newRect.size.width = RadioBoxMinWidth;
    }
    
    return newRect;
}


///初始化
- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    _onTintColor = [UIColor colorWithRed:255 / 255.0 green:127 / 255.0 blue:0 / 255.0 alpha:1.0];
    _tintColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    _boxColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    _boxBgColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    _onBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds))];
    _onBoxView.backgroundColor = _onTintColor;
    _onBoxView.layer.cornerRadius = CGRectGetHeight(self.containerView.bounds) / 2.0;
    [_containerView addSubview:_onBoxView];
    
    _offBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds))];
    _offBoxView.backgroundColor = _tintColor;
    _offBoxView.layer.cornerRadius = CGRectGetHeight(self.containerView.bounds) / 2.0;
    [_containerView addSubview:_offBoxView];
    
    
    CGFloat _boxWidth = CGRectGetHeight(self.containerView.bounds)-8;
    CGFloat margin = (CGRectGetHeight(self.bounds) - _boxWidth) / 2.0;
    
    _offKnobView = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, _boxWidth, _boxWidth)];
    _offKnobView.backgroundColor = _boxBgColor;
    _offKnobView.layer.cornerRadius = _boxWidth / 2.0;
    [_containerView addSubview:_offKnobView];
    
    
    _knobView = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, _boxWidth, _boxWidth)];
    _knobView.backgroundColor = _boxColor;
    _knobView.layer.cornerRadius = _boxWidth / 2.0;
    [_containerView addSubview:_knobView];
    
    
    CGFloat _labelMarginLeft = CGRectGetHeight(self.containerView.bounds) + 10;
    CGFloat _labelWidth = CGRectGetWidth(self.containerView.bounds) - _labelMarginLeft;
    
    _lbText = [[UILabel alloc] initWithFrame:CGRectMake(_labelMarginLeft, 0, _labelWidth, CGRectGetHeight(self.containerView.bounds))];
    _lbText.backgroundColor = [UIColor clearColor];
    _lbText.textAlignment = NSTextAlignmentLeft;
    _lbText.textColor = _textColor;
    _lbText.font = _textFont;
    _lbText.text = _text;
    [_containerView addSubview:_lbText];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTapTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
}

///初始化时布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    self.containerView.layer.masksToBounds = YES;
    
    CGFloat _boxWidth = CGRectGetHeight(self.containerView.bounds) - 8;
    CGFloat margin = (CGRectGetHeight(self.bounds) - _boxWidth) / 2.0;
    
    if (self.isOn) {
        // frame of on status
        
        self.knobView.frame = CGRectMake(margin, margin, _boxWidth, _boxWidth);
        
        self.onBoxView.frame = CGRectMake(0, 0,
                                          CGRectGetHeight(self.containerView.bounds),
                                          CGRectGetHeight(self.containerView.bounds));
        
        self.offBoxView.frame = CGRectMake(0, 0, 0, 0);
        
    } else {
        // frame of off status
        self.onBoxView.frame = CGRectMake(0, 0, 0, 0);
        
        self.offBoxView.frame = CGRectMake(0, 0,
                                           CGRectGetHeight(self.containerView.bounds),
                                           CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(CGRectGetHeight(self.containerView.bounds) / 2,
                                         CGRectGetHeight(self.containerView.bounds) / 2, 0, 0);
    }

}


///识别器
- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer
{
    //增加条件：self.on == NO 当他是关闭状态时才支持修改颜色
    if ((recognizer.state == UIGestureRecognizerStateEnded)&&self.on == NO) {
        [self setOn:!self.isOn];
        self.isClick = YES;
    }
}

- (void)setOn:(BOOL)on
{
    if (_on == on) {
        return;
    }
    _on = on;
    
    CGFloat _boxWidth = CGRectGetHeight(self.containerView.bounds) - 8;
    CGFloat margin = (CGRectGetHeight(self.bounds) - _boxWidth) / 2.0;
    
    if (self.isOn) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.knobView.frame = CGRectMake(margin, margin, _boxWidth, _boxWidth);
                         }
                         completion:^(BOOL finished){
                             self.onBoxView.frame = CGRectMake(0, 0,
                                                                   CGRectGetHeight(self.containerView.bounds),
                                                                   CGRectGetHeight(self.containerView.bounds));
                             
                             self.offBoxView.frame = CGRectMake(0, 0, 0, 0);
                         }];
    } else {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.knobView.frame = CGRectMake(CGRectGetHeight(self.containerView.bounds) / 2,
                                                              CGRectGetHeight(self.containerView.bounds) / 2, 0, 0);
                         }
                         completion:^(BOOL finished){
                             self.onBoxView.frame = CGRectMake(0, 0, 0, 0);
                             
                             self.offBoxView.frame = CGRectMake(0, 0,
                                                                    CGRectGetHeight(self.containerView.bounds),
                                                                    CGRectGetHeight(self.containerView.bounds));
                         }];
    }
    //NSLog(@"label:%f,view:%f",self.lbText.frame.size.height,CGRectGetHeight(self.containerView.bounds));
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
