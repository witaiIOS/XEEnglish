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

@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate,ActivityCellActivityReserveBtnPressedDelegate,UIAlertViewDelegate, LXSegmentViewDelegate>

@property (nonatomic, strong) LXSegmentView *mySegmentView;
@property ( nonatomic) NSInteger currentIndex;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@property (nonatomic, strong) NSMutableArray *tableList1;
@property (nonatomic, strong) NSMutableArray *tableList2;

@property (nonatomic) NSInteger currentOrderPageIndex;
@property (nonatomic) NSInteger historyOrderPageIndex;
@property (nonatomic) NSInteger currentOrderTotalPage;
@property (nonatomic) NSInteger historyOrderTotalPage;

@property (nonatomic, strong) NSString *activitId;

@property (nonatomic, assign) NSInteger activityStatus;

@end

@implementation ActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableList1 = [NSMutableArray array];
    _tableList2 = [NSMutableArray array];
    
    
    _currentOrderPageIndex = 1;
    _historyOrderPageIndex = 1;
    _currentOrderTotalPage = 0;
    _historyOrderTotalPage = 0;
    
    //self.activityStatus = self.mySegmentView.currentIndex;
    //NSLog(@"%li",self.activityStatus);
    //[self getActivityInfo];
    
    self.activitId = nil;//活动id初始化
    
    _currentIndex = 0;
    [self setupRefresh:@"table1"];

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
    self.mySegmentView.delegate = self;
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
- (void)getCurrentActivityInfoWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"%li",self.mySegmentView.currentIndex);
    //[self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getActivityInfoWithPageSize:10 andPageIndex:pageIndex andActivityStatus:0 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:block];/*^(NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        //[self hideHud];
        }];*/
    
   }

- (void)getHistoryActivityInfoWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] getActivityInfoWithPageSize:10 andPageIndex:pageIndex andActivityStatus:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:block];/*^(NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        //[self hideHud];
    }];*/

}

#pragma mark - action

