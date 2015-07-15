//
//  BuyCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BuyCourseVC.h"
#import "BaseTVC.h"
#import "ListeningCourseInfoCell.h"
#import "BuyCoursePaymentAmountCell.h"

#import "SubCourseListVC.h"
#import "courseSchoolZoneVC.h"
#import "SelectedStudentVC.h"
#import "PayCourseMethodVCViewController.h"

#import "CouponsVC.h"

#import "PayCourseVC.h"
#import "PayProtocolVC.h"

#import "XeeService.h"

@interface BuyCourseVC ()<UITableViewDataSource,UITableViewDelegate,changeSelectedBtnDelegate,SelectedCourseDelegate,SelectedPayCourseMethodDelegate,ListeningCourseInfoCellDelegate,CourseSchoolZoneDelegate,SelectedStudentVCselectedStudentDelegate,CouponsVCCouponsUsedDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *selectedBtn;//是否同意了协议

@property (nonatomic, assign) NSInteger buyCourseId;//购买的课程id

@property (nonatomic, strong) NSString *subCoursename;//子课程名
@property (nonatomic, assign) NSInteger subCourseNumeber;//子课程数量，用于做判断，没有子课程就隐藏那个cell
@property (nonatomic, strong) NSDictionary *subCourseInfoDic;//子课程的信息；

@property (nonatomic, strong) NSDictionary *schoolZone;//校区
@property (nonatomic, strong) NSDictionary *selectedStudent;//选择小孩
@property (nonatomic, strong) NSString *payCourseMethod;//付款方式


@property (nonatomic, strong) NSString *inputCourseHours;//按课时购买时，输入的课时数
@property (nonatomic, assign) NSInteger priceTotal;//缴费金额

@property (nonatomic, strong) NSString *listCouponsString;//序列化后的现金券数组
@property (nonatomic, strong) NSMutableArray *listCouponsArray;//现金券数组
@end

@implementation BuyCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程购买";
    
}

- (void)initUI{
    
    [super initUI];
    //显示课程的相关信息，单价，套价
    [self initCourseValue];
    
    self.subCourseInfoDic = [[NSDictionary alloc] init];
    //网络请求查看子课程，如果没有子课程就隐藏课程分类的cell
    [self getCourseListByParentCourseId];
    
    //进入页面时，将父课程的id设置为购买的课程id
    NSNumber *initCourseId = self.courseInfoDic[@"course_id"];
    self.buyCourseId = initCourseId.integerValue;
    
    //初始化经过序列化的现金券数组的NSString
    self.listCouponsString = @"[]";
    
    self.priceTotal = 0;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [self footView];
    [self.view addSubview:self.tableView];
    
    //self.payCourseMethod = @"按全套";//默认情况，按全套购买方式
}

- (void)initCourseValue{
    
    if (self.payMethodNumber == 1) {
        self.priceHour = [NSString stringWithFormat:@"%@",self.courseInfoDic[@"price"]];
        //NSLog(@"self.priceHour:%@",self.priceHour);
    }
    else if (self.payMethodNumber == 2){
        NSNumber *price = self.courseInfoDic[@"total_price"];
        self.priceSeries = price.integerValue;
        //self.priceSeries = [NSString stringWithFormat:@"%@",self.courseInfoDic[@"total_price"]];
        //整套价格不是动态生成的，必须赋值
        self.priceTotal = self.priceSeries;
        //NSLog(@"self.priceSeries:%@",self.priceSeries);
    }
    else if(self.payMethodNumber == 3){
        self.priceHour = [NSString stringWithFormat:@"%@",self.courseInfoDic[@"price"]];
        NSNumber *price = self.courseInfoDic[@"total_price"];
        self.priceSeries = price.integerValue;
        //self.priceSeries = [NSString stringWithFormat:@"%@",self.courseInfoDic[@"total_price"]];
    }
    else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)footView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 200)];
    view.backgroundColor = [UIColor clearColor];
    
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedBtn setFrame:CGRectMake(10, 10, 20, 20)];
    [self.selectedBtn setImage:[UIImage imageNamed:@"chekbox.png"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"chekbox_select.png"] forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(selectedBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:self.selectedBtn];
    
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 70, 20)];
    protocolLabel.text = @"阅读并同意";
    protocolLabel.textColor = [UIColor blackColor];
    protocolLabel.font = [UIFont systemFontOfSize:14];
    
    [view addSubview:protocolLabel];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocolBtn setFrame:CGRectMake(120, 10, 60, 20)];
    [protocolBtn setTitle:@"《协议》" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [protocolBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [protocolBtn addTarget:self action:@selector(protocolBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:protocolBtn];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(20, 40, kScreenWidth-40, 40)];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[UIColor orangeColor]];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:buyBtn];
    
    
    return view;
    
}

