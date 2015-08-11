//
//  SchoolAdCell.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchoolAdCell.h"
#import "UIImageView+AFNetworking.h"
#import "AppCore.h"

@implementation SchoolAdCell

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
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
//        [_imageScrollView addGestureRecognizer:tapGesture];
        
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
    //NSLog(@"ad111:%@",self.adArray);
    [self layoutThatImages:_adArray];
}

//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutThatImages:(NSArray *)imageArray
{
    _pageControl.numberOfPages = imageArray.count;
    _pageControl.currentPage = 0;
    
    _imageScrollView.contentSize = CGSizeMake(imageArray.count*320, 160);
    
    CGFloat x=0;
    for (int i = 0 ; i < imageArray.count; i++,x+=320) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 320, 160)];
        NSDictionary *infoDic = [imageArray objectAtIndex:i];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[infoDic objectForKey:@"pic_url"]];
        //NSLog(@"imageurl:%@",imageUrl);
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        
        [_imageScrollView addSubview:imageView];
    }
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
