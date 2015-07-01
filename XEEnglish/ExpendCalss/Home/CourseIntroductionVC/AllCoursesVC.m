//
//  AllCoursesVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AllCoursesVC.h"
#import "JSDropDownMenu.h"
#import "HomeBtnCell.h"

#import "XeeService.h"

#import "SingleCourseVC.h"

@interface AllCoursesVC ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,HomeBtnCellDelegate>

@property (nonatomic, strong) NSMutableArray *coursesArray;
@property (nonatomic, strong) NSMutableArray *ageGroupArray;

@property (nonatomic, assign) NSInteger currentCourseIndex;
@property (nonatomic, assign) NSInteger currentAgeGroupIndex;

@property (nonatomic, strong) JSDropDownMenu *menu;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *requestCourseInfo;
@end

@implementation AllCoursesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"所有课程";
    
    //self.coursesArray = [NSMutableArray arrayWithObjects:@"英语课", @"艺术课",@"趣味课",nil];
    //self.ageGroupArray = [NSMutableArray arrayWithObjects:@"1013~1011", @"1021~1020",@"1022~1020",nil];
    
    self.currentCourseIndex = 0;
    self.currentAgeGroupIndex = 0;
    
    NSDictionary *courseIdAndNameDic = @{@"course_category_id":@"",@"name":@""};
    self.coursesArray = [[NSMutableArray alloc] init];
    [self.coursesArray addObject:courseIdAndNameDic];
    
    NSDictionary *ageGroupDic = @{@"min_age":@"",@"max_age":@""};
    self.ageGroupArray = [[NSMutableArray alloc] init];
    [self.ageGroupArray addObject:ageGroupDic];
    
    self.requestCourseInfo = [[NSMutableArray alloc] init];
    [self getCourseCategoryAge];//请求课程和年龄段数据
    
    //[self getCourseListByFilter];
//    self.menu.dataSource = self;
//    self.menu.delegate = self;
}

- (void)initUI{
    
    [super initUI];
    
    self.menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    self.menu.indicatorColor = RGBCOLOR(175, 175, 175);
    self.menu.separatorColor = RGBCOLOR(210, 210, 210);
    self.menu.textColor = RGBCOLOR(83, 83, 83);
    
    [self.view addSubview:self.menu];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight-110) style:UITableViewStylePlain];
    
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//待做
#pragma mark - Web
//请求课程和年龄段数据
- (void)getCourseCategoryAge{
    
    [[XeeService sharedInstance] getCourseCategoryAgeAndBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSLog(@"resultInfo:%@",result[@"resultInfo"]);
                //请求到数据后设置两个列表的数据信息
                [self getCoursesAndAgesInfo:result[@"resultInfo"]];
                NSLog(@"course:%@",self.coursesArray);
                NSLog(@"age:%@",self.ageGroupArray);
                
                //请求完数据之后才设置列表的数据源和代理方法
                self.menu.dataSource = self;
                self.menu.delegate = self;
                [self getCourseListByFilter];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}

//请求到数据后设置两个列表的数据信息
- (void)getCoursesAndAgesInfo:(NSArray *)resultInfo{
    //NSLog(@"resultInfo:%li",resultInfo.count);
    for (NSDictionary *info in resultInfo) {
        
        NSNumber *minAge = info[@"min_age"];
        NSNumber *maxAge = info[@"max_age"];
        //NSLog(@"maxAge:%@",info[@"max_age"]);
//        if (  maxAge.integerValue == 0) {
//            NSDictionary *courseIdAndNameDic = @{@"course_category_id":info[@"course_category_id"],@"name":info[@"name"]};
//            [self.coursesArray addObject:courseIdAndNameDic];
//            
//        }
//        else{
////            NSString *ageGroup = [NSString stringWithFormat:@"%@~%@",info[@"min_age"],info[@"max_age"]];
//            NSDictionary *ageGroupDic = @{@"min_age":info[@"min_age"],@"max_age":info[@"max_age"]};
//            [self.ageGroupArray addObject:ageGroupDic];
//            
//        }
//        if ( (![minAge isKindOfClass:[NSNull class]]) && (![maxAge isKindOfClass:[NSNull class]]) && minAge.integerValue == 0 && maxAge.integerValue > 0) {
//            //            NSString *ageGroup = [NSString stringWithFormat:@"%@~%@",info[@"min_age"],info[@"max_age"]];
//            NSDictionary *ageGroupDic = @{@"min_age":info[@"min_age"],@"max_age":info[@"max_age"]};
//            [self.ageGroupArray addObject:ageGroupDic];
//            
//        }
//        else{
//            NSDictionary *courseIdAndNameDic = @{@"course_category_id":info[@"course_category_id"],@"name":info[@"name"]};
//            [self.coursesArray addObject:courseIdAndNameDic];
//        }
        if ( [minAge isKindOfClass:[NSNull class]] && [maxAge isKindOfClass:[NSNull class]]) {
            //            NSString *ageGroup = [NSString stringWithFormat:@"%@~%@",info[@"min_age"],info[@"max_age"]];
            NSDictionary *courseIdAndNameDic = @{@"course_category_id":info[@"course_category_id"],@"name":info[@"name"]};
            [self.coursesArray addObject:courseIdAndNameDic];
            
        }
        else{
            
            NSDictionary *ageGroupDic = @{@"min_age":info[@"min_age"],@"max_age":info[@"max_age"]};
            [self.ageGroupArray addObject:ageGroupDic];
        }
    }
}

#pragma mark - Web2
- (void)getCourseListByFilter{
    
    [[XeeService sharedInstance] getCourseListByFilterWithMinAge:self.ageGroupArray[self.currentAgeGroupIndex][@"min_age"] andMaxAge:self.ageGroupArray[self.currentAgeGroupIndex][@"max_age"] andCourseCategoryId:self.coursesArray[self.currentCourseIndex][@"course_category_id"] andSort:@"" andOrder:@"" andPageSize:10 andPageIndex:1 andBlock:^(NSDictionary *result, NSError *error) {
        
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *requestCourseDic = result[@"resultInfo"];
                self.requestCourseInfo = requestCourseDic[@"data"];
                //NSLog(@"11111:%@",self.requestCourseInfo);
                
                self.tableView.dataSource = self;
                self.tableView.delegate = self;
                
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - JSDropDownMenu DataSource
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    return 2;
}

/**
 * 表视图显示时，是否需要两个表显示
 */
- (BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}
/**
 * 表视图显示时，左边表显示比例
 */
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1.0f;
}

/**
 * 返回当前菜单左边表选中行
 */
- (NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column == 0) {
        
        return self.currentCourseIndex;
    }
    else if (column == 1) {
        
        return self.currentAgeGroupIndex;
    }
    else{
        return 0;
    }
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column == 0) {
        //NSLog(@"coursesArray:%li",self.coursesArray.count);
        return [self.coursesArray count];
    }
    else if (column == 1){
        //NSLog(@"coursesArray:%li",self.ageGroupArray.count);
        return [self.ageGroupArray count];
    }
    else
        return 0;
    
}
- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    if (column == 0) {
        
        if (self.currentCourseIndex == 0) {
            NSString *courseStr = @"所有课程";
            return courseStr;
        }
        else{
            NSDictionary *courseIdAndNameDic = self.coursesArray[self.currentCourseIndex];
            return courseIdAndNameDic[@"name"];
        }
        
    }
    else if (column == 1){
        NSDictionary *ageGroupDic = self.ageGroupArray[self.currentAgeGroupIndex];
        NSString *ageGroupString = [NSString stringWithFormat:@"%@~%@",ageGroupDic[@"min_age"],ageGroupDic[@"max_age"]];
        if (self.currentAgeGroupIndex == 0) {
            return ageGroupString = @"所有年龄段";
        }
        else{
            return ageGroupString;
        }
    }
    return nil;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            NSString *courseStr = @"所有课程";
            return courseStr;
        }
        else{
            NSDictionary *courseIdAndNameDic = self.coursesArray[indexPath.row];
            return courseIdAndNameDic[@"name"];
        }
