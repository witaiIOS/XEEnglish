//
//  CourseCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseCommentVC.h"
#import "CourseCommentCell.h"

#import "CourseMyCommentVC.h"

#import "XeeService.h"

@interface CourseCommentVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UILabel *courseNameLabel;
@property (nonatomic, strong) NSMutableArray *commentArray;//评论数组

@property (nonatomic, assign) NSInteger currentCommentPageIndex;//当前评论页
@property (nonatomic, assign) NSInteger totalCOmmentPageIndex;//评论总页数


@end

@implementation CourseCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"累计评论";
    
    _currentCommentPageIndex = 1;
    _totalCOmmentPageIndex = 0;
    
    //[self setupRefresh:@"table"];
}

- (void)initUI{
    
    [super initUI];
    //设置页面的头和尾
    [self setHeadViewAndFootView];
    //初始化评论数组
    self.commentArray = [[NSMutableArray alloc] init];
    //网络请求评论数据
    [self getCourseScheduleSignParentCommentWithWeb];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, kScreenWidth, kScreenHeight-64-30-30) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)setHeadViewAndFootView{
    //页面上端课名
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
    headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headView];
    
    UILabel *courseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, kScreenWidth-20, 24)];
    courseNameLabel.text = self.courseLeaveInfoDic[@"title"];
    courseNameLabel.font = [UIFont systemFontOfSize:14];
    courseNameLabel.textAlignment = NSTextAlignmentCenter;
    courseNameLabel.textColor = [UIColor lightGrayColor];
    courseNameLabel.backgroundColor = [UIColor whiteColor];
    
    [headView addSubview:courseNameLabel];
    
    //页面下端评论按钮
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 30)];
    footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footView];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commentBtn setFrame:CGRectMake(10, 3, kScreenWidth-20, 24)];
    [commentBtn setTitle:@"评论点什么吧" forState:UIControlStateNormal];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [commentBtn setBackgroundColor:[UIColor whiteColor]];
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:commentBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commentBtnClicked{
    CourseMyCommentVC *vc = [[CourseMyCommentVC alloc] init];
    vc.courseInfoDic = self.courseLeaveInfoDic;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getCourseScheduleSignParentCommentWithWeb{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"courseInfo:%@",self.courseLeaveInfoDic);
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseScheduleSignParentCommentWithParentId:userInfoDic[uUserId] andCourseScheduleId:self.courseLeaveInfoDic[@"course_schedule_id"] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.commentArray = result[@"resultInfo"];
                //NSLog(@"commentArray:%@",self.commentArray);
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}
//- (void)getCourseScheduleSignParentCommentWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
//    
//    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
//    NSDictionary *userInfoDic = userDic[uUserInfoKey];
//    //NSLog(@"courseInfo:%@",self.courseLeaveInfoDic);
//    
//    //[self showHudWithMsg:@"载入中..."];
//    [[XeeService sharedInstance] getCourseScheduleSignParentCommentWithParentId:userInfoDic[uUserId] andCourseScheduleId:self.courseLeaveInfoDic[@"course_schedule_id"] andToken:userInfoDic[uUserToken] andBlock:block];
//}
//
//
///**
// *  集成刷新控件
// */
//- (void)setupRefresh:(NSString *)dateKey
//{
//    
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
//    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
//    //#warning 自动刷新(一进入程序就下拉刷新)
//    [_tableView headerBeginRefreshing];
//    
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    _tableView.headerPullToRefreshText = @"下拉可以刷新";
//    _tableView.headerReleaseToRefreshText = @"松开马上刷新";
//    _tableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
//    
//    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
//    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
//    _tableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
//    
//}
//
//- (void)headerRereshing{
//    self.currentCommentPageIndex = 1;
//    
//    [self getCourseScheduleSignParentCommentWithPageIndex:_currentCommentPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
//        [self.tableView headerEndRefreshing];
//        
//        if (!error) {
//            //NSLog(@"result:%@",result);
//            NSNumber *isResult = result[@"result"];
//            if (isResult.integerValue == 0) {
//                NSDictionary *commentInfo = result[@"resultInfo"];
//                
//                NSMutableArray *array = [NSMutableArray array];
//                [array addObjectsFromArray:commentInfo[@"data"]];
//                
//                self.commentArray = array;
//                [self.tableView reloadData];
//                
//                NSNumber *totalNum = commentInfo[@"totalPage"];
//                if (totalNum) {
//                    self.totalCOmmentPageIndex = totalNum.integerValue;
//                }
//            }else{
//                [self showHudOnlyMsg:@"未知错误"];
//            }
//        }else{
//            [self showHudOnlyMsg:@"网络错误"];
//        }
//    }];
//}
//
//- (void)footerRereshing{
//    
//    if (_currentCommentPageIndex < _totalCOmmentPageIndex) {
//        _currentCommentPageIndex++;
//        
//        [self getCourseScheduleSignParentCommentWithPageIndex:_currentCommentPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
//            [self.tableView footerEndRefreshing];
//            
//            if (!error) {
//                //NSLog(@"result:%@",result);
//                NSNumber *isResult = result[@"result"];
//                if (isResult.integerValue == 0) {
//                    NSDictionary *commentInfo = result[@"resultInfo"];
//                    
//                    [self.commentArray addObjectsFromArray:commentInfo[@"data"]];
//                    
//                    [self.tableView reloadData];
//                    
//                    NSNumber *totalNum = commentInfo[@"totalPage"];
//                    if (totalNum) {
//                        self.totalCOmmentPageIndex = totalNum.integerValue;
//                    }
//                }else{
//                    [self showHudOnlyMsg:@"未知错误"];
//                }
//            }else{
//                [self showHudOnlyMsg:@"网络错误"];
//            }
//        }];
//    }else{
//        [self.tableView footerEndRefreshing];
//        [self showHudOnlyMsg:@"已全部加载完"];
//    }
//    
//}


#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"count:%li",self.commentArray.count);
    return [self.commentArray count];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CourseCommentVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"CourseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    CourseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
//    if (cell == nil) {
//        cell = [[CourseCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
//    }
    
    cell.cellEdge = 10;
    cell.commentInfoDic = self.commentArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5.0f;
    }
    else{
        return 1.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
}


@end
