//
//  Course.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseVC.h"
#import "CourseCell.h"
//#import "DropList.h"
#import "JSDropDownMenu.h"

#import "CourseLeaveVC.h"
#import "CourseAbsentVC.h"

#import "XeeService.h"

#import "CourseLeaveApplyVC.h"  //请假申请页面
//#import "CourseReviewVC.h"      //cell中已完成课程跳转到课程回顾
#import "CourseReviewNewVC.h"
#import "CourseForenoticeVC.h"  //cell中未完成课程跳转到课程预告
//#import "CourseCommentVC.h"     //评论页面
#import "CommentVC.h"     //评论页面

#import "LoginVC.h"

@interface CourseVC ()<JSDropDownMenuDataSource, JSDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,CourseCellCourseButtonPressedDelegate>

@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSMutableArray *courseList;

@property (nonatomic) NSInteger currentStudentsIndex;
@property (nonatomic) NSInteger currentCouseListIndex;

@property (strong, nonatomic) JSDropDownMenu *menu;

@property (strong, nonatomic) UIView *courseView;//上课信息的View
@property (strong, nonatomic) UILabel *courseTotal;//总课时
@property (strong, nonatomic) UILabel *courseComplete;//已完成课时
@property (strong, nonatomic) UILabel *courseLeave;//请假次数，需完成页面跳转
@property (strong, nonatomic) UILabel *courseAbsent;//缺课次数，需完成跳转
//is_signon取值 “时间已经过了： 1已上课且已签到 2 请假 3 缺课  时间没有过： 0正常 4  延迟 5 暂停”
@property (strong, nonatomic) NSString *courseIsSignon;//课程状态


@property (strong, nonatomic) NSMutableArray *studentCoursesArray;
@property (strong, nonatomic) UITableView *courseTableView;//课表

@property (nonatomic, assign) BOOL isLogin;//登录状态
@property (nonatomic, strong) NSString *userName;

@property (strong, nonatomic) UIView *bgView;//遮羞视图
@property (strong, nonatomic) UIImageView *bgImgView;//
@property (strong, nonatomic) UIButton *bgButton;

//- (void)courseLeaveToLeaveVC;//跳转到请假界面
//- (void)courseAbsentToAbsentVC;//跳转到缺课界面

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _students =[NSMutableArray arrayWithArray:@[@"小明", @"小红", @"小花"]];
//    _courseList = [NSMutableArray arrayWithArray:@[@"(2-4岁)创意思维课", @"(4-6岁)HABA数学课", @"初级英语"]];
    //[self getVStudentCourseByParentId];
    _currentStudentsIndex = 0;
    _currentCouseListIndex = 0;

    _students = [NSMutableArray array];
    _courseList = [NSMutableArray array];
    _studentCoursesArray = [NSMutableArray array];
//    _menu.dataSource = self;
//    _menu.delegate = self;
    
//    //注册一个通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingVCToReloadCourseVCWithNotification:) name:@"SettingVCToReloadCourseVC" object:nil];
    //保留登录状态
    self.isLogin = [[UserInfo sharedUser] isLogin];
    self.userName = [[UserInfo sharedUser] getUserName];
    
}


