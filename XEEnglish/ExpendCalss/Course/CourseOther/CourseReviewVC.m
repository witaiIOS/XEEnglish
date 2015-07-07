//
//  CourseReviewVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseReviewVC.h"
#import "CourseReviewCell.h"
#import "XeeService.h"

@interface CourseReviewVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *coursePhotosArray;

@end

@implementation CourseReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程回顾";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    [self getPhotoByCourseScheduleId];
    
    //NSLog(@"course:%@",self.courseLeaveInfoDic);
    self.coursePhotosArray = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-60) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setFrame:CGRectMake(kScreenWidth/2+20, 10, kScreenWidth/2-40, 40)];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentBtn setBackgroundColor:[UIColor orangeColor]];
    commentBtn.layer.cornerRadius = 4.0f;
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:commentBtn];
    
}


#pragma mark - My Action

- (void)commentBtnClicked{
    
    //    BuyCourseVC *vc = [[BuyCourseVC alloc] init];
    //    vc.courseName = self.title;
    //    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getPhotoByCourseScheduleId{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    //NSLog(@"courseInfo:%@",self.courseLeaveInfoDic);
    NSString *courseScheduleId = self.courseLeaveInfoDic[@"course_schedule_id"];
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getPhotoByCourseScheduleIdWithParentId:userInfoDic[uUserId] andOwnerId:@"2362" andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            
            if (isResult.integerValue == 0) {
                self.coursePhotosArray = result[@"resultInfo"];
                //NSLog(@"info:%@",self.coursePhotosArray);
                [self.tableView reloadData];
            }
        }
    }];
    
    
}



#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.coursePhotosArray.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CourseReviewVCCell";
    
    CourseReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[CourseReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.coursePhotoDic = self.coursePhotosArray[indexPath.section];
    NSLog(@"dic:%@",cell.coursePhotoDic);
    return cell;
}


#pragma mark - UITableView Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180.0f;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}


@end
