//
//  PhotoLookVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PhotoLookVC.h"

@interface PhotoLookVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PhotoLookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片浏览";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*self.photoArray.count, kScreenHeight-64);
    //定位到指定位置
    //self.scrollView.contentOffset = CGPointMake(self.currentIndex*kScreenWidth,0);
    [self.scrollView setContentOffset:CGPointMake(self.currentIndex*kScreenWidth,0) animated:YES];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i= 0; i<self.photoArray.count; i++) {
        //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, (kScreenHeight-64-300)/2, kScreenWidth, 300)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight-64)];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[self.photoArray[i] objectForKey:@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
}

@end
