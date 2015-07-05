//
//  PointsVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PointsVC.h"
#import "PointsRecordCell.h"

#import "ExchangePointsVC.h"
#import "PointSRuleVC.h"

#import "XeeService.h"

@interface PointsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *exchangeRecordArray;//兑换纪录数组
@end

@implementation PointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分交易记录";
}

- (void)initUI{
    
    [super initUI];
    
    self.exchangeRecordArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40+64, kScreenWidth, kScreenHeight-40-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //增加一个“积分规则”的按钮
    UIButton *pointsRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pointsRuleBtn setFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    [pointsRuleBtn setBackgroundColor:[UIColor grayColor]];
    [pointsRuleBtn setTitle:@"积分规则..." forState:UIControlStateNormal];
    [pointsRuleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pointsRuleBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [pointsRuleBtn addTarget:self action:@selector(pointsRuleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pointsRuleBtn];
    
    //在导航栏右边增加一个“积分兑换”的按钮
    UIButton *exchangePointsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exchangePointsBtn setFrame:CGRectMake(kScreenWidth-70, 15, 60, 30)];
    [exchangePointsBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [exchangePointsBtn setTitle:@"积分兑换" forState:UIControlStateNormal];
    [exchangePointsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exchangePointsBtn addTarget:self action:@selector(exchangePointsBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *exchangePointsBarBtn = [[UIBarButtonItem alloc] initWithCustomView:exchangePointsBtn];
    self.navigationItem.rightBarButtonItem = exchangePointsBarBtn;
    
    //获取网络数据
    [self getPointsRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My Action
- (void)exchangePointsBtnClicked{
    
    ExchangePointsVC *vc = [[ExchangePointsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pointsRuleBtnClicked{
    
    PointSRuleVC *vc = [[PointSRuleVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getPointsRecord{
    
//    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
//    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] getPointsWithPageSize:10 andPageIndex:1 andParentId:ceShiId andToken:ceShiToken andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                
                self.exchangeRecordArray = result[@"resultInfo"];
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络问题"];
        }
    }];
    
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.exchangeRecordArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"PointsVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"PointsRecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    PointsRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[PointsRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.pointRecordInfoDic = self.exchangeRecordArray[indexPath.section];
    
    return cell;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5.0f;
    }
    else{
        return 2.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140.0f;
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
