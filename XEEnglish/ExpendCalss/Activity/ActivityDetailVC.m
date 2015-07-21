//
//  ActivityDetailVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityDetailVC.h"
#import "XeeService.h"

@interface ActivityDetailVC ()<UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIWebView *activityWebView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动详情";
}

- (void)initUI{
    
    [super initUI];
    
    [self headView];
    [self footView];
    //NSLog(@"info:%@",self.avtivitInfoDic);
    self.activityWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64+140+1, kScreenWidth, kScreenHeight-205-60)];
    self.activityWebView.delegate = self;
    //self.activityWebView.scalesPageToFit = YES;
    
    NSString *webString = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.avtivitInfoDic[@"html_url"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webString]];
    
    [self.activityWebView loadRequest:request];
    
    [self.view addSubview:self.activityWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 140)];
    headView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20,50)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.avtivitInfoDic[@"title"];
    //自动折行设置
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [headView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth-20,30)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.text = [NSString stringWithFormat:@"活动时间：%@至%@",self.avtivitInfoDic[@"start_time"],self.avtivitInfoDic[@"end_time"]];
    //自动折行设置
    timeLabel.numberOfLines = 0;
    timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [headView addSubview:timeLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, kScreenWidth-20,50)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor blueColor];
    contentLabel.text = [NSString stringWithFormat:@"活动内容：%@",self.avtivitInfoDic[@"content"]];
    //自动折行设置
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 0;
    
    [headView addSubview:contentLabel];
    
    UILabel *schoolZoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kScreenWidth-20,20)];
    schoolZoneLabel.font = [UIFont systemFontOfSize:12];
    schoolZoneLabel.textAlignment = NSTextAlignmentLeft;
    schoolZoneLabel.textColor = [UIColor blackColor];
    schoolZoneLabel.text = [NSString stringWithFormat:@"活动地址：%@",self.avtivitInfoDic[@"address"]];
    
    [headView addSubview:schoolZoneLabel];
    
    
}

- (void)footView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    //NSLog(@"dic:%@",self.avtivitInfoDic);
    UILabel *personNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100,20)];
    personNumLabel.font = [UIFont systemFontOfSize:12];
    personNumLabel.textAlignment = NSTextAlignmentLeft;
    personNumLabel.textColor = [UIColor blackColor];
    personNumLabel.text = [NSString stringWithFormat:@"人数  %@/%@",self.avtivitInfoDic[@"sum_current"],self.avtivitInfoDic[@"sum_max"]];
    
    [footView addSubview:personNumLabel];
    
    
    UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reserveBtn setFrame:CGRectMake(kScreenWidth/2+20, 10, kScreenWidth/2-40, 40)];
    [reserveBtn setTitle:@"我要预约" forState:UIControlStateNormal];
    [reserveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    reserveBtn.layer.cornerRadius = 4.0f;
    [reserveBtn addTarget:self action:@selector(reserveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //判断，人数满了之后将按钮置灰
    NSString *current_sum = [NSString stringWithFormat:@"%@",self.avtivitInfoDic[@"sum_current"]];
    NSString *max_sum = [NSString stringWithFormat:@"%@",self.avtivitInfoDic[@"sum_max"]];
    if ([current_sum isEqualToString:max_sum]) {
        [reserveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [reserveBtn setBackgroundColor:[UIColor grayColor]];
        reserveBtn.enabled = NO;
    }
    else{
        [reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reserveBtn setBackgroundColor:[UIColor orangeColor]];
        reserveBtn.enabled = YES;
    }
    
    [footView addSubview:reserveBtn];
    
}

- (void)reserveBtnClicked{
    //self.activitId = sender;
    if([[UserInfo sharedUser] isLogin]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您是否预约该活动" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        [UIFactory showAlert:@"请先登录"];
    }
    
}



#pragma mark - Web

- (void)makeActivityAndActivityId:(NSString *)activityId{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] makeActivityWithParentId:userInfoDic[uUserId] andActivityId:activityId andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                [UIFactory showAlert:result[@"resultInfo"]];
                //发送通知，刷新我的页面
                [[NSNotificationCenter defaultCenter] postNotificationName:SettingRefresh object:self];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    if (buttonIndex == 1) {
        [self makeActivityAndActivityId:self.avtivitInfoDic[@"activity_id"]];
        
    }
}


- (void)alertViewCancel:(UIAlertView *)alertView{
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
