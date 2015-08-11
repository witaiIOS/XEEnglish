//
//  SchoolAdCell.h
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolAdCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *adArray;
@property (nonatomic) NSInteger timeCount;

- (void)layoutThatImages:(NSArray *)imageArray;

@end
