//
//  SingleCourseCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SingleCourseCommentVC.h"

#import "CourseCommentCell.h"

#import "XeeService.h"

@interface SingleCourseCommentVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;//评论数组

@property (nonatomic, assign) NSInteger currentCommentPageIndex;//当前评论页
@property (nonatomic, assign) NSInteger totalCOmmentPageIndex;//评论总页数

@end

@implementation SingleCourseCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"累计评论";
    
    _currentCommentPageIndex = 1;
    _totalCOmmentPageIndex = 0;
    
    [self setupRefresh:@"table"];
}

- (void)initUI{
    
    [super initUI];
    //初始化评论数组
    self.commentArray = [[NSMutableArray alloc] init];
    
    //获取网络评价
    //[self getCourseParentCommentWithWeb];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web
/*- (void)getCourseParentCommentWithWeb{
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseParentCommentByCourseId:self.courseInfoDic[@"course_id"] andPageSize:10 andPageIndex:1 andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *commentInfo = result[@"resultInfo"];
                self.commentArray = commentInfo[@"data"];
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}*/

- (void)getCourseParentCommentWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    //[self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseParentCommentByCourseId:self.courseInfoDic[@"course_id"] andPageSize:10 andPageIndex:pageIndex andBlock:block];
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
    self.currentCommentPageIndex = 1;
    
    [self getCourseParentCommentWithPageIndex:_currentCommentPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
        [self.tableView headerEndRefreshing];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *commentInfo = result[@"resultInfo"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:commentInfo[@"data"]];
                
                self.commentArray = array;
                [self.tableView reloadData];
                
                NSNumber *totalNum = commentInfo[@"totalPage"];
                if (totalNum) {
                    self.totalCOmmentPageIndex = totalNum.integerValue;
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
    
    if (_currentCommentPageIndex < _totalCOmmentPageIndex) {
        _currentCommentPageIndex++;
        
        [self getCourseParentCommentWithPageIndex:_currentCommentPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.tableView footerEndRefreshing];
            
            if (!error) {
                //NSLog(@"result:%@",result);
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    NSDictionary *commentInfo = result[@"resultInfo"];
                    
                    [self.commentArray addObjectsFromArray:commentInfo[@"data"]];
                    
                    [self.tableView reloadData];
                    
                    NSNumber *totalNum = commentInfo[@"totalPage"];
                    if (totalNum) {
                        self.totalCOmmentPageIndex = totalNum.integerValue;
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
