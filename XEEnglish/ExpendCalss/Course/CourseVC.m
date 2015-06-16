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


@interface CourseVC ()<JSDropDownMenuDataSource, JSDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSMutableArray *courseList;

@property (nonatomic) NSInteger currentStudentsIndex;
@property (nonatomic) NSInteger currentCouseListIndex;

@property (strong, nonatomic) JSDropDownMenu *menu;


@property (strong, nonatomic) UIView *courseView;//上课信息的View
@property (strong, nonatomic) UILabel *courseTotal;//总课时
@property (strong, nonatomic) UILabel *courseComplete;//已完成课时
@property (strong, nonatomic) UIButton *courseLeave;//请假次数，需完成页面跳转
@property (strong, nonatomic) UIButton *courseAbsent;//缺课次数，需完成跳转


@property (strong, nonatomic) UITableView *courseTableView;//课表

- (void)courseLeaveToLeaveVC;//跳转到请假界面
- (void)courseAbsentToAbsentVC;//跳转到缺课界面

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _students =[NSMutableArray arrayWithArray:@[@"小明", @"小红", @"小花"]];
//    _courseList = [NSMutableArray arrayWithArray:@[@"(2-4岁)创意思维课", @"(4-6岁)HABA数学课", @"初级英语"]];
    [self getVStudentCourseByParentId];
    _currentStudentsIndex = 0;
    _currentCouseListIndex = 0;

//    _menu.dataSource = self;
//    _menu.delegate = self;
    
}

- (void)initUI{
    
    [super initUI];
    
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    _menu.indicatorColor = RGBCOLOR(175, 175, 175);
    _menu.separatorColor = RGBCOLOR(210, 210, 210);
    _menu.textColor = RGBCOLOR(83, 83, 83);
   
    [self.view addSubview:_menu];
    
    self.courseView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, 40)];
    [self.courseView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview: self.courseView];
    
    [self courseViewLayout];
    
    self.courseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight-150-49) style:UITableViewStyleGrouped];
    self.courseTableView.delegate = self;
    self.courseTableView.dataSource = self;
    
    [self.view addSubview:self.courseTableView];
   
}

- (void)courseViewLayout{
    
    UILabel *cStringTotal = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
    cStringTotal.font = [UIFont systemFontOfSize:12];
    cStringTotal.text = @"总课程";
    cStringTotal.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringTotal];
    
    self.courseTotal = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 20, 30)];
    self.courseTotal.font = [UIFont systemFontOfSize:12];
    self.courseTotal.text = @"48";
    self.courseTotal.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:self.courseTotal];
    
    UILabel *cStringComplete = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 40, 30)];
    cStringComplete.font = [UIFont systemFontOfSize:12];
    cStringComplete.text = @"已完成";
    cStringComplete.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringComplete];
    
    self.courseComplete = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 20, 30)];
    self.courseComplete.font = [UIFont systemFontOfSize:12];
    self.courseComplete.text = @"12";
    self.courseComplete.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:self.courseComplete];
    
    UILabel *cStringLeave = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 40, 30)];
    cStringLeave.font = [UIFont systemFontOfSize:12];
    cStringLeave.text = @"（ 请假";
    cStringLeave.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringLeave];
    
    self.courseLeave = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.courseLeave setFrame:CGRectMake(200, 9, 30, 20)];
    [self.courseLeave setTitle:@"0" forState:UIControlStateNormal];
    [self.courseLeave setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.courseLeave.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.courseLeave addTarget:self action:@selector(courseLeaveToLeaveVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.courseView addSubview:self.courseLeave];
    
    UILabel *cLeaveLine = [[UILabel alloc] initWithFrame:CGRectMake(210, 30, 10, 1)];
    cLeaveLine.backgroundColor = [UIColor grayColor];
    
    [self.courseView addSubview:cLeaveLine];
    
    UILabel *cStringAbsent = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 40, 30)];
    cStringAbsent.font = [UIFont systemFontOfSize:12];
    cStringAbsent.text = @", 缺课";
    cStringAbsent.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringAbsent];
    
    self.courseAbsent = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.courseAbsent setFrame:CGRectMake(270, 9, 30, 20)];
    [self.courseAbsent setTitle:@"0" forState:UIControlStateNormal];
    [self.courseAbsent setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.courseAbsent.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.courseAbsent addTarget:self action:@selector(courseAbsentToAbsentVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.courseView addSubview:self.courseAbsent];
    
    UILabel *cAbsentLine = [[UILabel alloc] initWithFrame:CGRectMake(280, 30, 10, 1)];
    cAbsentLine.backgroundColor = [UIColor grayColor];
    
    [self.courseView addSubview:cAbsentLine];
    
    UILabel *cStringEdge = [[UILabel alloc] initWithFrame:CGRectMake(300, 5, 10, 30)];
    cStringEdge.font = [UIFont systemFontOfSize:12];
    cStringEdge.text = @"）";
    cStringEdge.textColor = [UIColor blackColor];
    
    [self.courseView addSubview:cStringEdge];
    
}

//跳转到请假界面
- (void)courseLeaveToLeaveVC{
    CourseLeaveVC *vc = [[CourseLeaveVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//跳转到缺课界面
- (void)courseAbsentToAbsentVC{
    CourseAbsentVC *vc = [[CourseAbsentVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Web
- (void)getVStudentCourseByParentId{
    [[XeeService sharedInstance] getVStudentCourseByParentId:17 andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //NSLog(@"resultInfo1111:%@",result[@"resultInfo"]) ;
                self.students = result[@"resultInfo"];
                _menu.dataSource = self;
                _menu.delegate = self;
            }
        }
    }];
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
        return _courseList.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column {
    if (column == 0) {
        return _students[_currentStudentsIndex];
    }
    else if (column ==1) {
        return _courseList[_currentCouseListIndex];
    }
    
    return nil;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    NSDictionary *studentDic = _students[indexPath.row];
    
    if (indexPath.column == 0) {
        
        return studentDic[@"name"];
        //return _students[indexPath.row];
        
    }
    else if (indexPath.column == 1) {
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
    }
    else if (indexPath.column == 1) {
        _currentCouseListIndex = indexPath.row;
    }
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
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
    cell.cellEdge = 10;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 5.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}


@end