- (void)initUI{
    
    [super initUI];
    
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    _menu.indicatorColor = RGBCOLOR(175, 175, 175);
    _menu.separatorColor = RGBCOLOR(210, 210, 210);
    _menu.textColor = RGBCOLOR(83, 83, 83);
   
    [self.view addSubview:_menu];
    
//    [self getVStudentSourseScheduleSign];
    //课程信息栏
    self.courseView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, 40)];
    self.courseView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0];
    
    [self.view addSubview: self.courseView];
    
    [self courseViewLayout];
    //学生课程表数组
    self.studentCoursesArray = [NSMutableArray array];
    //学生课程表
    self.courseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight-150-49) style:UITableViewStyleGrouped];
    self.courseTableView.delegate = self;
    self.courseTableView.dataSource = self;
    
    [self.view addSubview:self.courseTableView];
    
    self.courseIsSignon = @"";
    
    ////////////////////////////
    //遮羞页面
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = RGBCOLOR(236, 236, 236);
    [self.view addSubview:_bgView];
    
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-250)/2, 120, 240, 202)];
    [_bgView addSubview:_bgImgView];
    
    _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bgButton setFrame:CGRectMake((kScreenWidth-80)/2, 320, 80, 30)];
    [_bgButton addTarget:self action:@selector(bgButtonCliceked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgButton setBackgroundImage:[UIImage imageNamed:@"btn_login.png"] forState:UIControlStateNormal];
    [_bgView addSubview:_bgButton];
   
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //进入页面时先判断当前登录状态是否改变，改变了就刷新列表，并改变当前状态
    if ([self isLoginChanged] || [self isUserNameChanged]) {
        
        //[self getVStudentCourseByParentId];
        [self refreshData];
    }
    
    if (self.students.count == 0) {
        //[self getVStudentCourseByParentId];
        [self refreshData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - myself
- (BOOL)isUserNameChanged {
    if ([self.userName isEqualToString:[[UserInfo sharedUser] getUserName]]) {
        return NO;
    }
    else {
        self.userName = [[UserInfo sharedUser] getUserName];
        return YES;
    }
}

- (BOOL)isLoginChanged {
    if ((self.isLogin == [[UserInfo sharedUser] isLogin])) {
        return NO;
    }
    else {
        self.isLogin = [[UserInfo sharedUser] isLogin];
        return YES;
    }
}

- (BOOL)isHasChild {
    NSArray *arr = [[UserStudent sharedUser] getUserStudentArray];
    
    return  arr.count == 0 ? NO : YES;
}

///是否显示遮羞视图
- (void)showBgNotLoginView {
    
    _bgView.hidden = NO;
    [self.view bringSubviewToFront:_bgView];
    
    _bgImgView.image = [UIImage imageNamed:@"no_login_photo.png"];
    [_bgButton setTitle:@"登录" forState:UIControlStateNormal];
    _bgButton.tag = 1001;
}
- (void)showBgNOChildView{
    _bgView.hidden = NO;
    [self.view bringSubviewToFront:_bgView];
    
    _bgImgView.image = [UIImage imageNamed:@"no_child_photo.png"];
    [_bgButton setTitle:@"联系客服" forState:UIControlStateNormal];
    _bgButton.tag = 1002;
}
- (void)hideBgView {
    _bgView.hidden = YES;
}

#pragma mark - refresh
- (void)refreshData {
    
    if (!self.isLogin) {//没有登录
        [self showBgNotLoginView];
    }
    else {
        if (![self isHasChild]) {//没有小孩
            [self showBgNOChildView];
        }
        else{
            [self hideBgView];//隐藏遮羞视图
            
            //清除之前数据
            _students = [NSMutableArray array];
            _courseList = [NSMutableArray array];
            _studentCoursesArray = [NSMutableArray array];
            [self.courseTableView reloadData];
            
            _menu.hidden = YES;
            _courseView.hidden = YES;
            
            [self getVStudentCourseByParentId];
        }
    }
    
}

#pragma mark - bgButton action
- (void)bgButtonCliceked:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (button.tag  == 1001) {//没有登录 进行登录
        LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else if (button.tag  == 1002) {//登录了但是没有孩子，联系客服安排小孩
        //呼叫
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4000999027"]];
    }
}

#pragma mark - 课表

- (void)courseViewLayout{
    
    UILabel *cStringTotal = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
    cStringTotal.font = [UIFont systemFontOfSize:12];
    cStringTotal.text = @"总课程";
    cStringTotal.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringTotal];
    
    self.courseTotal = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 30, 30)];
    self.courseTotal.font = [UIFont systemFontOfSize:12];
    //self.courseTotal.text = @"48";
    self.courseTotal.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:self.courseTotal];
    
    UIButton *courseTotalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [courseTotalBtn setFrame:CGRectMake(10, 0, 60, 40)];
    [courseTotalBtn setBackgroundColor:[UIColor clearColor]];
    [courseTotalBtn addTarget:self action:@selector(courseTotalBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.courseView addSubview:courseTotalBtn];
    
    UILabel *cStringComplete = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 40, 30)];
    cStringComplete.font = [UIFont systemFontOfSize:12];
    cStringComplete.text = @"已完成";
    cStringComplete.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringComplete];
    
    self.courseComplete = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 20, 30)];
    self.courseComplete.font = [UIFont systemFontOfSize:12];
    //self.courseComplete.text = @"12";
    self.courseComplete.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:self.courseComplete];
    
    UIButton *courseCompleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [courseCompleteBtn setFrame:CGRectMake(80, 0, 60, 40)];
    [courseCompleteBtn setBackgroundColor:[UIColor clearColor]];
    [courseCompleteBtn addTarget:self action:@selector(courseCompleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.courseView addSubview:courseCompleteBtn];
    
    UILabel *cStringLeave = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 40, 30)];
    cStringLeave.font = [UIFont systemFontOfSize:12];
    cStringLeave.text = @"（ 请假";
    cStringLeave.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringLeave];
    
    self.courseLeave = [[UILabel alloc] initWithFrame:CGRectMake(200, 9, 30, 20)];;
    self.courseLeave.font = [UIFont systemFontOfSize:12];
    self.courseLeave.textAlignment = NSTextAlignmentCenter;
    self.courseLeave.textColor = [UIColor orangeColor];
    
    [self.courseView addSubview:self.courseLeave];
    
    UIButton *courseLeaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [courseLeaveBtn setFrame:CGRectMake(160, 0, 60, 40)];
    [courseLeaveBtn setBackgroundColor:[UIColor clearColor]];
    [courseLeaveBtn addTarget:self action:@selector(courseLeaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.courseView addSubview:courseLeaveBtn];
    
    UILabel *cLeaveLine = [[UILabel alloc] initWithFrame:CGRectMake(210, 30, 10, 1)];
    cLeaveLine.backgroundColor = [UIColor grayColor];
    
    [self.courseView addSubview:cLeaveLine];
    
    UILabel *cStringAbsent = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 40, 30)];
    cStringAbsent.font = [UIFont systemFontOfSize:12];
    cStringAbsent.text = @", 缺课";
    cStringAbsent.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringAbsent];
    
    self.courseAbsent = [[UILabel alloc] initWithFrame:CGRectMake(270, 9, 30, 20)];;
    self.courseAbsent.font = [UIFont systemFontOfSize:12];
    self.courseAbsent.textAlignment = NSTextAlignmentCenter;
    self.courseAbsent.textColor = [UIColor orangeColor];
    
    [self.courseView addSubview:self.courseAbsent];
    
    UIButton *courseAbsentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [courseAbsentBtn setFrame:CGRectMake(240, 0, 60, 40)];
    [courseAbsentBtn setBackgroundColor:[UIColor clearColor]];
    [courseAbsentBtn addTarget:self action:@selector(courseAbsentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.courseView addSubview:courseAbsentBtn];
    
    UILabel *cAbsentLine = [[UILabel alloc] initWithFrame:CGRectMake(280, 30, 10, 1)];
    cAbsentLine.backgroundColor = [UIColor grayColor];
    
    [self.courseView addSubview:cAbsentLine];
    
    UILabel *cStringEdge = [[UILabel alloc] initWithFrame:CGRectMake(300, 5, 10, 30)];
    cStringEdge.font = [UIFont systemFontOfSize:12];
    cStringEdge.text = @"）";
    cStringEdge.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringEdge];
    
}
//总课程按钮
- (void)courseTotalBtnClicked{
    //IsSignon传空，查询所有的值
    self.courseIsSignon = @"";
    [self getVStudentSourseScheduleSign:2];
}
//已完成课程
- (void)courseCompleteBtnClicked{
//暂时不做已完成的按钮功能
//#warning change @"1"
//    //IsSignon传过时的标记，查询已完成的课程
//    self.courseIsSignon = @"1";
//    [self getVStudentSourseScheduleSign:2];
}

