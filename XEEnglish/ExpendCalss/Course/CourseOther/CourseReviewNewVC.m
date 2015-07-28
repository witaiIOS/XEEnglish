//
//  CourseReviewNewVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseReviewNewVC.h"

#import "DataIsNullCell.h"
#import "CourseCommentCell.h"
#import "photoCell.h"

#import "XeeService.h"

@interface CourseReviewNewVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *myCommentArray;//我的评价
@property (nonatomic, strong) NSMutableArray *otherCommentArray;//其他评价
@property (nonatomic, strong) NSMutableArray *myPhotoArray;//我的照片
@property (nonatomic, strong) NSMutableArray *otherPhotoArray;//其他照片

@end

@implementation CourseReviewNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程回顾";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setFrame:CGRectMake(kScreenWidth-60, 17, 40, 30)];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *commentBarBtn = [[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    self.navigationItem.rightBarButtonItem = commentBarBtn;
    
    
    //初始化数组
    self.myCommentArray = [NSMutableArray array];
    self.otherCommentArray = [NSMutableArray array];
    self.myPhotoArray = [NSMutableArray array];
    self.otherPhotoArray = [NSMutableArray array];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.view addSubview:self.tableview];

    //获取我的评论
    [self getCourseScheduleSignParentCommentWithCourseScheduleId:@"" andSignonId:self.courseLeaveInfoDic[@"signon_id"]];
    //获取其他评论
    [self getCourseScheduleSignParentCommentWithCourseScheduleId:self.courseLeaveInfoDic[@"course_schedule_id"] andSignonId:@""];
    //查询上这节课的这个学生图片，传值signon_id 课表签到id；create_time、student_id, course_schedule_id不传值。
    [self getStudentSignPhotoListWithCourseScheduleId:@"" andSignonId:self.courseLeaveInfoDic[@"signon_id"]];
    //查询上这节课的所有学生图片，传值course_schedule_id 课表id；create_time、student_id, signon_id不传值。
    [self getStudentSignPhotoListWithCourseScheduleId:self.courseLeaveInfoDic[@"course_schedule_id"] andSignonId:@""];
}

#pragma mark - comment
- (void)commentBtnClicked{
    
}

#pragma mark - Web
- (void)getCourseScheduleSignParentCommentWithCourseScheduleId:(NSString *)course_schedule_id andSignonId:(NSString *)signon_id {
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getCourseScheduleSignParentCommentWithParentId:userInfoDic[uUserId] andCourseScheduleId:course_schedule_id andPageSize:5 andPageIndex:1 andSignonId:signon_id andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //查询这节课老师和家长的评论，传值signon_id课表签到id，course_schedule_id不传值。
                if ([course_schedule_id isEqualToString:@""]) {
                    NSDictionary *commentDic = result[@"resultInfo"];
                    self.myCommentArray = commentDic[@"data"];
                    //NSLog(@"array:%@",self.myCommentArray);
                    [self.tableview reloadData];
                }
                else{
                    NSDictionary *commentDic = result[@"resultInfo"];
                    self.otherCommentArray = commentDic[@"data"];
                    [self.tableview reloadData];
                }
            }
        }
        
    }];
}

