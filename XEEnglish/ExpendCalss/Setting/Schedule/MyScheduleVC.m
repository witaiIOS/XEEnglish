//
//  MyScheduleVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyScheduleVC.h"
#import "LXSegmentViewThree.h"

#import "ExpendRecordCell.h"
#import "MyActivityCell.h"
#import "MyBookSiteCell.h"

#import "XeeService.h"

@interface MyScheduleVC ()<UITableViewDataSource,UITableViewDelegate,LXSegmentViewThreeDelegate>
@property (nonatomic, strong) LXSegmentViewThree *mySegmentView;
@property ( nonatomic) NSInteger currentIndex;//当前tableview标示

@property (nonatomic, strong) UITableView *courseTableView;//我预定的课程
@property (nonatomic, strong) NSMutableArray *courseArray;//

@property (nonatomic, strong) UITableView *activityTableView;//我预定的活动。
@property (nonatomic, strong) NSMutableArray *activityArray;

@property (nonatomic, strong) UITableView *bookSiteTableView;//我预定的场馆
@property (nonatomic, strong) NSMutableArray *bookSiteArray;

@property (nonatomic, assign) NSInteger currentCoursePageIndex;//当前课程页
@property (nonatomic, assign) NSInteger totleCoursePageIndex;//课程页总数

@property (nonatomic, assign) NSInteger currentActivityPageIndex;//当前活动页
@property (nonatomic, assign) NSInteger totleActivityPageIndex;//活动页总数

@property (nonatomic, assign) NSInteger currentBookSitePageIndex;//当前场馆页
@property (nonatomic, assign) NSInteger totleBookSitePageIndex;//场馆页总数

@end

@implementation MyScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的预定";
    
    _currentCoursePageIndex = 1;
    _currentActivityPageIndex = 1;
    _currentBookSitePageIndex = 1;
    _totleCoursePageIndex = 0;
    _totleActivityPageIndex = 0;
    _totleBookSitePageIndex = 0;
    
    _currentIndex = 0;
    [self setUpRefrash:@"table1"];
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.courseArray = [NSMutableArray array];
    //[self getMyCourseInfo];
    
    self.activityArray = [NSMutableArray array];
    //[self getMyActivityInfo];
    
    self.bookSiteArray = [NSMutableArray array];
    //[self getMyBookSiteInfo];
    
    
    self.mySegmentView = [[LXSegmentViewThree alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.mySegmentView.tabBgImageView.image = [UIImage imageNamed:@"bg_tab_selected.png"];
    self.mySegmentView.tabButtonSeclectImageView.image = [UIImage imageNamed:@"select_flag.png"];
    self.mySegmentView.tabButtonColor = [UIColor blackColor];
    self.mySegmentView.tabButtonSelectCorlor = [UIColor redColor];
    
    [self.mySegmentView setTabButton1Title:@"课程" andButton2Title:@"活动" andButton3Title:@"场馆"];
    self.mySegmentView.delegate = self;
    
    [self.view addSubview:self.mySegmentView];
    
    self.courseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.courseTableView.backgroundColor = [UIColor clearColor];
    self.courseTableView.dataSource = self;
    self.courseTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.courseTableView];
    
    self.activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.activityTableView.backgroundColor = [UIColor clearColor];
    self.activityTableView.dataSource = self;
    self.activityTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.activityTableView];
    
    self.bookSiteTableView = [[UITableView alloc] initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
    self.bookSiteTableView.backgroundColor = [UIColor clearColor];
    self.bookSiteTableView.dataSource = self;
    self.bookSiteTableView.delegate = self;
    
    [self.mySegmentView.mainScrollView addSubview:self.bookSiteTableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)getMyCourseInfo{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getVOrderByParentIdWithParentId:userInfoDic[uUserId] andSort:@"" andOrder:@"" andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                NSDictionary *courseDic = result[@"resultInfo"];
                
                self.courseArray = courseDic[@"data"];
                //NSLog(@"array:%@",self.courseArray);
                [self.courseTableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}*/
- (void)getMyCourseInfoWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] getVOrderByParentIdWithParentId:userInfoDic[uUserId] andSort:@"" andOrder:@"" andType:@"2,3" andPageSize:10 andPageIndex:pageIndex andToken:userInfoDic[uUserToken] andBlock:block];
}


