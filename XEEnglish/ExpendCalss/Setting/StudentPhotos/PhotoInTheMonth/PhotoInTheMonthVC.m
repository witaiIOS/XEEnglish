//
//  PhotoInTheMonthVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PhotoInTheMonthVC.h"

#import "PhotoInTheMonthCell.h"

#import "XeeService.h"
#import "PhotoLookVC.h"

@interface PhotoInTheMonthVC ()<UITableViewDataSource,UITableViewDelegate,PhotoInTheMonthCellDelegate>
@property (nonatomic, strong) UITableView *tableView;//图片tableView
@property (nonatomic, strong) NSMutableArray *photoArray;//图片数组

@property (nonatomic, assign) NSInteger currentPhotoPageIndex;//当前评论页
@property (nonatomic, assign) NSInteger totalPhotoPageIndex;//评论总页数
@end

@implementation PhotoInTheMonthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宝宝相册";
    
    _currentPhotoPageIndex = 1;
    _totalPhotoPageIndex = 0;
    
    [self setupRefresh:@"table"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化数组
    self.photoArray = [NSMutableArray array];
    
    //设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //请求网络数据
    //[self getStudentSignPhotoListWithWeb];
}

#pragma mark - Web
//查询单个学生所有的图片，传值student_id；，create_time传值为相册的日期，如： "2015-7-22"；signon_id, course_schedule_id不传值
//- (void)getStudentSignPhotoListWithWeb{
//    
//    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
//    NSDictionary *userInfoDic = userDic[uUserInfoKey];
//    
//    [self showHudWithMsg:@"加载中..."];
//    [[XeeService sharedInstance] getStudentSignPhotoListWithParentId:userInfoDic[uUserId] andStudentId:@"" andSignonId:@"" andCourseScheduleId:@"" andCreateTime:@"" andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
//        [self hideHud];
//        
//        if (!error) {
//            //NSLog(@"result:%@",result);
//            NSNumber *isResult = result[@"result"];
//            if (isResult.integerValue == 0) {
//                
//                NSDictionary *photoDic = result[@"resultInfo"];
//                self.photoArray = photoDic[@"data"];
//                //NSLog(@"array:%@",self.photoArray);
//                //NSLog(@"count:%li",self.photoArray.count);
//                [self.tableView reloadData];
//                
//            }else{
//                [UIFactory showAlert:result[@"resultInfo"]];
//            }
//        }else{
//            [UIFactory showAlert:@"网络错误"];
//        }
//    }];
//}
- (void)getStudentSignPhotoListWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    //[self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getStudentSignPhotoListWithParentId:userInfoDic[uUserId] andStudentId:@"" andSignonId:@"" andCourseScheduleId:@"" andCreateTime:@"" andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:block];
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
    self.currentPhotoPageIndex = 1;
    //[self showHudWithMsg:@"载入中..."];
    [self getStudentSignPhotoListWithPageIndex:_currentPhotoPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
        [self.tableView headerEndRefreshing];
        //[self hideHud];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *photoDic = result[@"resultInfo"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:photoDic[@"data"]];
                
                self.photoArray = array;
                [self.tableView reloadData];
                
                NSNumber *totalNum = photoDic[@"totalPage"];
                if (totalNum) {
                    self.totalPhotoPageIndex = totalNum.integerValue;
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
    
    if (_currentPhotoPageIndex < _totalPhotoPageIndex) {
        _currentPhotoPageIndex++;
        //[self showHudWithMsg:@"载入中..."];
        [self getStudentSignPhotoListWithPageIndex:_currentPhotoPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.tableView footerEndRefreshing];
            //[self hideHud];
            
            if (!error) {
                //NSLog(@"result:%@",result);
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    NSDictionary *photoDic = result[@"resultInfo"];
                    
                    [self.photoArray addObjectsFromArray:photoDic[@"data"]];
                    
                    [self.tableView reloadData];
                    
                    NSNumber *totalNum = photoDic[@"totalPage"];
                    if (totalNum) {
                        self.totalPhotoPageIndex = totalNum.integerValue;
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

#pragma mark - tableView datasouce delegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return (_photoArray.count+2)/3;;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"PhotoInTheMonthCell";

    PhotoInTheMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if(cell == nil){
        cell = [[PhotoInTheMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.delegate = self;
    cell.cellEdge = 10;
    cell.rowOfCell = indexPath.section;
    cell.serviceDic1 = [_photoArray objectAtIndex:3*(indexPath.section)];
    
    if ( (3*(indexPath.section)+1) < _photoArray.count) {
        cell.serviceDic2 = [_photoArray objectAtIndex:3*(indexPath.section)+1];
        
        if ( (3*(indexPath.section)+2) < _photoArray.count) {
            cell.serviceDic3 = [_photoArray objectAtIndex:3*(indexPath.section)+2];
        }
        else{
            cell.serviceDic3 = nil;
        }
    }
    else{
        cell.serviceDic2 = nil;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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

#pragma mark - PhotoInTheMonthCellDelegate
- (void)PhotoInTheMonthCellButtonPressed:(id)sender andRowOfCell:(NSInteger )rowOfCell{
    
    PhotoInTheMonthButton *btn = (PhotoInTheMonthButton *)sender;
    
    PhotoLookVC *vc = [[PhotoLookVC alloc] init];
    vc.photoArray = self.photoArray;
    vc.currentIndex = 3*rowOfCell+btn.tag-1;
    //NSLog(@"index:%li",vc.currentIndex);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
