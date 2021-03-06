//
//  PointsVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PointsVC.h"
#import "PointsRecordCell.h"

//#import "ExchangePointsVC.h"
//#import "PointSRuleVC.h"

#import "XeeService.h"

@interface PointsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *exchangeRecordArray;//兑换纪录数组

@property (nonatomic, assign) NSInteger currentPointPageIndex;//当前pageIndex
@property (nonatomic, assign) NSInteger totlePointPageIndex;//总页数
@end

@implementation PointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分交易记录";
    
    _currentPointPageIndex = 1;
    _totlePointPageIndex = 0;
    
    [self setupRefresh:@"table"];
}

- (void)initUI{
    
    [super initUI];
    
    self.exchangeRecordArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    
    //获取网络数据
    //[self getPointsRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Web
/*- (void)getPointsRecord{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getPointsWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                NSDictionary *pointDic = result[@"resultInfo"];
                self.exchangeRecordArray = pointDic[@"data"];
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络问题"];
        }
    }];
    
}*/

- (void)getPointsRecordWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //[self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getPointsWithPageSize:10 andPageIndex:pageIndex andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:block];
    
}

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
    
    self.currentPointPageIndex = 1;
    
    [self getPointsRecordWithPageIndex:_currentPointPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
        [self.tableView headerEndRefreshing];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                NSDictionary *pointDic = result[@"resultInfo"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:pointDic[@"data"]];
                
                self.exchangeRecordArray = array;
                
                [self.tableView reloadData];
                NSNumber *totleNum = pointDic[@"totalPage"];
                if (totleNum) {
                    self.totlePointPageIndex = totleNum.integerValue;
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
    
    
    if (_currentPointPageIndex < _totlePointPageIndex) {
        _currentPointPageIndex++;
        [self getPointsRecordWithPageIndex:_currentPointPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.tableView footerEndRefreshing];
            if (!error) {
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    NSDictionary *pointDic = result[@"resultInfo"];
                    [self.exchangeRecordArray addObjectsFromArray:pointDic[@"data"]];
                    [self.tableView reloadData];
                    
                    NSNumber *totleNum = pointDic[@"totalPage"];
                    if (totleNum) {
                        self.totlePointPageIndex = totleNum.integerValue;
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
