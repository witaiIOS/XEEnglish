//
//  NearSchoolVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NearSchoolVC.h"
#import "NearSchoolCell.h"
#import <CoreLocation/CoreLocation.h>
#import "XeeService.h"

#import "NearSchoolDetailVC.h"

@interface NearSchoolVC ()<UITableViewDataSource, UITableViewDelegate,NearSchoolCellTakePhoneDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schoolArray;

@property (strong, nonatomic) CLLocationManager *locationManager;


@property (strong, nonatomic) CLLocation *currentLocation;//当前位置坐标

@property (nonatomic, assign) NSInteger currentSchoolPageIndex;//当前校区分页
@property (nonatomic, assign) NSInteger totalSchoolPageIndex;//校区总的分页

@end

@implementation NearSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近校区";
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.0f;
        [_locationManager startUpdatingLocation];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [_locationManager requestAlwaysAuthorization];
        }
        
        
    }
    else {
        NSLog(@"定位不可用");
    }
    
    _currentLocation = nil;
    
//    _currentSchoolPageIndex = 1;
//    _totalSchoolPageIndex = 0;
//    
//    [self setupRefresh:@"table"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.schoolArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - WebServie
/*- (void)getSchoolNearByWithLongitude:(CGFloat )longitude andLatitude:(CGFloat )latitude andPageIndex:(NSInteger )pageIndex{
    
    [[XeeService sharedInstance] getSchoolNearByWithLongitude:longitude andLatitude:latitude andPageSize:10 andPageIndex:pageIndex andBolck:^(NSDictionary *result, NSError *error) {
        //NSLog(@"getSchoolNearByResult:%@",result);
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *schoolDic = result[@"resultInfo"];
                self.schoolArray = schoolDic[@"data"];
                [self.tableView reloadData];
            }else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}*/
//- (void)getSchoolNearByWithLongitude:(CGFloat )longitude andLatitude:(CGFloat )latitude andPageIndex:(NSInteger )pageIndex andBlock:(void (^)(NSDictionary *result, NSError *error))block{
//    
//    [[XeeService sharedInstance] getSchoolNearByWithLongitude:longitude andLatitude:latitude andPageSize:10 andPageIndex:pageIndex andBolck:block];
//}



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
    
    self.currentSchoolPageIndex = 1;
    
    if (_currentLocation) {
         [[XeeService sharedInstance] getSchoolNearByWithLongitude:_currentLocation.coordinate.longitude andLatitude:_currentLocation.coordinate.latitude andPageSize:10 andPageIndex:self.currentSchoolPageIndex andBolck:^(NSDictionary *result, NSError *error) {
             [_tableView headerEndRefreshing];
             
             if (!error) {
                 //NSLog(@"result:%@",result);
                 NSNumber *isResult = result[@"result"];
                 if (isResult.integerValue == 0) {
                     NSDictionary *schoolDic = result[@"resultInfo"];
                     
                     NSMutableArray *array = [NSMutableArray array];
                     [array addObjectsFromArray:schoolDic[@"data"]];
                     
                     self.schoolArray = array;
                     
                     [self.tableView reloadData];
                     
                     NSNumber *totalNum = schoolDic[@"totalPage"];
                     if (totalNum) {
                         self.totalSchoolPageIndex = totalNum.integerValue;
                     }
                     
                 }else{
                     [UIFactory showAlert:@"未知错误"];
                 }
             }else{
                 [UIFactory showAlert:@"网络错误"];
             }
             
         }];
    }
    else {
        [_tableView headerEndRefreshing];
    }
   
    
}
- (void)footerRereshing{
    if (_currentLocation) {
        if (_currentSchoolPageIndex < _totalSchoolPageIndex) {
            _currentSchoolPageIndex++;
            [[XeeService sharedInstance] getSchoolNearByWithLongitude:_currentLocation.coordinate.longitude andLatitude:_currentLocation.coordinate.latitude andPageSize:10 andPageIndex:_currentSchoolPageIndex andBolck:^(NSDictionary *result, NSError *error) {
                
                [_tableView footerEndRefreshing];
                
                if (!error) {
                    //NSLog(@"result:%@",result);
                    NSNumber *isResult = result[@"result"];
                    if (isResult.integerValue == 0) {
                        NSDictionary *schoolDic = result[@"resultInfo"];
                        
                        [self.schoolArray addObjectsFromArray:schoolDic[@"data"]];
                        [self.tableView reloadData];
                        
                        NSNumber *totalNum = schoolDic[@"totalPage"];
                        if (totalNum) {
                            self.totalSchoolPageIndex = totalNum.integerValue;
                        }
                        
                    }else{
                        [UIFactory showAlert:@"未知错误"];
                    }
                }else{
                    [UIFactory showAlert:@"网络错误"];
                }
                
            }];
        }
        else{
            [_tableView footerEndRefreshing];
            [self showHudOnlyMsg:@"已全部加载完"];
        }
    }
    else {
        [_tableView footerEndRefreshing];
    }

}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.schoolArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"NearSchoolVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"NearSchoolCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    NearSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    cell.cellEdge = 10;
    cell.delegate = self;
    cell.schoolInfoDic = self.schoolArray[indexPath.section];//获取学校信息
    
    return cell;
}



#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NearSchoolDetailVC *vc = [[NearSchoolDetailVC alloc] init];
    vc.schoolInfoDic = self.schoolArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 3.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 240.0f;
}

#pragma mark - NearSchoolCellTakePhoneDelegate

- (void)TakePhoneBtnClicked:(id)sender{
    
    //呼叫
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",sender]]];
}

#pragma mark - CLLocation delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [_locationManager stopUpdatingLocation];
    
    // most recent is last in the list
    CLLocation *location = [locations lastObject];
    //NSLog(@"location:%f\n%f",location.coordinate.latitude,location.coordinate.longitude);
    _currentLocation = location;
    
    _currentSchoolPageIndex = 1;
    _totalSchoolPageIndex = 0;
    
    [self setupRefresh:@"table"];
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error: %@",error);
}

@end
