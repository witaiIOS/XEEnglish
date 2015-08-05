//
//  PayCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PayCourseVC.h"
#import "PaymoneyCell.h"
#import "PayMethodCell.h"

#import "payCompleteVC.h"

#import "XeeService.h"

@interface PayCourseVC ()<UITableViewDataSource,UITableViewDelegate>



//@property (nonatomic, strong) NSString *out_trade_no;
@end

@implementation PayCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"爱迪天才";
}

- (void)initUI{
    
    [super initUI];
    
    NSString *niceName = [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.name = niceName;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [self footView];
    [self.view addSubview:self.tableView];
    
    //默认选中支付宝支付
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    //self.out_trade_no = [self generateTradeNO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //NSLog(@"dateStr:%@",dateStr);
    [resultStr appendString:dateStr];
    
    static int kNumber = 5;
    //对名字进行编码
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    srand((int)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    //NSLog(@"str:%@",resultStr);
    return resultStr;
}


#pragma mark - IBAction
- (void)nextBtnClicked:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSString *out_trade_no = [self generateTradeNO];
    //NSLog(@"out_trade_no:%@",out_trade_no);
    
    __block PayCourseVC *controller = self;
//    //支付成功后传订单号给APPDelegate.m，如果返回成功，则调用接口UpdateOrderStatueWx修改后台的微信支付状态
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:out_trade_no forKey:@"out_trade_no"];
//    [[NSNotificationCenter defaultCenter]postNotificationName:GetOutTradeNo object:self userInfo:dic];
    
    [self addStudentSubCourseWithOutTradeNo:out_trade_no andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *isResult = result[@"result"];
            NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                //payCompleteVC *vc = [[payCompleteVC alloc] init];
                //[self.navigationController pushViewController:vc animated:YES];
    
                if (indexPath.row == 2) {//微信支付
                    
                    [controller wxPayWithOutTradeNo:out_trade_no];
                    
                    
                }
                else if (indexPath.row == 1) {//现金支付
                    [UIFactory showAlert:@"订单已提交"];
                }
                else {//支付宝支付
                    [controller aliyPayWithOutTradeNo:out_trade_no];
                }
                [controller.navigationController popViewControllerAnimated:YES];

            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
        
    }];

    
   }

#pragma mark - 支付
- (void)getMak {
    
}

- (void)addStudentSubCourseWithOutTradeNo:(NSString *)out_trade_no andBlock:(void(^)(NSDictionary *result, NSError *error))block {
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"add:%@",self.out_trade_no);
    [[XeeService sharedInstance] addStudentSubCourseWithDepartmentId:self.schoolId andStudentId:self.studentId andType:[NSString stringWithFormat:@"%li",(long)self.payMethod] andOrderPrice:self.payMoney andPlatFormTypeId:@"202" andListCoupon:self.listCoupon andToken:userInfoDic[uUserToken] andPayType:self.payType andNumbers:self.number andCourseId:self.courseId andParentId:userInfoDic[uUserId] andIsSelectStudent:self.is_select_student andSex:self.sex andBirthday:self.birthday andName:self.name andOutTradeNo:out_trade_no andBlock:block];

}


- (void)aliyPayWithOutTradeNo:(NSString *)out_trade_no {//支付宝支付
    //NSLog(@"aliypay:%@",self.out_trade_no);
    [[XeeService sharedInstance] apliyPayWithOutTradeNo:out_trade_no andTotalFee:@"0.01" andType:self.courseName callback:^(NSDictionary *resultDic) {
        
        NSString *resultStatus = resultDic [@"resultStatus"];
        if (9000 == [resultStatus intValue]) {//支付成功
            
            payCompleteVC *vc = [[payCompleteVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            //支付成功后刷新订单页
            [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshOrderVC" object:self];
        }
        else {
            //[UIFactory showAlert:@"支付遇到问题，请重新支付"];
        }
    }];
}

- (void)cashPay {//现金支付
    
}

- (void)wxPayWithOutTradeNo:(NSString *)out_trade_no {//微信支付
    
    NSLog(@"self.courseName:%@",self.courseName);
    if (!self.courseName) {
        [UIFactory showAlert:@"课程名不能为空"];
    }
    [[XeeService sharedInstance] wxSendPayWithBody:self.courseName andOrderNo:out_trade_no andOrderPrice:@"0.01"];
}

#pragma mark - tableView footView

- (UIView *)footView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-60-176)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20, 100, kScreenWidth-40, 40)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor orangeColor]];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:nextBtn];
    
    return view;
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 3;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"PaymoneyCell";
    static NSString *reuse2 = @"PayMethodCell";
    static NSString *reuse3 = @"BaseCell";
    
    if (indexPath.section == 0) {
        PaymoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[PaymoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            cell.myLabel.text = @"支付金额";
            cell.myMoneyLabel.text = [NSString stringWithFormat:@"%li",(long)self.payMoney];
            cell.cellEdge = 10;
        }
        
        return cell;
    }
    else if (indexPath.section == 1){
        PayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        if (cell == nil) {
            cell = [[PayMethodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.myPayMethodImageView.image = [UIImage imageNamed:@"pay_01.png"];
                cell.myPayMethodLabel.text = @"支付宝支付";
                break;
            }
            case 1:
            {
                cell.myPayMethodImageView.image = [UIImage imageNamed:@"pay_02.png"];
                cell.myPayMethodLabel.text = @"现金支付";
                break;
            }
            case 2:
            {
                cell.myPayMethodImageView.image = [UIImage imageNamed:@"pay_03.png"];
                cell.myPayMethodLabel.text = @"微信支付";
                break;
            }
                
            default:
                break;
        }
        return cell;
    }
    else{
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            cell.cellEdge = 10;
        }
        
        return cell;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor blackColor];
    
    [view addSubview:tipLabel];
    if (section == 0) {
        tipLabel.text = @"信息确认：";
    }
    else{
        tipLabel.text = @"选择支付方式";
    }
    
    return view;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    if (section == 1) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-60-176)];
//        view.backgroundColor = [UIColor clearColor];
//        
//        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [nextBtn setFrame:CGRectMake(20, kScreenHeight-64-60-176-60, kScreenWidth-40, 40)];
//        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [nextBtn setBackgroundColor:[UIColor orangeColor]];
//        [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        
//        [view addSubview:nextBtn];
//        
//        return view;
//    }
//    else{
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
//        view.backgroundColor = [UIColor clearColor];
//        
//        return view;
//    }
//}

@end
