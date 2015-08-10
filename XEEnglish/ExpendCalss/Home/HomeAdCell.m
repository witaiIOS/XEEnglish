//
//  HomeAdCell.m
//  ZLTZ
//
//  Created by MacAir2 on 13-10-9.
//  Copyright (c) 2013年 lixiang. All rights reserved.
//

#import "HomeAdCell.h"
#import "UIImageView+AFNetworking.h"
#import "AppCore.h"

@implementation HomeAdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.contentView.multipleTouchEnabled = YES;
        
        _timeCount = 0;
        
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.delegate = self;
        [self.contentView addSubview:_imageScrollView];
        
        //
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 150, 80, 5)];
//        _pageControl.numberOfPages = _adArray.count;
//        _pageControl.currentPage = 0;
        //_pageControl.pageIndicatorTintColor = [UIColor grayColor];
        //_pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_pageControl];
        
        
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutThatImages:_adArray];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)layoutThatImages:(NSArray *)imageArray
//{
//    _pageControl.numberOfPages = imageArray.count;
//    _pageControl.currentPage = 0;
//    
//    _imageScrollView.contentSize = CGSizeMake(imageArray.count*320, 160);
//    
//    CGFloat x=0;
//    for (int i = 0 ; i < imageArray.count; i++,x+=320) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 320, 160)];
//        NSDictionary *infoDic = [imageArray objectAtIndex:i];
//        
//          NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MZBimageURLPrefix,[infoDic objectForKey:@"imageUrl"]];
//        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
//        
//        [_imageScrollView addSubview:imageView];
//    }
//}
- (void)layoutThatImages:(NSArray *)imageArray
{
    _pageControl.numberOfPages = imageArray.count;
    _pageControl.currentPage = 0;
    
    _imageScrollView.contentSize = CGSizeMake(imageArray.count*320, 160);
    
    CGFloat x=0;
//    for (int i = 0 ; i < imageArray.count; i++,x+=320) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 320, 160)];
//        NSDictionary *infoDic = [imageArray objectAtIndex:i];
//        
//        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[infoDic objectForKey:@"image_url"]];
//        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
//        
//        [_imageScrollView addSubview:imageView];
//    }
    for (int i = 0 ; i < imageArray.count; i++,x+=320) {
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageBtn setFrame:CGRectMake(x, 0, 320, 160)];
        NSDictionary *infoDic = [imageArray objectAtIndex:i];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[infoDic objectForKey:@"image_url"]];
        //NSLog(@"imageURL:%@",imageUrl);
        //[imageBtn.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        [imageBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        imageBtn.tag = i;
        [imageBtn addTarget:self action:@selector(imageBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [_imageScrollView addSubview:imageBtn];
    }
}

- (void)imageBtnPressed:(id)sender{
    UIButton *imageButton = (UIButton *)sender;
    
    NSDictionary *infoDic = [_adArray objectAtIndex:imageButton.tag];
    
    [self.delegate HomeAdCellButtonPressed:sender andAdInfo:infoDic];
    
}

#pragma mark - Private

- (void)pageTurn:(UIPageControl *)aPageControl
{
    NSInteger whichPage = aPageControl.currentPage;
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.5f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [_imageScrollView setContentOffset:CGPointMake(320.0f * whichPage, 0.0f) animated:YES];
    
    [UIView commitAnimations];
}

//定时滚动

-(void)scrollTimer{
    
    _timeCount++;
    
    if(_timeCount == _adArray.count) {
        _timeCount = 0;
    }
    
    [_imageScrollView scrollRectToVisible:CGRectMake(_timeCount * 320.0, 0, 320.0, 160.0) animated:YES];
    
}

#pragma mark - ScorllView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _pageControl.currentPage = scrollView.contentOffset.x/320;
}


@end
