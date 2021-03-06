//
//  UserProtocolVC.m
//  XEEnglish
//
//  Created by houjing on 15/5/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserProtocolVC.h"

@interface UserProtocolVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *myWebView;

@end

@implementation UserProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户协议";
    
}

- (void)initUI
{
    [super initUI];
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.myWebView.delegate = self;
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://www.hao123.com"]];
//    [self.myWebView loadRequest:request];
//    [self.view addSubview:self.myWebView];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"agreement" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.myWebView loadRequest:request];
    [self.view addSubview:self.myWebView];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
