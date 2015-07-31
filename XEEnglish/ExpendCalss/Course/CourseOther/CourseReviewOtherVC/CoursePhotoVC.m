//
//  CoursePhotoVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CoursePhotoVC.h"

#import "CoursePhotoCell.h"
#import "XeeService.h"

#import "CoursePhotoLookVC.h"

@interface CoursePhotoVC ()<UITableViewDataSource, UITableViewDelegate,CoursePhotoCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *photoArray;//图片数组
@end

@implementation CoursePhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化照片数组
    self.photoArray = [NSMutableArray array];
    
    //设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //请求数据
    [self getStudentSignPhotoListWithCourseScheduleId:self.courseScheduleId andSignonId:self.signonId];
    
}

#pragma mark - Web
//查询上这节课的这个学生图片，传值signon_id 课表签到id；create_time、student_id, course_schedule_id不传值。
//查询上这节课的所有学生图片，传值course_schedule_id 课表id；create_time、student_id, signon_id不传值。
//通过student_id学员id，获取相册列表分页
- (void)getStudentSignPhotoListWithCourseScheduleId:(NSString *)course_schedule_id andSignonId:(NSString *)signon_id{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getStudentSignPhotoListWithParentId:userInfoDic[uUserId] andStudentId:@"" andSignonId:signon_id andCourseScheduleId:course_schedule_id andCreateTime:@"" andPageSize:3 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                
                NSDictionary *photoDic = result[@"resultInfo"];
                self.photoArray = photoDic[@"data"];
                //NSLog(@"array:%@",self.myPhotoArray);
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
    
    static NSString *reuse = @"CoursePhotoCell";
    
    CoursePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if(cell == nil){
        cell = [[CoursePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
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
- (void)CoursePhotoCellButtonPressed:(id)sender andRowOfCell:(NSInteger )rowOfCell{
    
    CoursePhotoButton *btn = (CoursePhotoButton *)sender;
    
    CoursePhotoLookVC *vc = [[CoursePhotoLookVC alloc] init];
    vc.photoArray = self.photoArray;
    vc.currentIndex = 3*rowOfCell+btn.tag-1;
    //NSLog(@"index:%li",vc.currentIndex);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