- (void)selectedBtnClicked{
    if (self.selectedBtn.selected) {
        self.selectedBtn.selected = NO;
    }
    else{
        self.selectedBtn.selected = YES;
    }
}

- (void)protocolBtnClicked{
    
    PayProtocolVC *vc = [[PayProtocolVC alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)buyBtnClicked{
    if (self.schoolZone[@"department"] == nil) {
        [UIFactory showAlert:@"请选择校区"];
    }
    else if (self.selectedStudent[@"name"] == nil){
        [UIFactory showAlert:@"请选择小孩"];
    }
    else if (!self.selectedBtn.selected) {
        [UIFactory showAlert:@"请阅读并同意协议"];
    }
    else{
        
        //传值
        PayCourseVC *vc = [[PayCourseVC alloc] init];
        vc.payMoney = self.priceTotal;
        vc.studentId = self.selectedStudent[@"student_id"];
        vc.schoolId = self.schoolZone[@"department_id"];
        vc.payMethod = 1;
        vc.payType = [NSString stringWithFormat:@"%li",self.payMethodNumber];
        vc.listCoupon = self.listCouponsString;
        vc.courseId = self.buyCourseId;
        vc.is_select_student = @"";
        vc.sex = @"";
        vc.birthday = @"";
        vc.name = @"";
        if (self.payMethodNumber == 2) {
            vc.number = 1;
        }
        else{
            vc.number = [self.inputCourseHours intValue];
        }
        
        vc.courseName = self.courseName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



#pragma mark -Web
- (void)getCourseListByParentCourseId{
    //应用时将@"1124" 假数据换成 self.parentCourseId
    [[XeeService sharedInstance] getCourseListByParentCourseId:self.parentCourseId andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *subCoursesDic = result[@"resultInfo"];
                NSMutableArray *subCourseArray = subCoursesDic[@"listCourse"];
                //子课程数量，用于做判断，没有子课程就隐藏那个cell
                self.subCourseNumeber = [subCourseArray count];
                //NSLog(@"count:%li",self.subCourseNumeber);
//                //付款方式的判断号，pay_type取值 1按课时价 2按整套价 3两者都可。
//                NSNumber *payMethed = subCoursesDic[@"pay_type"];
//                self.payMethodNumber = payMethed.integerValue;
                
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (self.subCourseNumeber == 0) {
            return 4;
        }
        else{
            return 5;
        }
        
    }
    else if(section == 1){
        if ([self.payCourseMethod isEqualToString:@"按课时"]){
            return 2;
        }
        else{
            return 1;
        }
    }
    else if(section == 2){
        return 1;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"BaseCell";
    static NSString *reuse2 = @"ListeningCourseInfoCell";
    static NSString *reuse3 = @"BuyCoursePaymentAmountCell";
    
    
    if (indexPath.section == 0) {
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            //cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.cellEdge = 10;
        }
        //判断有没有子课程，没有就隐藏
        if (self.subCourseNumeber == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"课程名";
                cell.detailTextLabel.text = self.courseName;
                //return cell;
            }
            else if (indexPath.row == 1){
                
                cell.textLabel.text = @"校区选择";
                cell.detailTextLabel.text = self.schoolZone[@"department"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //return cell;
            }
            else if (indexPath.row == 2){
                
                cell.textLabel.text = @"选择小孩";
                cell.detailTextLabel.text = self.selectedStudent[@"name"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //return cell;
            }
            else{
                //payMethodNumber(pay_type)取值 1按课时价 2按整套价 3两者都可。
                if (self.payMethodNumber == 1) {
                    self.payCourseMethod = @"按课时";
                    cell.detailTextLabel.text = self.payCourseMethod;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                else if (self.payMethodNumber == 2){
                    self.payCourseMethod = @"按整套";
                    cell.detailTextLabel.text = self.payCourseMethod;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                else if(self.payMethodNumber == 3){
                    self.payCourseMethod = @"课时整套均可";
                    cell.detailTextLabel.text = self.payCourseMethod;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.textLabel.text = @"付款方式";
                
                
                
                //return cell;
            }
        }
        else{
            //判断有没有子课程，有就显示
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"课程名";
                    cell.detailTextLabel.text = self.courseName;
                    //return cell;
                }
                else if (indexPath.row == 1){
                    
                    cell.textLabel.text = @"课程分类";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.detailTextLabel.text = self.subCoursename;
                    //return cell;
                }
                else if (indexPath.row == 2){
                    
                    cell.textLabel.text = @"校区选择";
                    cell.detailTextLabel.text = self.schoolZone[@"department"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    //return cell;
                }
                else if (indexPath.row == 3){
                    
                    cell.textLabel.text = @"选择小孩";
                    cell.detailTextLabel.text = self.selectedStudent[@"name"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    //return cell;
                }
                else{
                    //            ListeningCourseInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuse2];
                    //            if (cell2 == nil) {
                    //                cell2 = [[ListeningCourseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
                    //            }
                    //            cell2.cellEdge = 10;
                    //            cell2.myLabel.text = @"购买课时";
                    //
                    //            return cell2;
                    //payMethodNumber(pay_type)取值 1按课时价 2按整套价 3两者都可。
                    if (self.payMethodNumber == 1) {
                        self.payCourseMethod = @"按课时";
                        cell.detailTextLabel.text = self.payCourseMethod;
                        cell.accessoryType = UITableViewCellAccessoryNone;
                    }
                    else if (self.payMethodNumber == 2){
                        self.payCourseMethod = @"按整套";
                        cell.detailTextLabel.text = self.payCourseMethod;
                        cell.accessoryType = UITableViewCellAccessoryNone;
                    }
                    else if(self.payMethodNumber == 3){
                        self.payCourseMethod = @"课时整套均可";
                        cell.detailTextLabel.text = self.payCourseMethod;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    cell.textLabel.text = @"付款方式";
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                    //return cell;
                }

            }
            return cell;
        
        }
        
        
    else if (indexPath.section == 1){
        
        
        if ([self.payCourseMethod isEqualToString:@"按课时"]) {
            if(indexPath.row == 0) {
                
                ListeningCourseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
                if (cell == nil) {
                    cell = [[ListeningCourseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
                }
                cell.cellEdge = 10;
                cell.delegate = self;
                cell.myLabel.text = @"购买课时";
                
                return cell;
            }
            else{
                
                BuyCoursePaymentAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
                
                if (cell == nil) {
                    cell = [[BuyCoursePaymentAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
                }
                cell.cellEdge = 10;
                cell.myLabel.text = @"缴费金额";
                //选择课时时，对缴费金额清零
                if (self.priceTotal == 0) {
                    cell.myPriceLabel.text = @"";
                }
                else{
                    cell.myPriceLabel.text = [NSString stringWithFormat:@"%li",self.priceTotal];
                }
                
                return cell;
            }
        }
        else{
            BuyCoursePaymentAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
            
            if (cell == nil) {
                cell = [[BuyCoursePaymentAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            }
            cell.cellEdge = 10;
            cell.myLabel.text = @"缴费金额";
            
            cell.myPriceLabel.text = [NSString stringWithFormat:@"%li",self.priceTotal];
            
            return cell;
        }
    }
    else if (indexPath.section == 2){
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.cellEdge = 10;
        }
        cell.textLabel.text = @"使用现金券";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        //显示现金券的总值
        if (self.listCouponsArray.count > 0) {
            NSInteger coupons = 0;
            for (int i =0; i<self.listCouponsArray.count; i++) {
                NSDictionary *couponDic = self.listCouponsArray[i];
                NSString *nextCoupon = couponDic[@"price"];
                coupons = coupons + [nextCoupon intValue];
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%li",coupons];
            
        }
        else{
            cell.detailTextLabel.text = @"";
        }
        
        return cell;
    }
    
    else{
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.cellEdge = 10;
        }
        
        return cell;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        //判断有没有子课程，没有就隐藏
        if(self.subCourseNumeber == 0){
            switch (indexPath.row) {
                case 1:
                {
                    courseSchoolZoneVC *vc = [[courseSchoolZoneVC alloc] init];
                    vc.delegate = self;
                    vc.selectedSchool = self.schoolZone[@"department"];
                    //NSLog(@"selectedSchool:%@",vc.selectedSchool);
                    //NSLog(@"parentCourseId:%@",self.parentCourseId);
                    vc.parentCourseId = self.parentCourseId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    SelectedStudentVC *vc = [[SelectedStudentVC alloc] init];
                    vc.delegate = self;
                    vc.selectedStudent = self.selectedStudent[@"name"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3:
                {
                    //pay_type取值 1按课时价 2按整套价 3两者都可。
                    //self.payMethodNumber取值 为3时才可以去选择付款方式。
                    //其他情况下，不让点击
                    if(self.payMethodNumber == 3){
                        PayCourseMethodVCViewController *vc = [[PayCourseMethodVCViewController alloc] init];
                        vc.delegate = self;
                        vc.selectedMethod = self.payCourseMethod;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    break;
                    
                }
                default:
                    break;
            }
        }
        else{
            //判断有没有子课程，有就显示
            switch (indexPath.row) {
                case 1:
                {
                    SubCourseListVC *vc = [[SubCourseListVC alloc] init];
                    vc.delegate = self;
                    vc.selectedCourse = self.subCoursename;
                    vc.parentCourseId = self.parentCourseId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    courseSchoolZoneVC *vc = [[courseSchoolZoneVC alloc] init];
                    vc.delegate = self;
                    vc.selectedSchool = self.schoolZone[@"department"];
                    //NSLog(@"selectedSchool:%@",vc.selectedSchool);
                    //NSLog(@"parentCourseId:%@",self.parentCourseId);
                    vc.parentCourseId = self.parentCourseId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3:
                {
                    SelectedStudentVC *vc = [[SelectedStudentVC alloc] init];
                    vc.delegate = self;
                    vc.selectedStudent = self.selectedStudent[@"name"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 4:
                {
                    if(self.superPayMethodNumber == 3){
                        PayCourseMethodVCViewController *vc = [[PayCourseMethodVCViewController alloc] init];
                        vc.delegate = self;
                        vc.selectedMethod = self.payCourseMethod;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    break;
                }
                default:
                    break;
            }
        }
        
    }
    else if (indexPath.section == 2){
        //点击了使用优惠券，在支付页面没支付，又返回购买页面去选择优惠券时，需要还原原来的支付金额
        [self usedCouponsButNotCompletePayAndGoBackToContinueChoiceCouopnsNeedRestoreTotalPrice];
        CouponsVC *vc = [[CouponsVC alloc] init];
        vc.delegate = self;
        vc.coursePrice = self.priceTotal;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        if ([self.payCourseMethod isEqualToString:@"按课时"]) {
            
//            ListeningCourseInfoCell *cell = [[ListeningCourseInfoCell alloc] init];
//            cell.delegate = self;
//            NSLog(@"hours:%@",self.inputCourseHours);
            
        }
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else if(section == 1){
        return 30.0f;
    }else{
        return 3.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    if (section == 1) {
        
        if (self.superPayMethodNumber == 1) {
            view.frame = CGRectMake(0, 0, kScreenWidth, 40);
            view.backgroundColor = [UIColor clearColor];
            
            UILabel *priceHourTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
            priceHourTipLabel.text = @"课时单价:";//课时价格
            priceHourTipLabel.font = [UIFont systemFontOfSize:12];
            priceHourTipLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceHourTipLabel];
            
            UILabel *priceHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 100, 20)];
            priceHourLabel.text = [NSString stringWithFormat:@"%@元/课",self.priceHour];
            priceHourLabel.font = [UIFont systemFontOfSize:12];
            priceHourLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceHourLabel];
        }
        else if (self.superPayMethodNumber == 2){
            
            view.frame = CGRectMake(0, 0, kScreenWidth, 40);
            view.backgroundColor = [UIColor clearColor];
            
            UILabel *priceTotalTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
            priceTotalTipLabel.text = @"整套价格:";
            priceTotalTipLabel.font = [UIFont systemFontOfSize:12];
            priceTotalTipLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceTotalTipLabel];
            
            UILabel *priceTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 100, 20)];
            priceTotalLabel.text = [NSString stringWithFormat:@"%li元/套",self.priceSeries];//整套价格
            priceTotalLabel.font = [UIFont systemFontOfSize:12];
            priceTotalLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceTotalLabel];
        }
        else if (self.superPayMethodNumber == 3){
            
            view.frame = CGRectMake(0, 0, kScreenWidth, 40);
            view.backgroundColor = [UIColor clearColor];
            
            UILabel *priceHourTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
            priceHourTipLabel.text = @"课时单价:";//课时价格
            priceHourTipLabel.font = [UIFont systemFontOfSize:12];
            priceHourTipLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceHourTipLabel];
            
            UILabel *priceHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 80, 20)];
            priceHourLabel.text = [NSString stringWithFormat:@"%@元/课",self.priceHour];;
            priceHourLabel.font = [UIFont systemFontOfSize:12];
            priceHourLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceHourLabel];
            
            UILabel *priceTotalTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 60, 20)];
            priceTotalTipLabel.text = @"整套价格:";
            priceTotalTipLabel.font = [UIFont systemFontOfSize:12];
            priceTotalTipLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceTotalTipLabel];
            
            UILabel *priceTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 90, 20)];
            priceTotalLabel.text = [NSString stringWithFormat:@"%li元/套",self.priceSeries];//整套价格
            priceTotalLabel.font = [UIFont systemFontOfSize:12];
            priceTotalLabel.textColor = [UIColor grayColor];
            
            [view addSubview:priceTotalLabel];
            
        }
        else{
            
        }

    }else{

    }
    return view;
}



#pragma mark - SelectedCourseDelegate

- (void)selectedCourse:(id)sender{
    
    self.subCourseInfoDic = sender;
    
    NSDictionary *subCourseDic = sender;
    self.subCoursename = subCourseDic[@"title"];
    
    //选择了子课程，就将他的课程id，赋值给购买课程id
    NSNumber *courseNumId = subCourseDic[@"course_id"];
    self.buyCourseId = courseNumId.integerValue;
    
    NSNumber *payMethod = subCourseDic[@"pay_type"];
    self.superPayMethodNumber = payMethod.integerValue;//选定子课程就将子课程的付款方式来修改superPayMethodNumber
    self.payMethodNumber = self.superPayMethodNumber;//将付款方式传给payMethodNumber
    if (self.superPayMethodNumber == 1) {
        self.priceHour = [NSString stringWithFormat:@"%@",subCourseDic[@"price"]];//获取课时价格
        //NSLog(@"hour:%li",(long)[self.priceHour intValue]);
    }
    else if (self.superPayMethodNumber == 2){
        NSNumber *price = subCourseDic[@"total_price"];
        self.priceSeries = price.integerValue;
        //self.priceSeries = [NSString stringWithFormat:@"%@",subCourseDic[@"total_price"]];//获取整套价格
        self.priceTotal = self.priceSeries;//获取整套价格时，改写缴费金额为整套价格，因为默认情况为按整套购买
    }
    else if (self.superPayMethodNumber == 3){
        
        self.priceHour = [NSString stringWithFormat:@"%@",subCourseDic[@"price"]];//获取课时价格
        NSNumber *price = subCourseDic[@"total_price"];
        self.priceSeries = price.integerValue;
        //self.priceSeries = [NSString stringWithFormat:@"%@",subCourseDic[@"total_price"]];//获取整套价格
        self.payCourseMethod = @"课时整套均可";
        self.priceTotal = self.priceSeries;//获取整套价格时，改写缴费金额为整套价格，因为默认情况为按整套购买
    }else{
        
    }
    
    
//    NSNumber *payMethod = subCourseDic[@"pay_type"];
//    self.payMethodNumber = payMethod.integerValue;
    [self.tableView reloadData];
}


#pragma mark - SelectedPayCourseMethodDelegate
- (void)selectedPayCourseMethod:(id)sender{
    
    self.payCourseMethod = sender;
    
    //返回的“按课时”购买时，清除“缴费金额”，此时还不知道缴费金额，有待计算
    if ([self.payCourseMethod isEqualToString:@"按课时"]){
        
        self.payMethodNumber = 1;
        //选定支付方式后，修改各个付款的值
//        self.priceHour = [NSString stringWithFormat:@"%@",self.subCourseInfoDic[@"price"]];//获取课时价格
        //按课时购买时，要将缴费金额清零
        self.priceTotal = 0;
        //self.priceTotal = @"";
    }
    else{
        self.payMethodNumber = 2;
        //选定支付方式后，修改各个付款的值
//        self.priceSeries = [NSString stringWithFormat:@"%@",self.subCourseInfoDic[@"total_price"]];//获取整套价格
        self.priceTotal = self.priceSeries;//获取整套价格时，改写缴费金额为整套价格，因为默认情况为按整套购买
    }
    [self.tableView reloadData];
}

#pragma mark - ListeningCorseInfoCellDelegate
- (void)listeningCourseInfoCellInputCourseHours:(NSString *)sender {
    self.inputCourseHours = sender;
    self.priceTotal = [self.inputCourseHours intValue] *[self.priceHour intValue];
    //self.priceTotal =[NSString stringWithFormat:@"%d", [self.inputCourseHours intValue] *[self.priceHour intValue]];//按课时计算需要缴费金额
    
    [self.tableView reloadData];
    //NSLog(@"self.inputCourseHours:%@",self.inputCourseHours);
}


#pragma mark - changeSelectedBtnDelegate

- (void)changeSelectedBtn:(BOOL)sender{
    self.selectedBtn.selected = sender;
}

#pragma mark - CourseSchoolZoneDelegate
- (void)courseSelectedSchoolZone:(id)sender{
    self.schoolZone = sender;
    [self.tableView reloadData];
}

#pragma mark - SelectedStudentVC selectedStudentDelegate
- (void)selectedStudent:(id)sender{
    self.selectedStudent = sender;
    [self.tableView reloadData];
}
//获取现金券
#pragma mark - CouponsVCCouponsUsedDelegate
- (void)couponsUsed:(id)sender andCouponsArray:(NSMutableArray *)couponsArray{
    self.listCouponsString = sender;
    self.listCouponsArray = couponsArray;
    //最终价格需要减去优惠券的价格
    [self usedCouponsToChangeTotalPrice];
    NSLog(@"price:%li",self.priceTotal);
    [self.tableView reloadData];
}

//使用优惠券后修改付款价格
- (void)usedCouponsToChangeTotalPrice{
    
    if ([self.listCouponsArray count] != 0) {
        for (id indexDic in self.listCouponsArray) {
            NSNumber *price = indexDic[@"price"];
            
            self.priceTotal = self.priceTotal - price.integerValue;
        }
    }
}

//点击了使用优惠券，在支付页面没支付，又返回购买页面去选择优惠券时，需要还原原来的支付金额
- (void)usedCouponsButNotCompletePayAndGoBackToContinueChoiceCouopnsNeedRestoreTotalPrice{
    
    if ([self.listCouponsArray count] != 0) {
        for (id indexDic in self.listCouponsArray) {
            NSNumber *price = indexDic[@"price"];
            
            self.priceTotal = self.priceTotal + price.integerValue;
        }
    }
}

@end
