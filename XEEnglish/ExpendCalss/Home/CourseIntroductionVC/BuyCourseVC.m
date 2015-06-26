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
#import "PayCourseMethodVCViewController.h"

#import "PayCourseVC.h"
#import "PayProtocolVC.h"

@interface BuyCourseVC ()<UITableViewDataSource,UITableViewDelegate,changeSelectedBtnDelegate,SelectedCourseDelegate,SelectedPayCourseMethodDelegate,ListeningCourseInfoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *selectedBtn;//是否同意了协议

@property (nonatomic, strong) NSString *subCoursename;//子课程名
@property (nonatomic, strong) NSString *payCourseMethod;//付款方式
@property (nonatomic, strong) NSString *inputCourseHours;//按课时购买时，输入的课时数
@end

@implementation BuyCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程购买";
}

- (void)initUI{
    
    [super initUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [self footView];
    [self.view addSubview:self.tableView];
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
    [buyBtn setFrame:CGRectMake(20, 60, kScreenWidth-40, 40)];
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
    if (self.selectedBtn.selected) {
        PayCourseVC *vc = [[PayCourseVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [UIFactory showAlert:@"请阅读并同意协议"];
    }
    
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }
    else if(section == 1){
        if ([self.payCourseMethod isEqualToString:@"按课时"]){
            return 2;
        }
        else{
            return 1;
        }
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
            cell.textLabel.text = @"付款方式";
            cell.detailTextLabel.text = self.payCourseMethod;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            //return cell;
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
                cell.myPriceLabel.text = self.priceTotal;
                
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
            cell.myPriceLabel.text = self.priceTotal;
            return cell;
        }
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
        switch (indexPath.row) {
            case 1:
            {
                SubCourseListVC *vc = [[SubCourseListVC alloc] init];
                vc.delegate = self;
                vc.selectedCourse = self.subCoursename;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3:
            {
                PayCourseMethodVCViewController *vc = [[PayCourseMethodVCViewController alloc] init];
                vc.delegate = self;
                vc.selectedMethod = self.payCourseMethod;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
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
    else{
        return 30.0f;
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
    if (section == 1 && self.subCoursename != nil) {
        view.frame = CGRectMake(0, 0, kScreenWidth, 40);
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *priceHourTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
        priceHourTipLabel.text = @"课时单价:";
        priceHourTipLabel.font = [UIFont systemFontOfSize:12];
        priceHourTipLabel.textColor = [UIColor grayColor];
        
        [view addSubview:priceHourTipLabel];
        
        UILabel *priceHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 30, 20)];
        priceHourLabel.text = [NSString stringWithFormat:@"%@;",self.priceHour];
        priceHourLabel.font = [UIFont systemFontOfSize:12];
        priceHourLabel.textColor = [UIColor grayColor];
        
        [view addSubview:priceHourLabel];
        
        UILabel *priceTotalTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 60, 20)];
        priceTotalTipLabel.text = @"整套价格:";
        priceTotalTipLabel.font = [UIFont systemFontOfSize:12];
        priceTotalTipLabel.textColor = [UIColor grayColor];
        
        [view addSubview:priceTotalTipLabel];
        
        UILabel *priceTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 60, 20)];
        priceTotalLabel.text = self.priceTotal;
        priceTotalLabel.font = [UIFont systemFontOfSize:12];
        priceTotalLabel.textColor = [UIColor grayColor];
        
        [view addSubview:priceTotalLabel];

    }else{

    }
    return view;
}



#pragma mark - SelectedCourseDelegate

- (void)selectedCourse:(id)sender{
    NSDictionary *subCourseDic = sender;
    self.subCoursename = subCourseDic[@"title"];
    self.priceHour = [NSString stringWithFormat:@"%@",subCourseDic[@"price"]];
    self.priceTotal = [NSString stringWithFormat:@"%@",subCourseDic[@"total_price"]];
    [self.tableView reloadData];
}


#pragma mark - SelectedPayCourseMethodDelegate
- (void)selectedPayCourseMethod:(id)sender{
    
    self.payCourseMethod = sender;
    [self.tableView reloadData];
}

#pragma mark - ListeningCorseInfoCellDelegate
- (void)listeningCourseInfoCellInputCourseHours:(NSString *)sender {
    self.inputCourseHours = sender;
    NSLog(@"self.inputCourseHours:%@",self.inputCourseHours);
}
//- (void)inputCourseHours:(id)sender{
//    
//    self.inputCourseHours = sender;
//}

#pragma mark - changeSelectedBtnDelegate

- (void)changeSelectedBtn:(BOOL)sender{
    self.selectedBtn.selected = sender;
}

@end
