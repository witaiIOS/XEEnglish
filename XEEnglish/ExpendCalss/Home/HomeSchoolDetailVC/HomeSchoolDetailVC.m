//
//  HomeSchoolDetailVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeSchoolDetailVC.h"
#import "SchoolAdCell.h"
#import "SchoolCourseCell.h"

#import "XeeService.h"

@interface HomeSchoolDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schoolImageArray;//校区图片
@property (nonatomic, strong) NSMutableArray *courseArray;//校区课程
@end

@implementation HomeSchoolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校区介绍";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    //初始化
    self.schoolImageArray = [NSMutableArray array];
    //请求校区图片
    [self getSchoolNearbyPicListWithWeb];
    //请求校区课程
    [self getCourseListAppHomeWithWeb];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Web
- (void)getSchoolNearbyPicListWithWeb{
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getSchoolNearbyPicListWithDepartmentId:self.schoolInfoDic[@"department_id"] andPlatformTypeId:@"202" andPageSize:10 andPageIndex:1 andBolck:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.schoolImageArray = result[@"resultInfo"];
                //NSLog(@"schoolImageArray:%@",self.schoolImageArray);
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

- (void)getCourseListAppHomeWithWeb{

    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseListAppHomeWithTitle:@"" AndBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                self.courseArray = result[@"resultInfo"];
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }
        else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return _courseArray.count;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"SchoolAdCell";
    static NSString *reuse2 = @"SchoolCourseCell_identify";
    static NSString *reuse3 = @"Cell";
    
    if (indexPath.section == 0) {
        SchoolAdCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[SchoolAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        }
        cell.adArray = self.schoolImageArray;
        //NSLog(@"ad:%@",cell.adArray);
        return cell;
    }
    else if (indexPath.section == 1){
        [tableView registerNib:[UINib nibWithNibName:@"SchoolCourseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
        SchoolCourseCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuse2];
        
        cell2.courseInfo = self.courseArray[indexPath.row];
        
        return cell2;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
        }
        
        return cell;
    }
    
}
#pragma mark - UITableViewDelegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160.0f;
    }
    else if (indexPath.section == 1){
        return 120.0f;
    }
    else{
        return 44.0f;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.5f;
    }
    else{
        return 5.0f;
    }
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}

@end