- (void)reservePlaceBtnAction{
    
    SchedulePlace *vc = [[SchedulePlace alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

#pragma mark -
#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh:(NSString *)dateKey
{
    if (_currentIndex == 0) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
        [_tableView1 addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
        //#warning 自动刷新(一进入程序就下拉刷新)
        [_tableView1 headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [_tableView1 addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        _tableView1.headerPullToRefreshText = @"下拉可以刷新";
        _tableView1.headerReleaseToRefreshText = @"松开马上刷新";
        _tableView1.headerRefreshingText = @"正在努力帮您刷新中,不客气";
        
        _tableView1.footerPullToRefreshText = @"上拉可以加载更多数据";
        _tableView1.footerReleaseToRefreshText = @"松开马上加载更多数据";
        _tableView1.footerRefreshingText = @"正在努力帮您加载中,不客气";
    }
    else if (_currentIndex == 1) {
        [_tableView2 addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
        [_tableView2 headerBeginRefreshing];
        
        [_tableView2 addFooterWithTarget:self action:@selector(footerRereshing)];
        
        _tableView2.headerPullToRefreshText = @"下拉可以刷新";
        _tableView2.headerReleaseToRefreshText = @"松开马上刷新";
        _tableView2.headerRefreshingText = @"正在努力帮您刷新中,不客气";
        
        _tableView2.footerPullToRefreshText = @"上拉可以加载更多数据";
        _tableView2.footerReleaseToRefreshText = @"松开马上加载更多数据";
        _tableView2.footerRefreshingText = @"正在努力帮您加载中,不客气";
    }
}

- (void)headerRereshing
{
    if (_currentIndex == 0) {
        self.currentOrderPageIndex = 1;
       [self getCurrentActivityInfoWithPageIndex:_currentOrderPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
           [self.tableView1 headerEndRefreshing];
           if (!error) {
               
               NSLog(@"result:%@",result);
               
               NSNumber *isResult = result[@"result"];
               if (isResult.integerValue == 0) {
                   //NSLog(@"info:%@",result[@"resultInfo"]);
                   NSDictionary *resultInfoDic = result[@"resultInfo"];
                   _tableList1 = resultInfoDic[@"data"];
                   //NSLog(@"list:%@",_tableList1);
                   
                   NSNumber *totalNum = resultInfoDic[@"totalPage"];
                   if (totalNum) {
                       self.currentOrderTotalPage = totalNum.integerValue;
                   }
                   
                   
                   [self.tableView1 reloadData];
               }
               else {
                   [self showHudOnlyMsg:@"未知错误"];
               }
               
           }
           else {
               [self showHudOnlyMsg:@"网络错误"];
           }

       }];
    }
    else if (_currentIndex == 1) {
        self.historyOrderPageIndex = 1;
        [self getHistoryActivityInfoWithPageIndex:_historyOrderPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.tableView2 headerEndRefreshing];
            if (!error) {
                
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    //NSLog(@"info:%@",result[@"resultInfo"]);
                    NSDictionary *resultInfoDic = result[@"resultInfo"];
                    _tableList2 = resultInfoDic[@"data"];
                    //NSLog(@"list:%@",_tableList1);
                    
                    NSNumber *totalNum = resultInfoDic[@"totalPage"];
                    if (totalNum) {
                        self.historyOrderTotalPage = totalNum.integerValue;
                    }

                    
                    [self.tableView2 reloadData];
                }
                else {
                    [self showHudOnlyMsg:@"未知错误"];
                }
                
            }
            else {
                [self showHudOnlyMsg:@"网络错误"];
            }

        }];
    }
   
    // 刷新表格
    //[self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //[self.tableView headerEndRefreshing];

}

- (void)footerRereshing {
    if (_currentIndex == 0) {
        
        if (_currentOrderPageIndex < _currentOrderTotalPage) {//没有加载完
            
            _currentOrderPageIndex++;
            [self getCurrentActivityInfoWithPageIndex:_currentOrderPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
                [_tableView1 footerEndRefreshing];
                
                if (!error) {
                    
                    NSNumber *isResult = result[@"result"];
                    if (isResult.integerValue == 0) {
                        //NSLog(@"info:%@",result[@"resultInfo"]);
                        NSDictionary *resultInfoDic = result[@"resultInfo"];
                        //_tableList1 = resultInfoDic[@"data"];
                        //NSLog(@"list:%@",_tableList1);
                        [_tableList1 addObjectsFromArray:resultInfoDic[@"data"]];
                        [self.tableView1 reloadData];
                        
                        NSNumber *totalNum = resultInfoDic[@"totalPage"];
                        if (totalNum) {
                            self.currentOrderTotalPage = totalNum.integerValue;
                        }
                        
                        
                        
                    }
                    else {
                        //[self showHudOnlyMsg:@"未知错误"];
                    }
                    
                }
                else {
                    //[self showHudOnlyMsg:@"网络错误"];
                }

                
            }];

        }
        else {
            [_tableView1 footerEndRefreshing];
            [self showHudOnlyMsg:@"已全部加载完"];
        }
        
    }
    else if (_currentIndex == 1) {
        
        if (_historyOrderPageIndex < _historyOrderTotalPage) {
            
            _historyOrderPageIndex++;
            [self getHistoryActivityInfoWithPageIndex:_historyOrderPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
                
                [_tableView2 footerEndRefreshing];
                if (!error) {
                    
                    NSNumber *isResult = result[@"result"];
                    if (isResult.integerValue == 0) {
                        //NSLog(@"info:%@",result[@"resultInfo"]);
                        NSDictionary *resultInfoDic = result[@"resultInfo"];
                        //_tableList2 = resultInfoDic[@"data"];
                        //NSLog(@"list:%@",_tableList1);
                        [_tableList2 addObjectsFromArray:resultInfoDic[@"data"]];
                        [self.tableView2 reloadData];
                        
                        NSNumber *totalNum = resultInfoDic[@"totalPage"];
                        if (totalNum) {
                            self.historyOrderTotalPage = totalNum.integerValue;
                        }
                        
                        
                        
                    }
                    else {
                        //[self showHudOnlyMsg:@"未知错误"];
                    }
                    
                }
                else {
                    //[self showHudOnlyMsg:@"网络错误"];
                }

            }];

        }
        else {
            [_tableView2 footerEndRefreshing];
            [self showHudOnlyMsg:@"已全部加载完"];
        }
    }

}



#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView1) {
        //NSLog(@"count:%li",_tableList1.count);
        return _tableList1.count;
    }
    else if (tableView == self.tableView2){
        return _tableList2.count;
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
        //NSLog(@"list:%@",self.tableList1);
        //NSLog(@"info:%@",cell.activityInfo);
                
        return cell;
        
    }
    else if (tableView == self.tableView2){
        
        [tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        cell.cellEdge = 10;
        
        if (cell == nil) {
            cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
            
        }
        cell.delegate = self;
        cell.activityInfo = _tableList2[indexPath.section];
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
    [self showHudWithMsg:@"上传中..."];
    [[XeeService sharedInstance] makeActivityWithParentId:userInfoDic[uUserId] andActivityId:activityId andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
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

#pragma mark - LXSegmentView delegate
- (void)lxSegmentViewTurnTabWithCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    
    if (currentIndex == 0) {
        if (_tableList1.count == 0) {
            [self setupRefresh:@"table1"];
        }
    }
    else if (currentIndex == 1) {
        if (_tableList2.count == 0) {
            [self setupRefresh:@"table2"];
        }
    }
}

@end
