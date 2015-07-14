//
//  ActivityHistoryDetailVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityHistoryDetailVC.h"

@interface ActivityHistoryDetailVC ()<UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIWebView *activityWebView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ActivityHistoryDetailVC

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
    
    [self headView];
    [self footView];
    //NSLog(@"info:%@",self.avtivitInfoDic);
    self.activityWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64+140+1, kScreenWidth, kScreenHeight-205-40)];
    self.activityWebView.delegate = self;
    //self.activityWebView.scalesPageToFit = YES;
    
    NSString *webString = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.avtivityHistoryInfoDic[@"html_url"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webString]];
    
    [self.activityWebView loadRequest:request];
    
    [self.view addSubview:self.activityWebView];
}


- (void)headView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 140)];
    headView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20,50)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.avtivityHistoryInfoDic[@"title"];
    //自动折行设置
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [headView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth-20,30)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.text = [NSString stringWithFormat:@"活动时间：%@至%@",self.avtivityHistoryInfoDic[@"start_time"],self.avtivityHistoryInfoDic[@"end_time"]];
    //自动折行设置
    timeLabel.numberOfLines = 0;
    timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [headView addSubview:timeLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, kScreenWidth-20,50)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor blueColor];
    contentLabel.text = [NSString stringWithFormat:@"活动内容：%@",self.avtivityHistoryInfoDic[@"content"]];
    //自动折行设置
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 0;
    
    [headView addSubview:contentLabel];
    
    UILabel *schoolZoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kScreenWidth-20,20)];
    schoolZoneLabel.font = [UIFont systemFontOfSize:12];
    schoolZoneLabel.textAlignment = NSTextAlignmentLeft;
    schoolZoneLabel.textColor = [UIColor blackColor];
    schoolZoneLabel.text = [NSString stringWithFormat:@"活动地址：%@",self.avtivityHistoryInfoDic[@"address"]];
    
    [headView addSubview:schoolZoneLabel];
    
    
}

- (void)footView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    //NSLog(@"dic:%@",self.avtivityHistoryInfoDic);
    UILabel *personNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 10, 90,20)];
    personNumLabel.font = [UIFont systemFontOfSize:12];
    personNumLabel.textAlignment = NSTextAlignmentRight;
    personNumLabel.textColor = [UIColor blackColor];
    personNumLabel.text = [NSString stringWithFormat:@"人数  %@/%@",self.avtivityHistoryInfoDic[@"sum_current"],self.avtivityHistoryInfoDic[@"sum_max"]];
    
    [footView addSubview:personNumLabel];
    
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
    
    //改变字体大小
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName_r('body')[0].style.webkitTextSizeAdjust= '200%'"];
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

@end