/*- (void)getMyActivityInfo{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] GetActivityInfoByParentIdWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        //NSLog(@"result:%@",result);
        
        if (!error) {
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                //NSLog(@"info:%@",result[@"resultInfo"]);
                NSDictionary *activityDic = result[@"resultInfo"];
                self.activityArray = activityDic[@"data"];
                //NSLog(@"activityArray:%@",self.activityArray);
                [self.activityTableView reloadData];
                
            }
            else{
                
                [UIFactory showAlert:@"未知错误"];
            }
        }
        else{
            
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}*/

- (void)getMyActivityInfoWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];

    [[XeeService sharedInstance] GetActivityInfoByParentIdWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:block];
}

/*- (void)getMyBookSiteInfo{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"token:%@",userInfoDic[uUserToken]);
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getBookSiteByParent_idWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        //NSLog(@"result:%@",result);
        
        if (!error) {
            //NSLog(@"result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                //NSLog(@"info:%@",result[@"resultInfo"]);
                NSDictionary *mybookSiteDic= result[@"resultInfo"];
                self.bookSiteArray = mybookSiteDic[@"data"];
                //NSLog(@"bookSiteArray:%@",self.bookSiteArray);
                [self.bookSiteTableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"未知错误"];
        }
    }];
}*/

- (void)getMyBookSiteInfoWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"token:%@",userInfoDic[uUserToken]);
    [[XeeService sharedInstance] getBookSiteByParent_idWithPageSize:10 andPageIndex:1 andParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:block];
}


#pragma mark - MJRefresh

- (void)setUpRefrash:(NSString *)dateKey{
    if (_currentIndex == 0) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
        [_courseTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
        //#warning 自动刷新(一进入程序就下拉刷新)
        [_courseTableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [_courseTableView addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        _courseTableView.headerPullToRefreshText = @"下拉可以刷新";
        _courseTableView.headerReleaseToRefreshText = @"松开马上刷新";
        _courseTableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
        
        _courseTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
        _courseTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
        _courseTableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
    }
    else if (_currentIndex == 1) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
        [_activityTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
        //#warning 自动刷新(一进入程序就下拉刷新)
        [_activityTableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [_activityTableView addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        _activityTableView.headerPullToRefreshText = @"下拉可以刷新";
        _activityTableView.headerReleaseToRefreshText = @"松开马上刷新";
        _activityTableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
        
        _activityTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
        _activityTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
        _activityTableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
    }
    else if (_currentIndex == 2) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
        [_bookSiteTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
        //#warning 自动刷新(一进入程序就下拉刷新)
        [_bookSiteTableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [_bookSiteTableView addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        _bookSiteTableView.headerPullToRefreshText = @"下拉可以刷新";
        _bookSiteTableView.headerReleaseToRefreshText = @"松开马上刷新";
        _bookSiteTableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
        
        _bookSiteTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
        _bookSiteTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
        _bookSiteTableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
    }
}


- (void)headerRereshing{
    if (_currentIndex == 0){
        self.currentCoursePageIndex = 1;
        [self getMyCourseInfoWithPageIndex:_currentCoursePageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.courseTableView headerEndRefreshing];
            if (!error) {
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    NSDictionary *courseDic = result[@"resultInfo"];
                    
                    self.courseArray = courseDic[@"data"];
                    //NSLog(@"array:%@",self.courseArray);
                    NSNumber *totalNum = courseDic[@"totalPage"];
                    if (totalNum) {
                        self.totleCoursePageIndex = totalNum.integerValue;
                    }
                    
                    [self.courseTableView reloadData];
                }else {
                    [self showHudOnlyMsg:@"未知错误"];
                }
            }else {
                [self showHudOnlyMsg:@"网络错误"];
            }
        }];
    }
    else if (_currentIndex == 1){
        self.currentActivityPageIndex = 1;
        
        [self getMyActivityInfoWithPageIndex:_currentActivityPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.activityTableView headerEndRefreshing];
            if (!error) {
                NSNumber *isResult = result[@"result"];
                
                if (isResult.integerValue == 0) {
                    NSDictionary *activityDic = result[@"resultInfo"];
                    
                    self.activityArray = activityDic[@"data"];
                    [self.activityTableView reloadData];
                    
                    NSNumber *totalNum = activityDic[@"totalPage"];
                    if (totalNum) {
                        self.totleActivityPageIndex = totalNum.integerValue;
                    }
                } else {
                    [self showHudOnlyMsg:@"未知错误"];
                }
            }else{
                [self showHudOnlyMsg:@"网络错误"];
            }
        }];
    }
    else if (_currentIndex == 2){
        self.currentBookSitePageIndex = 1;
        [self getMyBookSiteInfoWithPageIndex:_currentBookSitePageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.bookSiteTableView headerEndRefreshing];
            
            if (!error) {
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    NSDictionary *bookSiteDic = result[@"resultInfo"];
                    self.bookSiteArray = bookSiteDic[@"data"];
                    [self.bookSiteTableView reloadData];
                    
                    NSNumber *totleNum = bookSiteDic[@"totalPage"];
                    if (totleNum) {
                        self.totleBookSitePageIndex = totleNum.integerValue;
                    }
                    
                }else {
                    [self showHudOnlyMsg:@"未知错误"];
                }
            }else{
                [self showHudOnlyMsg:@"网络错误"];
            }
        }];
    }
}


