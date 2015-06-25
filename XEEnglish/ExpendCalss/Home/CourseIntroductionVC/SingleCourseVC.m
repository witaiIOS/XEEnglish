//
//  SingleCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SingleCourseVC.h"

//#import "ListenCourseVC.h"
#import "ListeningCourseVC.h"
#import "BuyCourseVC.h"


#import "XeeService.h"
#import "MBProgressHUD.h"

@interface SingleCourseVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIWebView *courseWeb;
//@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webString;
@end

@implementation SingleCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"课程介绍";
}



- (void)initUI{
    
    [super initUI];
    
    [self getCourseDetailByCourseId];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 60)];
    headView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:headView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    label1.text = @"适用年龄段：";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:label1];
    
    self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 100, 20)];
    //self.ageLabel.textAlignment = NSTextAlignmentLeft;
    self.ageLabel.textColor = [UIColor blackColor];
    self.ageLabel.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:self.ageLabel];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 80, 20)];
    label3.text = @"价格：";
    label3.textColor = [UIColor blackColor];
    label3.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:label3];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, 200, 20)];
    //self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:self.priceLabel];
    
    self.courseWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64+60, kScreenWidth, kScreenHeight-64-60-60)];
    self.courseWeb.delegate = self;
    self.courseWeb.scalesPageToFit = YES;
    
    [self.view addSubview:self.courseWeb];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    UIButton *listenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [listenBtn setFrame:CGRectMake(20, 10, kScreenWidth/2-40, 40)];
    [listenBtn setTitle:@"试听" forState:UIControlStateNormal];
    [listenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [listenBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [listenBtn setBackgroundColor:[UIColor greenColor]];
    listenBtn.layer.cornerRadius = 4.0f;
    [listenBtn addTarget:self action:@selector(listenBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:listenBtn];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(kScreenWidth/2+20, 10, kScreenWidth/2-40, 40)];
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [buyBtn setBackgroundColor:[UIColor orangeColor]];
    buyBtn.layer.cornerRadius = 4.0f;
    [buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:buyBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - My Action

- (void)listenBtnClicked{
    ListeningCourseVC *vc = [[ListeningCourseVC alloc] init];
    vc.courseName = self.title;
    vc.parentCourseId = self.courseId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buyBtnClicked{
    
    BuyCourseVC *vc = [[BuyCourseVC alloc] init];
    vc.courseName = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getCourseDetailByCourseId{
    
    [[XeeService sharedInstance] getCourseDetailByCourseId:self.courseId andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *courseInfo = result[@"resultInfo"];
//                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//                NSString *minAge = [numberFormatter stringFromNumber:courseInfo[@"min_age"]];
//                NSString *maxAge = [numberFormatter stringFromNumber:courseInfo[@"max_age"]];;
                [self setSingleCourseValue:courseInfo];
            }
        }
    }];
}

- (void)setSingleCourseValue:(NSDictionary *)courseInfo{
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@ ~ %@",courseInfo[@"min_age"],courseInfo[@"max_age"]];
    self.webString = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,courseInfo[@"website"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.webString]];
    NSLog(@"webString:%@",self.webString);
    
    [self.courseWeb loadRequest:request];

    //NSLog(@"%@",self.webString);
    if ([courseInfo[@"total_price"] isKindOfClass:[NSNull class]]) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/课",courseInfo[@"price"]];
    }
    else{
        self.priceLabel.text = [NSString stringWithFormat:@"%@元   %@元／课",courseInfo[@"total_price"],courseInfo[@"price"]];
    }
    
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