//跳转到请假界面
- (void)courseLeaveBtnClicked{
//    CourseLeaveVC *vc = [[CourseLeaveVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    //IsSignon传2，查询请假
    self.courseIsSignon = @"2";
    [self getVStudentSourseScheduleSign:2];
}

//跳转到缺课界面
- (void)courseAbsentBtnClicked{
//    CourseAbsentVC *vc = [[CourseAbsentVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    //IsSignon传3，查询缺课
    self.courseIsSignon = @"3";
    [self getVStudentSourseScheduleSign:2];
}


#pragma mark - Web
- (void)getVStudentCourseByParentId{
        //网路请求
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *userInfoDic = userDic[uUserInfoKey];
        [self showHudWithMsg:@"载入中..."];
        [[XeeService sharedInstance] getVStudentCourseByParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
            //[self hideHud];
            if (!error) {
                //NSLog(@"result:%@",result);
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    //NSLog(@"resultInfo1111:%@",result[@"resultInfo"]) ;
                    self.students = result[@"resultInfo"];
                    _menu.hidden = NO;
                    _courseView.hidden = NO;
                    _menu.dataSource = self;
                    _menu.delegate = self;
                    [self getVStudentSourseScheduleSign:1];
                }
                else{
                    //没添加孩子在这里关闭菊花
                    [self hideHud];
                    [UIFactory showAlert:result[@"resultInfo"]];
                }
            }
            else{
                [self hideHud];
                [UIFactory showAlert:@"网络错误"];
            }
        }];
}