//        NSDictionary *courseIdAndName = self.coursesArray[indexPath.row];
//        return courseIdAndName[@"name"];
    }
    else if(indexPath.column == 1){
        NSDictionary *ageGroupDic = self.ageGroupArray[indexPath.row];
        NSString *ageGroupString = [NSString stringWithFormat:@"%@~%@",ageGroupDic[@"min_age"],ageGroupDic[@"max_age"]];
        if (indexPath.row == 0) {
            return ageGroupString = @"所有年龄段";
        }
        else{
            return ageGroupString;
        }
//        NSDictionary *ageGroupDic = self.ageGroupArray[indexPath.row];
//        NSString *ageGroupString = [NSString stringWithFormat:@"%@~%@",ageGroupDic[@"min_age"],ageGroupDic[@"max_age"]];
//        return ageGroupString;
    }
    return nil;
}

#pragma mark - JSDropDownMenu Delegate
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        
        self.currentCourseIndex = indexPath.row;
        [self getCourseListByFilter];
    }
    else if(indexPath.column == 1){
        
        self.currentAgeGroupIndex =indexPath.row;
        [self getCourseListByFilter];
    }
    else{
        
    }
        
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return (self.requestCourseInfo.count+1)/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"HomeBntCell_Identifier";
    
    HomeBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[HomeBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    cell.delegate = self;
    //NSLog(@"1111111111:%@",[self.requestCourseInfo objectAtIndex:2*(indexPath.row)]);
    cell.serviceDic1 = [self.requestCourseInfo objectAtIndex:2*(indexPath.row)];
    //NSLog(@"11111:%@",cell.serviceDic1);
    if ((2*(indexPath.row)+1) < self.requestCourseInfo.count) {
        cell.serviceDic2 = [self.requestCourseInfo objectAtIndex:(2*(indexPath.row)+1)];
    }
    else{
        cell.serviceDic2 = nil;
    }
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

#pragma mark - HomeBtnCell delegate
- (void)HomeBtnCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic{
    
    NSString *courseIdStr = [NSString stringWithFormat:@"%@",serviceDic[@"course_id"]];
    
    SingleCourseVC *vc = [[SingleCourseVC alloc] init];
    vc.title = [serviceDic objectForKey:@"title"];
    vc.courseId = courseIdStr;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
