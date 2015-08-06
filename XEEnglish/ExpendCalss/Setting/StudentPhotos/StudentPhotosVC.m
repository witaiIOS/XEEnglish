//
//  StudentPhotosVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "StudentPhotosVC.h"
#import "PhotoMonthCell.h"

#import "XeeService.h"

#import "PhotoInTheMonthVC.h"

@interface StudentPhotosVC ()<UITableViewDataSource, UITableViewDelegate,PhotoMonthCellDelegate>

//@property (nonatomic, strong) DropDown *tabButton;
@property (strong, nonatomic) DropButton *dropButton;
@property (strong, nonatomic) UITableView *dropTableView;
@property (strong, nonatomic) NSArray *dropTableList;

@property (nonatomic, assign) BOOL showList;


@property (nonatomic, strong) NSString *studentId;//学生id
@property (nonatomic, strong) UITableView *photoTableView;//图像tableView
@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, assign) NSInteger currentPhotoPageIndex;//当前评论页
@property (nonatomic, assign) NSInteger totalPhotoPageIndex;//评论总页数

@end


@implementation StudentPhotosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宝宝相册";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   /* NSArray *array = [[UserStudent sharedUser] getUserStudentArray];
    //NSLog(@"array:%@",array);
    self.tabButton = [[DropDown alloc] initWithFrame:CGRectMake(kScreenWidth-80, 14, 70, 35*array.count+40)];
    //self.mydd.textField.placeholder = @"请输入联系方式";
    self.tabButton.tableArray = array;
    [self.tabButton.tabBtn setTitle:[array[0] objectForKey:@"name"] forState:UIControlStateNormal];
    
    UIBarButtonItem *tabBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.tabButton];
    self.navigationItem.rightBarButtonItem = tabBarButton;*/
    
    
    _dropTableList = [[UserStudent sharedUser] getUserStudentArray];
    
    /*********************************dropButton***********************************/
    _dropButton = [DropButton buttonWithType:UIButtonTypeCustom];
    [_dropButton setFrame:CGRectMake(0, 2, 70, 40)];
    [_dropButton setImage:[UIImage imageNamed:@"ic_arrow_down_black.png"] forState:UIControlStateNormal];
    [_dropButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
    if (_dropTableList.count > 0) {
        [_dropButton setTitle:[_dropTableList[0] objectForKey:@"name"] forState:UIControlStateNormal];
    }
    else{
        [_dropButton setTitle:@"无学生" forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *tabBarButton = [[UIBarButtonItem alloc] initWithCustomView:_dropButton];
    self.navigationItem.rightBarButtonItem = tabBarButton;
    
    /*********************************dropTableView***********************************/
    _dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 0) style:UITableViewStyleGrouped];
    _dropTableView.delegate = self;
    _dropTableView.dataSource = self;
    _dropTableView.backgroundColor = [UIColor clearColor];
    _dropTableView.separatorColor = [UIColor lightGrayColor];
    _dropTableView.hidden = YES;
    [self.view addSubview:_dropTableView];
    if (_dropTableList.count > 0){
        //初始化学生id
        self.studentId = [_dropTableList[0] objectForKey:@"student_id"];
        //NSLog(@"studentId:%@",self.studentId);
    }

    //初始化照片数组
    self.photoArray = [NSMutableArray array];
    
    //设置照片tableView
    self.photoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.photoTableView.dataSource = self;
    self.photoTableView.delegate = self;
    
    [self.view addSubview:self.photoTableView];
    
    //请求数据
    //[self getPhotoGroupListByStudentIdWithWeb];
    
    _currentPhotoPageIndex = 1;
    _totalPhotoPageIndex = 0;
    
    [self setupRefresh:@"table"];

}

#pragma mark - action
- (void)dropdown {
    if (self.showList) {
        return;
    }
    else{
        [self.view bringSubviewToFront:self.dropTableView];
        _dropTableView.hidden = NO;
        self.showList = YES;
        
        CGRect frame = _dropTableView.frame;
        //frame.size.height = 0;//看着没用
        //self.tableView.frame = frame;//看着没用
        frame.size.height = kScreenHeight-64;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];//UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画曲线，控制动画速度
    
        _dropTableView.frame = frame;
        [UIView commitAnimations];//提交动画
    }

}

