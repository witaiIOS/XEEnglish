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

@interface PhotoInTheMonthVC ()<UITableViewDataSource,UITableViewDelegate,PhotoInTheMonthCellDelegate>
@property (nonatomic, strong) UITableView *tableView;//图片tableView
@property (nonatomic, strong) NSMutableArray *photoArray;//图片数组

@end

@implementation PhotoInTheMonthVC

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
    
    //初始化数组
    self.photoArray = [NSMutableArray array];
    
    //设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //请求网络数据
    [self getStudentSignPhotoListWithWeb];
}

#pragma mark - Web
//查询单个学生所有的图片，传值student_id；，create_time传值为相册的日期，如： "2015-7-22"；signon_id, course_schedule_id不传值
- (void)getStudentSignPhotoListWithWeb{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getStudentSignPhotoListWithParentId:userInfoDic[uUserId] andStudentId:@"" andSignonId:@"" andCourseScheduleId:@"" andCreateTime:@"" andPageSize:10 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                
                NSDictionary *photoDic = result[@"resultInfo"];
                self.photoArray = photoDic[@"data"];
                //NSLog(@"array:%@",self.photoArray);
                [self.tableView reloadData];
                
            }else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
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
    cell.serviceDic1 = [_photoArray objectAtIndex:3*(indexPath.row)];
    
    if ( (3*(indexPath.row)+1) < _photoArray.count) {
        cell.serviceDic2 = [_photoArray objectAtIndex:3*(indexPath.row)+1];
        
        if ( (3*(indexPath.row)+2) < _photoArray.count) {
            cell.serviceDic3 = [_photoArray objectAtIndex:3*(indexPath.row)+2];
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
- (void)PhotoInTheMonthCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic{
    
}

@end
