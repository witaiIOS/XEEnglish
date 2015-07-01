//
//  CourseCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseCommentVC.h"

@interface CourseCommentVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *courseWeb;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webString;

@end

@implementation CourseCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程回顾";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];

    self.courseWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    self.courseWeb.delegate = self;
    self.courseWeb.scalesPageToFit = YES;
    
    [self.view addSubview:self.courseWeb];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setFrame:CGRectMake(kScreenWidth/2+20, 10, kScreenWidth/2-40, 40)];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [commentBtn setBackgroundColor:[UIColor orangeColor]];
    commentBtn.layer.cornerRadius = 4.0f;
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:commentBtn];
    
}

#pragma mark - My Action



- (void)commentBtnClicked{
    
//    BuyCourseVC *vc = [[BuyCourseVC alloc] init];
//    vc.courseName = self.title;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.tag = 108;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.activityIndicator.center = self.view.center;
    
    [view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:108];
    [view removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