#pragma mark - tableView datasouce delegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.dropTableView) {
        return 1;
    }
    else if (tableView == self.photoTableView){
        return (_photoArray.count+2)/3;
    }
    else{
        return 0;
    }
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.dropTableView) {
        return _dropTableList.count;
    }
    else if (tableView == self.photoTableView){
        return 1;
    }
    else{
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"Cell";
    static NSString *reuse2 = @"PhotoMonthCell";
    static NSString *reuse3 = @"Cell";
    
    if (tableView == self.dropTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            cell.accessoryType = UITableViewCellAccessoryNone;
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        if (_dropTableList.count > 0) {
            NSDictionary *dic = [_dropTableList objectAtIndex:[indexPath row]];
            
            cell.textLabel.text = dic[@"name"];
        }
        
        
        return cell;
    }
    else if (tableView == self.photoTableView){
        
        PhotoMonthCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuse2];
        if(cell2 == nil){
            cell2 = [[PhotoMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
        }
        cell2.delegate = self;
        cell2.cellEdge = 10;
        cell2.serviceDic1 = [_photoArray objectAtIndex:3*(indexPath.section)];
        
        if ( (3*(indexPath.section)+1) < _photoArray.count) {
            cell2.serviceDic2 = [_photoArray objectAtIndex:3*(indexPath.section)+1];
            
            if ( (3*(indexPath.section)+2) < _photoArray.count) {
                cell2.serviceDic3 = [_photoArray objectAtIndex:3*(indexPath.section)+2];
            }
            else{
                cell2.serviceDic3 = nil;
            }
        }
        else{
            cell2.serviceDic2 = nil;
        }
        
        return cell2;
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.dropTableView) {
        return 35.0f;
    }
    else if (tableView == self.photoTableView){
        
        return 150.0f;
    }
    else{
        return 0.0f;
    }
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.dropTableView) {
        NSDictionary *dic = [_dropTableList objectAtIndex:[indexPath row]];
        
        [_dropButton setTitle:dic[@"name"] forState:UIControlStateNormal];
        self.studentId = dic[@"student_id"];
        self.showList = NO;
        _dropTableView.hidden =YES;
        
        CGRect frame = _dropTableView.frame;
        frame.size.height = 0;
        _dropTableView.frame = frame;
        
        //刷新数据
        //[self getPhotoGroupListByStudentIdWithWeb];
        
        //切换用户，重新请求数据，都置为初始值
        _currentPhotoPageIndex = 1;
        _totalPhotoPageIndex = 0;
        
        [self setupRefresh:@"table"];
        
        [self.photoTableView reloadData];
    }
    else if (tableView == self.photoTableView){
        
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.dropTableView) {
        return 1.0f;
    }
    else if (tableView == self.photoTableView){
        if (section == 0) {
            return 5.0f;
        }
        else{
            return 1.0f;
        }
    }
    else{
        return 0.01f;
    }
}

#pragma mark - Web

//- (void)getPhotoGroupListByStudentIdWithWeb{
//    
//    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
//    NSDictionary *userInfoDic = userDic[uUserInfoKey];
//    
//    [self showHudWithMsg:@"载入中..."];
//    [[XeeService sharedInstance] getPhotoGroupListByStudentIdWithParentId:userInfoDic[uUserId] andStudentId:self.studentId andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
//        [self hideHud];
//        
//        if (!error) {
//            NSNumber *isResilt = result[@"result"];
//            if (isResilt.integerValue == 0) {
//                NSDictionary *photoDic = result[@"resultInfo"];
//                self.photoArray = photoDic[@"data"];
//                //NSLog(@"photoArray:%@",self.photoArray);
//                [self.photoTableView reloadData];
//            }else{
//                [UIFactory showAlert:@"未知错误"];
//            }
//        }else{
//            [UIFactory showAlert:@"网络错误"];
//        }
//    }];
//}
- (void)getPhotoGroupListByStudentIdWithPageIndex:(NSInteger)pageIndex WithBlock:(void (^)(NSDictionary *result, NSError *error))block{

    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];

    //[self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getPhotoGroupListByStudentIdWithParentId:userInfoDic[uUserId] andStudentId:self.studentId andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:block];
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
    [_photoTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [_photoTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_photoTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _photoTableView.headerPullToRefreshText = @"下拉可以刷新";
    _photoTableView.headerReleaseToRefreshText = @"松开马上刷新";
    _photoTableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
    
    _photoTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _photoTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    _photoTableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
    
}

- (void)headerRereshing{
    self.currentPhotoPageIndex = 1;
    //[self showHudWithMsg:@"载入中..."];
    [self getPhotoGroupListByStudentIdWithPageIndex:_currentPhotoPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
        [self.photoTableView headerEndRefreshing];
        //[self hideHud];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *photoDic = result[@"resultInfo"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:photoDic[@"data"]];
                
                self.photoArray = array;
                [self.photoTableView reloadData];
                
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
        [self getPhotoGroupListByStudentIdWithPageIndex:_currentPhotoPageIndex WithBlock:^(NSDictionary *result, NSError *error) {
            [self.photoTableView footerEndRefreshing];
            //[self hideHud];
            
            if (!error) {
                //NSLog(@"result:%@",result);
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    NSDictionary *photoDic = result[@"resultInfo"];
                    
                    [self.photoArray addObjectsFromArray:photoDic[@"data"]];
                    
                    [self.photoTableView reloadData];
                    
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
        [self.photoTableView footerEndRefreshing];
        [self showHudOnlyMsg:@"已全部加载完"];
    }
    
}

#pragma mark - PhotoMonthCellDelegate
- (void)PhotoMonthCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic{
    
    PhotoInTheMonthVC *vc = [[PhotoInTheMonthVC alloc] init];
    vc.photoInfoDic = serviceDic;
    vc.studentId = self.studentId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