- (void)footerRereshing {
    if (_currentIndex == 0){
        if (_currentCoursePageIndex < _totleCoursePageIndex) {//没加载完
            
            _currentCoursePageIndex++;
            [self getMyCourseInfoWithPageIndex:_currentCoursePageIndex WithBlock:^(NSDictionary *result, NSError *error) {
                [self.courseTableView footerEndRefreshing];
                if (!error) {
                    NSNumber *isResult = result[@"result"];
                    if (isResult.integerValue == 0) {
                        NSDictionary *courseDic = result[@"resultInfo"];
                        //NSLog(@"result:%@",result);
                        
                        [self.courseArray addObjectsFromArray:courseDic[@"data"]];
                        //NSLog(@"array:%@",self.courseArray);
                        [self.courseTableView reloadData];
                        
                        NSNumber *totalNum = courseDic[@"totalPage"];
                        if (totalNum) {
                            self.totleCoursePageIndex = totalNum.integerValue;
                        }
                    }else {
                        //[self showHudOnlyMsg:@"未知错误"];
                    }
                }else {
                    //[self showHudOnlyMsg:@"网络错误"];
                }
            }];
        }
        else {
            [_courseTableView footerEndRefreshing];
            [self showHudOnlyMsg:@"已全部加载完"];
        }
        
    }
    else if (_currentIndex == 1){
        if (_currentActivityPageIndex < _totleActivityPageIndex) {
            self.currentActivityPageIndex++;
            [self getMyActivityInfoWithPageIndex:_currentActivityPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
                [self.activityTableView footerEndRefreshing];
                
                if (!error) {
                    NSNumber *isResult = result[@"result"];
                    if (isResult.integerValue == 0) {
                        NSDictionary *activityDic = result[@"resultInfo"];
                        [self.activityArray addObjectsFromArray:activityDic[@"data"]];
                        [self.activityTableView reloadData];
                        
                        NSNumber *totleNum = activityDic[@"totalPage"];
                        if (totleNum) {
                            self.totleActivityPageIndex = totleNum.integerValue;
                        }
                    }else{
                        //[self showHudOnlyMsg:@"未知错误"];
                    }
                }else{
                    //[self showHudOnlyMsg:@"网络错误"];
                }
            }];
        }else{
            [_activityTableView footerEndRefreshing];
            [self showHudOnlyMsg:@"已全部加载完"];
        }
    }
    else if (_currentIndex == 2){
        _currentBookSitePageIndex++;
        if (_currentBookSitePageIndex < _totleBookSitePageIndex) {
            [self getMyBookSiteInfoWithPageIndex:_currentBookSitePageIndex WithBlock:^(NSDictionary *result, NSError *error) {
                [self.bookSiteTableView footerEndRefreshing];
                if (!error) {
                    NSNumber *isResult = result[@"result"];
                    if (isResult.integerValue == 0) {
                        NSDictionary *bookSiteDic = result[@"resultInfo"];
                        self.bookSiteArray = bookSiteDic[@"data"];
                        [self.bookSiteTableView reloadData];
                        
                        NSNumber *totleNum = bookSiteDic[@"totalPage"];
                        if (totleNum) {
                            self.totleBookSitePageIndex = totleNum.integerValue;
                        }
                    }else{
                        //[self showHudOnlyMsg:@"未知错误"];
                    }
                }else{
                    //[self showHudOnlyMsg:@"网络错误"];
                }
            }];
        }else{
            [_bookSiteTableView footerEndRefreshing];
            [self showHudOnlyMsg:@"已全部加载完"];
        }
    }
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.courseTableView) {
        //NSLog(@"activityArray:%li",(unsigned long)self.activityArray.count);
        return [self.courseArray count];
    }
    else if (tableView == self.activityTableView) {
        //NSLog(@"activityArray:%li",(unsigned long)self.activityArray.count);
        return [self.activityArray count];
    }
    else if (tableView == self.bookSiteTableView){
        //NSLog(@"bookSiteArray:%li",(unsigned long)self.bookSiteArray.count);
        return [self.bookSiteArray count];
    }
    else{
        return 0;
    }
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"ExpendRecordVCCell";
    static NSString *reuse2 = @"MyActivityVCCell";
    static NSString *reuse3 = @"MyBookSiteVCCell";
    static NSString *reuse4 = @"MyCell";
    
    if (tableView == self.courseTableView) {
        
        [tableView registerNib:[UINib nibWithNibName:@"ExpendRecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse1];
        
        ExpendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[ExpendRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        }
        cell.cellEdge = 10;
        cell.expendRecordInfoDic = self.courseArray[indexPath.section];
        
        return cell;
        
    }
    
    else if (tableView == self.activityTableView) {
        
        [tableView registerNib:[UINib nibWithNibName:@"MyActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
        
        MyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        if (cell == nil) {
            cell = [[MyActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
        }
        cell.cellEdge = 10;
        cell.activityinfo = self.activityArray[indexPath.section];
        
        return cell;
        
    }
    else if (tableView == self.bookSiteTableView){
        
        [tableView registerNib:[UINib nibWithNibName:@"MyBookSiteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse3];
        
        MyBookSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        
        if (cell == nil) {
            cell = [[MyBookSiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
        }
        cell.cellEdge = 10;
        cell.bookSiteInfoDic = self.bookSiteArray[indexPath.section];
        
        return cell;
        
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse4];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse4];
        }
        
        return cell;
    }
}

#pragma mark - UITableView Delegate

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.courseTableView) {
        return 190.0f;
    }
    else if (tableView == self.activityTableView) {
        return 280.0f;
    }
    else if (tableView == self.bookSiteTableView){
        return 140.0f;
    }
    else{
        return 44.0;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 5.0f;
    }

}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}


#pragma mark - LXSegmentViewThree delegate
- (void)lxSegmentViewThreeTurnTabWithCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    
    if (currentIndex == 0) {
        if (_courseArray.count == 0) {
            [self setUpRefrash:@"table1"];
        }
    }
    else if (currentIndex == 1) {
        if (_activityArray.count == 0) {
            [self setUpRefrash:@"table2"];
        }
    }
    else if (currentIndex == 2) {
        if (_bookSiteArray.count == 0) {
            [self setUpRefrash:@"table3"];
        }
    }
}

@end
