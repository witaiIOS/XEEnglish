//
//  ActivityVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityCell.h"
#import "LXSegmentView.h"

#import "ActivityDetailVC.h"

#import "SchedulePlace.h"
#import "XeeService.h"

@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate,ActivityCellActivityReserveBtnPressedDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) LXSegmentView *mySegmentView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@property (nonatomic, strong) NSMutableArray *tableList1;
@property (nonatomic, strong) NSMutableArray *tableList2;

@property (nonatomic, strong) NSString *activitId;

@end

@implementation ActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableList1 = [NSMutableArray array];
    _tableList2 = [NSMutableArray array];
    
    [self getActivityInfo];
    
    self.activitId = nil;//活动id初始化

}

- (void)initUI{
    [super initUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.mySegmentView = [[LXSegmentView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
    self.mySegmentView.tabBgImageView.image = [UIImage imageNamed:@"bg_tab_selected.png"];
    self.mySegmentView.tabButtonSeclectImageView.image = [UIImage imageNamed:@"select_flag.png"];
    self.mySegmentView.tabButtonColor = [UIColor blackColor];
    self.mySegmentView.tabButtonSelectCorlor = [UIColor redColor];
    [self.mySegmentView setTabButton1Title:@"当前活动" andButton2Title:@"历史活动"];
    
    [self.view addSubview:self.mySegmentView];
    
    CGFloat segHeight = self.mySegmentView.frame.size.height;
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, segHeight-42) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.backgroundColor = [UIColor clearColor];
    
    [self.mySegmentView.mainScrollView addSubview:self.tableView1];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, segHeight-42) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.backgroundColor = [UIColor clearColor];
    
    [self.mySegmentView.mainScrollView addSubview:self.tableView2];
    
    
    UIButton *reservePlaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reservePlaceBtn setFrame:CGRectMake(kScreenWidth-90, 15, 80, 30)];
    //reservePlaceBtn.backgroundColor = [UIColor orangeColor];
    [reservePlaceBtn setTitle:@"场馆预定" forState:UIControlStateNormal];
    [reservePlaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reservePlaceBtn.titleLabel setFont: [UIFont systemFontOfSize:16.0]];
    [reservePlaceBtn addTarget:self action:@selector(reservePlaceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *reservePlaceBarBtn = [[UIBarButtonItem alloc] initWithCustomView:reservePlaceBtn];
    self.navigationItem.rightBarButtonItem = reservePlaceBarBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getActivityInfo
- (void)getActivityInfo{
    [[XeeService sharedInstance] getActivityInfoWithPageSize:10 andPageIndex:1 andParentId:0 andToken:@"" andBlock:^(NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        
        if (!error) {
            
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSLog(@"info:%@",result[@"resultInfo"]);
                NSDictionary *resultInfoDic = result[@"resultInfo"];
                _tableList1 = resultInfoDic[@"data"];
                //NSLog(@"list:%@",_tableList1);
                
                [self.tableView1 reloadData];
            }
            else {
                [UIFactory showAlert:@"未知错误"];
            }

        }
        else {
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}

#pragma mark - action

- (void)reservePlaceBtnAction{
    
    SchedulePlace *vc = [[SchedulePlace alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}




#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView1) {
        //NSLog(@"count:%li",_tableList1.count);
        return _tableList1.count;
    }
    else if (tableView == self.tableView2){
        return 6;
    }
    else{
        return 0;
    }

}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"CellActivityIdentifier";
    static NSString *reuse2 = @"CellActivityIdentifier";
    static NSString *reuse3 = @"CellActivityIdentifier";
    
    if (tableView == self.tableView1) {
        [tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse1];
        
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            
        }
        
        cell.cellEdge = 10;
        cell.delegate = self;
        cell.activityInfo = _tableList1[indexPath.section];
                
        return cell;
        
    }
    else if (tableView == self.tableView2){
        
        [tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        cell.cellEdge = 10;
        
        if (cell == nil) {
            cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
            
        }
        
        return cell;
    }
    else{
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
        }
        cell.cellEdge = 10;
        return cell;
    
    }
    
}

#pragma mark - UITableView Delegate

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 280.0f;

}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityDetailVC *vc = [[ActivityDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.avtivitInfoDic = self.tableList1[indexPath.section];
    //NSLog(@"avtivitInfoDic:%@",vc.avtivitInfoDic);
    [self.navigationController pushViewController:vc animated:YES];
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
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - ActivityCellActivityReserveBtnPressedDelegate
- (void)activityReserveBtnPressed:(id)sender{
    
    self.activitId = sender;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您是否预约该活动" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [self makeActivityAndActivityId:self.activitId];

    }
}


- (void)alertViewCancel:(UIAlertView *)alertView{
    
    
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