//changeTitleMark为1时修改courseView中的值，为2时不修改
- (void)getVStudentSourseScheduleSign:(NSInteger )changeTitleMark{
    //NSString *studentId = self.students[self.currentStudentsIndex][@"student_id"];
    //NSString *courseId = self.courseList[self.currentCouseListIndex][@"course_id"];
    NSDictionary *studentDic = self.students[self.currentStudentsIndex];
    NSString *studentId = studentDic[@"student_id"];
    //NSLog(@"studentId:%@",studentId);
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    //现在用的假数据，用真数据时再解除courseid的注释
    //NSDictionary *courseDic = self.courseList[self.currentCouseListIndex];
    NSMutableArray *courseArray = studentDic[@"listCourse"];
    
    if (courseArray.count == 0) {
        //有孩子，没添加课程在这里关闭菊花
        [self hideHud];
        return;
    }
    NSDictionary *courseDic = courseArray[_currentCouseListIndex];
    NSString *studentSubcourseId = courseDic[@"student_subcourse_id"];
    //NSLog(@"courseDic:%@",courseDic);
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getVStudentSourseScheduleSignWithParentId:userInfoDic[uUserId] andStudentId:studentId andCourseId:studentSubcourseId andSignon:self.courseIsSignon andSort:@"" andOrder:@"" andPageSize:200 andPageIndex:1 andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        //点击了请假或者缺课按钮改变了courseIsSignon时，做了请求就及时设置IsSignon为空，为下一次查询所有的值做准备
        self.courseIsSignon = @"";
        if (!error) {
            
            //NSLog(@"getVStudentSourseScheduleSign result:%@",result);
            
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //NSLog(@"resuleInfo:%@",result[@"resultInfo"]);
                NSDictionary *studentCourseDic = result[@"resultInfo"];
                //NSLog(@"aaaaaaa:%@",result[@"resultInfo"]);
                //NSLog(@"aaaaaaa:%@",studentCourseDic[@"student_id"]);
                //NSLog(@"aaaaaaa:%@",studentCourseDic[@"data"]);
                
                //changeTitleMark为1时修改courseView中的值，为2时不修改
                if (changeTitleMark == 1) {
                    //获取当前学生的当前课程 上课的相关信息
                    [self getCourseViewInfo:studentCourseDic];
                }
                //获取当前学生当前课程 课表的信息数据，并刷新课表
                self.studentCoursesArray = studentCourseDic[@"data"];
                //NSLog(@"aaaaaaa:%li",[self.studentCoursesArray count]);
                [self.courseTableView reloadData];
                
                [self performSelector:@selector(scrollTableView) withObject:nil afterDelay:0.3];//滚动课程。
            }
        }
    }];
}

- (void)scrollTableView {
    
    NSInteger section = 0;
    
    NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval cha = NSTimeIntervalSince1970;
    
    for (int i=0; i<self.studentCoursesArray.count; i++) {
        NSDictionary *courseInfo =  self.studentCoursesArray[i];
        NSString *courserTime  = courseInfo[@"create_time"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *courseDate = [formatter dateFromString:courserTime];
        
        NSTimeInterval courseTimeInterval = [courseDate timeIntervalSince1970];
        
        NSTimeInterval tempCha = (courseTimeInterval > nowTimeInterval) ? (courseTimeInterval-nowTimeInterval) : (nowTimeInterval-courseTimeInterval);
        
        NSLog(@"tempCha:%f",tempCha);
        
        if ( tempCha < cha ) {
            cha = tempCha;
            section = i;
        }
    }
    
    NSLog(@"section:%ld",(long)section);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.courseTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//获取当前学生的当前课程 上课的相关信息
- (void)getCourseViewInfo:(NSDictionary *)studentCourseDic{
    //NSLog(@"studentCourseDic:%@",studentCourseDic);
    if ([self.courseIsSignon isEqualToString:@""]) {
        self.courseTotal.text = studentCourseDic[@"totalCount"];
    }
    self.courseComplete.text = studentCourseDic[@"unit_count_over"];
    self.courseLeave.text = studentCourseDic[@"unit_count_leave"];
    self.courseAbsent.text = studentCourseDic[@"unit_count_miss"];
}

#pragma mark - JSDropDownMenu datasouce delegate
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 2;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentStudentsIndex;;
        
    }
    if (column==1) {
        
        return _currentCouseListIndex;
    }
    
    return 0;
}


- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow {
    if (column == 0) {
        return _students.count;
    }
    else if (column == 1) {
        NSDictionary *studentDic = _students[_currentStudentsIndex];
        NSMutableArray *courseArray = studentDic[@"listCourse"];
        return courseArray.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column {
    if (column == 0) {
        NSDictionary *studentDic = _students[_currentStudentsIndex];
        return studentDic[@"name"];
        //return _students[_currentStudentsIndex];
    }
    else if (column ==1) {
        NSDictionary *studentDic = _students[_currentStudentsIndex];
        NSMutableArray *courseArray = studentDic[@"listCourse"];
        if (courseArray.count>0) {
            NSDictionary *courseDic = courseArray[_currentCouseListIndex];
            return courseDic[@"title"];
        }
        else {
            return @"无课程";
        }
        
        //return _courseList[_currentCouseListIndex];
    }
    
    return nil;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    
    
    if (indexPath.column == 0) {
        
        NSDictionary *studentDic = _students[indexPath.row];
        return studentDic[@"name"];
        //return _students[indexPath.row];
        
    }
    else if (indexPath.column == 1) {
        
        NSDictionary *studentDic = _students[_currentStudentsIndex];
        NSMutableArray *courseArray = studentDic[@"listCourse"];
        NSDictionary *courseDic = courseArray[indexPath.row];
        return courseDic[@"title"];
        //return _courseList[indexPath.row];
    }
    return nil;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        _currentStudentsIndex = indexPath.row;
        //点击更换学生后，重新发送请求刷新课表信息。
        [self getVStudentSourseScheduleSign:1];
    }
    else if (indexPath.column == 1) {
        _currentCouseListIndex = indexPath.row;
        //点击更换课表后，中心发送请求刷新课表信息。
        [self getVStudentSourseScheduleSign:1];
    }
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"count:%li",[self.studentCoursesArray count]);
    return [self.studentCoursesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CourseVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"CourseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[CourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.courseInfo = self.studentCoursesArray[indexPath.section];
    cell.cellEdge = 10;
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *studentCourseDic = self.studentCoursesArray[indexPath.section];
    NSString *signonStr =[NSString stringWithFormat:@"%@",studentCourseDic[@"is_signon"]];
    //时间没有过： 0正常 4  延迟 5 暂停”时，显示课程预告  1已上课且已签到 2 请假 3 缺课 显示课程回顾
    if ([signonStr isEqualToString:@"0"]||[signonStr isEqualToString:@"2"]) {
        CourseForenoticeVC *vc = [[CourseForenoticeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.courseLeaveInfoDic = self.studentCoursesArray[indexPath.section];
        //课程预览请求需要传递整套课程的id
        NSDictionary *studentDic = _students[_currentStudentsIndex];
        NSMutableArray *courseArray = studentDic[@"listCourse"];
        NSDictionary *courseDic = courseArray[_currentCouseListIndex];
        vc.courseIdStr = courseDic[@"course_id"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else{
//        CourseReviewVC *vc = [[CourseReviewVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.courseLeaveInfoDic = self.studentCoursesArray[indexPath.section];
//        [self.navigationController pushViewController:vc animated:YES];
        CourseReviewNewVC *vc = [[CourseReviewNewVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.courseLeaveInfoDic = self.studentCoursesArray[indexPath.section];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
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

#pragma mark - CourseCellCourseButtonPressedDelegate
- (void)courseButtonPressed:(id)sender andCourseInfo:(NSDictionary *)courseInfoDic{
    if ([sender isEqualToString:@"0"]) {
        //为0时，状态时正常的，可以“请假”
        CourseLeaveApplyVC *vc = [[CourseLeaveApplyVC alloc] init];
        vc.title = @"请假申请";
        vc.courseLeaveInfoDic = courseInfoDic;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender isEqualToString:@"1"]){
        //为1时，状态是已上课，可以“评论”
        CommentVC *vc = [[CommentVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.courseInfoDic = courseInfoDic;
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if ([sender isEqualToString:@"2"]||[sender isEqualToString:@"3"]){
        //为2时,为请假的情况，需要按钮功能实现补课，状态是补课，可以申请“补课”
        //为3时,为缺课的情况，需要按钮功能实现补课，状态是补课，可以申请“补课”
        CourseLeaveApplyVC *vc = [[CourseLeaveApplyVC alloc] init];
        vc.title = @"补课申请";
        vc.courseLeaveInfoDic = courseInfoDic;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
    }
}

//#pragma mark - SettingVCToReloadCourseVC
//- (void)settingVCToReloadCourseVCWithNotification:(NSNotification *)notification{
//    
//    //NSDictionary *dic = [notification userInfo];
//    [self getVStudentCourseByParentId];
//    
//    
//}

@end