//查询上这节课的这个学生图片，传值signon_id 课表签到id；create_time、student_id, course_schedule_id不传值。
//查询上这节课的所有学生图片，传值course_schedule_id 课表id；create_time、student_id, signon_id不传值。
//通过student_id学员id，获取相册列表分页
- (void)getStudentSignPhotoListWithCourseScheduleId:(NSString *)course_schedule_id andSignonId:(NSString *)signon_id{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getStudentSignPhotoListWithParentId:userInfoDic[uUserId] andStudentId:@"" andSignonId:signon_id andCreateTime:@"" andPageSize:3 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //查询这节课老师和家长的评论，传值signon_id课表签到id，course_schedule_id不传值。
                if ([course_schedule_id isEqualToString:@""]) {
                    NSDictionary *photoDic = result[@"resultInfo"];
                    self.myPhotoArray = photoDic[@"data"];
                    //NSLog(@"array:%@",self.myPhotoArray);
                    [self.tableview reloadData];
                }
                else{
                    NSDictionary *photoDic = result[@"resultInfo"];
                    self.otherPhotoArray = photoDic[@"data"];
                    [self.tableview reloadData];
                }
            }else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableViewDelegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.myCommentArray count] == 0) {
            return 1;
        }
        else{
            return [self.myCommentArray count];
        }
    }
    else if (section == 1){
        if ([self.otherCommentArray count] == 0) {
            return 1;
        }
        else{
            return [self.otherCommentArray count];
        }
    }
    else if (section == 2){
        if ([self.myPhotoArray count] == 0) {
            return 1;
        }
        else{
            return (self.myPhotoArray.count+2)/3;
        }
    }
    else{
        if ([self.otherPhotoArray count] == 0) {
            return 1;
        }
        else{
            return (self.otherPhotoArray.count+2)/3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"DataIsNullCell";
    static NSString *reuse2 = @"CourseCommentVCCell";
    static NSString *reuse3 = @"photoCell";
    
    if (indexPath.section == 0) {
        if ([self.myCommentArray count] == 0) {
            DataIsNullCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
            if (cell == nil) {
                cell = [[DataIsNullCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            }
            cell.cellEdge = 10;
            cell.tipLabel.text = @"暂无评论";
            return cell;
        }
        else{
            [tableView registerNib:[UINib nibWithNibName:@"CourseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
            CourseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
            cell.cellEdge = 10;
            cell.commentInfoDic = self.myCommentArray[indexPath.row];
            //NSLog(@"cell:%@",cell.commentInfoDic);
            //NSLog(@"myCommentArray:%@",self.myCommentArray[indexPath.row]);
            
            return cell;
        }
    }
    else if (indexPath.section == 1) {
        if ([self.otherCommentArray count] == 0) {
            DataIsNullCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
            if (cell == nil) {
                cell = [[DataIsNullCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            }
            cell.cellEdge = 10;
            cell.tipLabel.text = @"暂无评论";
            return cell;
        }
        else{
            [tableView registerNib:[UINib nibWithNibName:@"CourseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
            
            CourseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
            cell.cellEdge = 10;
            cell.commentInfoDic = self.otherCommentArray[indexPath.row];
            
            return cell;
        }
    }
    else if (indexPath.section == 2) {
        if ([self.myPhotoArray count] == 0) {
            DataIsNullCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
            if (cell == nil) {
                cell = [[DataIsNullCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            }
            cell.cellEdge = 10;
            cell.tipLabel.text = @"暂无相关照片";
            return cell;
        }
        else{
            photoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
            if (cell == nil) {
                cell = [[photoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            }
            cell.cellEdge = 10;
            cell.photoArray = self.myPhotoArray;
            //NSLog(@"array:%@",self.myPhotoArray);
            //NSLog(@"cell:%@",cell.photoArray);
            return cell;
        }
    }
    else{
        if ([self.otherPhotoArray count] == 0) {
            DataIsNullCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
            if (cell == nil) {
                cell = [[DataIsNullCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
            }
            cell.cellEdge = 10;
            cell.tipLabel.text = @"暂无相关照片";
            return cell;
        }
        else{
            photoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
            if (cell == nil) {
                cell = [[photoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            }
            cell.cellEdge = 10;
            cell.photoArray = self.otherPhotoArray;
            //NSLog(@"array:%@",self.otherPhotoArray);
            //NSLog(@"cell:%@",cell.photoArray);
            
            return cell;
        }
    }
    
}

#pragma mark - UITableViewDataSource

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if ([self.myCommentArray count] == 0) {
            return 44.0f;
        }
        else{
            return 80.0f;
        }
    }
    else if (indexPath.section == 1){
        if ([self.otherCommentArray count] == 0) {
            return 44.0f;
        }
        else{
            return 80.0f;
        }
    }
    else if (indexPath.section == 2){
        if ([self.myPhotoArray count] == 0) {
            return 44.0f;
        }
        else{
            return 120.0f;
        }
    }
    else{
        if ([self.otherPhotoArray count] == 0) {
            return 44.0f;
        }
        else{
            return 120.0f;
        }
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 2, kScreenWidth-20, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor blackColor];
    [view addSubview:tipLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-120, 10, 100, 20)];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:detailLabel];
    
    if (section == 0) {
        tipLabel.text = @"我的评论";
        detailLabel.text = @"历史聊天";
    }
    else if (section == 1){
        tipLabel.text = @"其他评论";
        detailLabel.text = @"全部评论";
    }
    else if (section == 2){
        tipLabel.text = @"我的照片";
        detailLabel.text = @"全部照片";
    }
    else{
        tipLabel.text = @"其他照片";
        detailLabel.text = @"全部照片";
    }
    
    return view;
}


@end
