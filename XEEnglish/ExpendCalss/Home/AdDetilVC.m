//
//  AdDetilVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AdDetilVC.h"

@interface AdDetilVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation AdDetilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSURL *webURL = [NSURL URLWithString:self.webString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:webURL];
    
    [self.webView loadRequest:request];
    
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = 108;
    [self.view addSubview:view];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.activityIndicatorView.center = self.view.center;
    
    [self.activityIndicatorView startAnimating];
    
    [view addSubview:self.activityIndicatorView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    UIView *view = (UIView *)[self.view viewWithTag:108];
    view.hidden = YES;
    
    [self.activityIndicatorView stopAnimating];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    UIView *view = (UIView *)[self.view viewWithTag:108];
    view.hidden = YES;
    
    [self.activityIndicatorView stopAnimating];
    
}
@end
