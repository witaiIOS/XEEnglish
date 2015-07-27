//
//  PayListeningCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PayListeningCourseVC.h"
#import "PayListeningCourseVCCell.h"

#import "XeeService.h"

@interface PayListeningCourseVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *courseArray;

@end

@implementation PayListeningCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择课程";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //初始化数组
    self.courseArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self getCourseListByFilter];
}

#pragma mark - Web2
- (void)getCourseListByFilter{
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseListByFilterWithMinAge:@"" andMaxAge:@"" andCourseCategoryId:@"" andSort:@"" andOrder:@"" andPageSize:10 andPageIndex:1 andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"所有课程:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *allCourseDic = result[@"resultInfo"];
                self.courseArray = allCourseDic[@"data"];
                //NSLog(@"11111:%@",self.requestCourseInfo);
                
//                self.tableView.dataSource = self;
//                self.tableView.delegate = self;
                
                [self.tableView reloadData];
            }
        }
    }];
}


#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.courseArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"PayListeningCourseVCCell";
    
    PayListeningCourseVCCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[PayListeningCourseVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.courseNameLabel.text = [self.courseArray[indexPath.section] objectForKey:@"title"];
    if ([self.selectCourse isEqualToString:cell.courseNameLabel.text]) {
        cell.selectImageView.highlighted = YES;
    }
    
    return cell;
}
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *courseInfoDic = @{@"title":[self.courseArray[indexPath.section] objectForKey:@"title"],@"course_id":[self.courseArray[indexPath.section] objectForKey:@"course_id"]};
    [self.delegate payListeningCourseVCSelectedCourse:courseInfoDic];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
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

@end
