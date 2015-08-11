//
//  HomeAdCell.h
//  ZLTZ
//
//  Created by MacAir2 on 13-10-9.
//  Copyright (c) 2013年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeAdCellDelegate <NSObject>

- (void)HomeAdCellImageViewPressed:(NSInteger )sender andAdInfo:(NSDictionary *)adDic;

@end

@interface HomeAdCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *adArray;
@property (nonatomic) NSInteger timeCount;

@property (nonatomic, assign) id<HomeAdCellDelegate>delegate;

- (void)layoutThatImages:(NSArray *)imageArray;


@end
