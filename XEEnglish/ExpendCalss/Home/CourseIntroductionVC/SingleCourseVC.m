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

#import "SingleCourseCommentVC.h"

#import "XeeService.h"
#import "MBProgressHUD.h"

@interface SingleCourseVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UILabel *ageLabel;//适用年龄段
@property (nonatomic, strong) UILabel *buyMethedLabel;//购买方式
@property (nonatomic, strong) UILabel *priceLabel;//购买的价格
@property (nonatomic, strong) UILabel *priceTipLabel;//显示“单价”或者“总价”

@property (nonatomic, assign) NSInteger payMethodNum;//付款方式传给购买页

@property (nonatomic, strong) NSDictionary *courseInfo;

@property (nonatomic, strong) UIWebView *courseWeb;
//@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webString;

@property (nonatomic, strong) UIButton *listenBtn;
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
    //右上角加上评价接口
    [self addCommentBtn];
    
    //加入页面的头，显示适用年龄段，购买方式，价格
    [self headView];
    
    self.courseWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64+65, kScreenWidth, kScreenHeight-64-65-60)];
    self.courseWeb.delegate = self;
    //self.courseWeb.scalesPageToFit = YES;
    
    [self.view addSubview:self.courseWeb];
    
    
    //显示页面尾，显示试听和购买按钮
    [self footView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加一个评价的右上角按钮
- (void)addCommentBtn{
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setFrame:CGRectMake(kScreenWidth-50, 6, 40, 30)];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *commentBarBtn = [[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    self.navigationItem.rightBarButtonItem = commentBarBtn;
}
//该课程的评论
- (void)commentBtnClicked{
    SingleCourseCommentVC *vc = [[SingleCourseCommentVC alloc] init];
    vc.courseInfoDic = self.courseInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

//加入页面的头，显示适用年龄段，购买方式，价格
- (void)headView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 65)];
    headView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:headView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 15)];
    label1.text = @"适用年龄段：";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:label1];
    
    self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 100, 15)];
    //self.ageLabel.textAlignment = NSTextAlignmentLeft;
    self.ageLabel.textColor = [UIColor blackColor];
    self.ageLabel.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:self.ageLabel];
    
    UILabel *buyMethedTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 60, 15)];
    buyMethedTip.text = @"购买方式：";
    buyMethedTip.textColor = [UIColor blackColor];
    buyMethedTip.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:buyMethedTip];
    
    self.buyMethedLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 200, 15)];
    //self.buyMethedLabel.textAlignment = NSTextAlignmentLeft;
    self.buyMethedLabel.textColor = [UIColor blackColor];
    self.buyMethedLabel.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:self.buyMethedLabel];
    
    self.priceTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 40, 15)];
    //self.priceTipLabel.text = @"价格：";
    self.priceTipLabel.textColor = [UIColor blackColor];
    self.priceTipLabel.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:self.priceTipLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, 200, 15)];
    //self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:self.priceLabel];
    
}

//显示页面尾，显示试听和购买按钮
- (void)footView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    self.listenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.listenBtn setFrame:CGRectMake(20, 10, kScreenWidth/2-40, 40)];
    [self.listenBtn setTitle:@"试听" forState:UIControlStateNormal];
    [self.listenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.listenBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.listenBtn setBackgroundColor:[UIColor greenColor]];
    self.listenBtn.layer.cornerRadius = 4.0f;
    [self.listenBtn addTarget:self action:@selector(listenBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:self.listenBtn];
    
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


#pragma mark - My Action

- (void)listenBtnClicked{
    ListeningCourseVC *vc = [[ListeningCourseVC alloc] init];
    vc.courseName = self.title;
    vc.parentCourseId = self.courseId;
    vc.parentCourseInfo = self.courseInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buyBtnClicked{
    
    BuyCourseVC *vc = [[BuyCourseVC alloc] init];
    vc.courseName = self.title;
    vc.parentCourseId = self.courseId;
    vc.payMethodNumber = self.payMethodNum;
    vc.superPayMethodNumber = self.payMethodNum;
    vc.courseInfoDic = self.courseInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getCourseDetailByCourseId{
    
    [[XeeService sharedInstance] getCourseDetailByCourseId:self.courseId andBlock:^(NSDictionary *result, NSError *error) {
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.courseInfo = result[@"resultInfo"];
//                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//                NSString *minAge = [numberFormatter stringFromNumber:courseInfo[@"min_age"]];
//                NSString *maxAge = [numberFormatter stringFromNumber:courseInfo[@"max_age"]];;
                //获取页面上方适用年龄和价格的各个显示值
                [self setSingleCourseValue:self.courseInfo];
                //判断是否支持试听功能，不能就置灰，不能用
                [self setListenBtnEnabled:self.courseInfo];
                
                NSNumber *payMethod = self.courseInfo[@"pay_type"];
                self.payMethodNum = payMethod.integerValue;
            }
        }
    }];
}
//根据courseInfo[@"is_pay_listen"]字段，判断是否能试听
//is_pay_listen 取值 0不能试听 1免费试听 2有偿服务 3免费&有偿。
- (void)setListenBtnEnabled:(NSDictionary *)courseInfo{
    
    NSNumber *isPayListen = courseInfo[@"is_pay_listen"];
    if (isPayListen.integerValue == 0) {
        [self.listenBtn setBackgroundColor:[UIColor grayColor]];
        self.listenBtn.enabled = NO;
    }
    else{
        
    }
}



- (void)setSingleCourseValue:(NSDictionary *)courseInfo{
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@ ~ %@",courseInfo[@"min_age"],courseInfo[@"max_age"]];
    self.webString = [NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,courseInfo[@"website"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.webString]];
    //NSLog(@"webString:%@",self.webString);
    
    [self.courseWeb loadRequest:request];

    //NSLog(@"%@",self.webString);
//    if ([courseInfo[@"total_price"] isKindOfClass:[NSNull class]]) {
//        self.priceLabel.text = [NSString stringWithFormat:@"%@元/课",courseInfo[@"price"]];
//    }
//    else{
//        self.priceLabel.text = [NSString stringWithFormat:@"%@元   %@元／课",courseInfo[@"total_price"],courseInfo[@"price"]];
//    }
    
    //根据pay_type判断购买方式pay_type取值 1按课时价 2按整套价 3两者都可。
    
    NSNumber *buyMethed = courseInfo[@"pay_type"];
    
    if (buyMethed.integerValue == 1) {
        
        self.buyMethedLabel.text = @"按课时购买";
        self.priceTipLabel.text = @"单价：";
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/课",courseInfo[@"price"]];
    }
    else if(buyMethed.integerValue == 2){
        
        self.buyMethedLabel.text = @"按整套购买";
        self.priceTipLabel.text = @"总价：";
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/套",courseInfo[@"total_price"]];
    }
    else if(buyMethed.integerValue == 3){
        
        self.buyMethedLabel.text = @"按课时，按整套购买均可";
        self.priceTipLabel.text = @"价格：";
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/套   %@元/课",courseInfo[@"total_price"],courseInfo[@"price"]];
    }
    
}

//- (void)setPayMethodNum:(NSDictionary *)courseInfo{
//    
//    NSNumber *payMethodNum = courseInfo[@"pay_type"];
//    
//}


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
    
    //改变字体大小颜色就:
//    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f",20.0f];
//    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
    //改变字体大小
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.courseWeb stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName_r('body')[0].style.webkitTextSizeAdjust= '200%'"];
    
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
