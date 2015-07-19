//
//  ExpendRecordVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ExpendRecordVC.h"
#import "ExpendRecordCell.h"

#import "CannelOrderExplainVC.h"
#import "XeeService.h"

#import "OrderPayVC.h"

@interface ExpendRecordVC ()<UITableViewDataSource,UITableViewDelegate,ExpendRecordCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *expendRecordsArray;

@property (nonatomic, assign) NSInteger currentExpendRecordPageIndex;//交易记录当前页
@property (nonatomic, assign) NSInteger totleExpendRecordPageIndex;//交易记录总页数

@end

@implementation ExpendRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消费记录";
    
    _currentExpendRecordPageIndex = 1;
    _totleExpendRecordPageIndex = 0;
    
    [self setupRefresh:@"table"];
}

- (void)initUI{
    
    [super initUI];
    
    self.expendRecordsArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //[self getVOrderByParentId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Web
/*- (void)getVOrderByParentId{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getVOrderByParentIdWithParentId:userInfoDic[uUserId] andSort:@"" andOrder:@"" andType:@"1" andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                NSDictionary *expendRecordsDic = result[@"resultInfo"];
                self.expendRecordsArray = expendRecordsDic[@"data"];
                [self.tableView reloadData];
            }
        }
    }];
}*/
- (void)getVOrderByParentIdWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //[self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getVOrderByParentIdWithParentId:userInfoDic[uUserId] andSort:@"" andOrder:@"" andType:@"1,3" andPageSize:10 andPageIndex:pageIndex andToken:userInfoDic[uUserToken] andBlock:block];
}


#pragma mark -
#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh:(NSString *)dateKey
{

    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新";
    _tableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
    
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    _tableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
}

- (void)headerRereshing{
    self.currentExpendRecordPageIndex = 1;
    
    [self getVOrderByParentIdWithPageIndex:_currentExpendRecordPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
        [self.tableView headerEndRefreshing];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *expendRecordsDic = result[@"resultInfo"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:expendRecordsDic[@"data"]];
                self.expendRecordsArray = array;
                [self.tableView reloadData];
                
                NSNumber *totleNum = expendRecordsDic[@"totalPage"];
                if (totleNum) {
                    self.totleExpendRecordPageIndex = totleNum.integerValue;
                }
            }else{
                [self showHudOnlyMsg:@"未知错误"];
            }
        }else{
            [self showHudOnlyMsg:@"网络错误"];
        }
    }];
}

- (void)footerRereshing{
    
    if (_currentExpendRecordPageIndex < _totleExpendRecordPageIndex) {
        _currentExpendRecordPageIndex++;
        [self getVOrderByParentIdWithPageIndex:_currentExpendRecordPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.tableView footerEndRefreshing];
            
            if (!error) {
                NSNumber *isResult = result[@"result"];
                
                if (isResult.integerValue == 0) {
                    NSDictionary *expendRecordsDic = result[@"resultInfo"];
                    
                    [self.expendRecordsArray addObjectsFromArray:expendRecordsDic[@"data"]];
                    
                    [self.tableView reloadData];
                    
                    NSNumber *totleNum = expendRecordsDic[@"totalPage"];
                    if (totleNum) {
                        self.totleExpendRecordPageIndex = totleNum.integerValue;
                    }
                }else{
                    [self showHudOnlyMsg:@"未知错误"];
                }
            }else{
                [self showHudOnlyMsg:@"网络错误"];
            }
            
        }];
    }else{
        [self.tableView footerEndRefreshing];
        [self showHudOnlyMsg:@"已全部加载完"];
    }
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.expendRecordsArray.count;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"ExpendRecordVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"ExpendRecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    ExpendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[ExpendRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    cell.cellEdge = 10;
    cell.expendRecordInfoDic = self.expendRecordsArray[indexPath.section];
    cell.delegate = self;
    
    return cell;
    
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 290.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5.0f;
    }
    else{
        return 3.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}


#pragma mark - ExpendRecordCellDelegate

- (void)expendRecordCellCannelBtnPressed:(id)sender {
    CannelOrderExplainVC *vc = [[CannelOrderExplainVC alloc] init];
    vc.expendRecordInfoDic = sender;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)expendRecordCellPayBtnClicked {
    OrderPayVC *vc = [[OrderPayVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
