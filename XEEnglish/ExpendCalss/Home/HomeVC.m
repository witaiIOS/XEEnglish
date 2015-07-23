//
//  HomeVC.m
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeVC.h"
#import "HomeBtnCell.h"
#import "HomeAdCell.h"
#import "XeeService.h"

#import "HomeDetailButton.h"

#import "ActivityVC.h"
#import "NearSchoolVC.h"

#import "AllCoursesVC.h"
#import "SingleCourseVC.h"

@interface HomeVC ()<HomeBtnCellDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *serviceInfos;
@property (strong, nonatomic) NSArray *adInfos;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _adInfos = [[NSArray alloc] init];
    _serviceInfos = [[NSArray alloc] init];
    
//    [[XeeService sharedInstance] getHomeServiceWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
//        if (error) {
//            [UIFactory showAlert:@"网络错误"];
//        }
//        else{
//            if ([result integerValue] == 0) {
//                _serviceInfos = [resultInfo mutableCopy];
//                [self.tableView reloadData];
//            }
//            else{
//                [UIFactory showAlert:@"未知错误"];
//            }
//        }
//
//    }];
//    [self showHudWithMsg:@"载入中..."];
//    [[XeeService sharedInstance] getHomeAdWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
//        [self hideHud];
//        if (error) {
//            NSLog(@"网络错误");
//        }
//        else{
//            if ([result integerValue] == 0) {
//                _adInfos = [resultInfo mutableCopy];
//                [self.tableView reloadData];
//            }
//            else{
//                NSLog(@"resultInfo = 1");
//            }
//            
//        }
//
//    }];
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getAdAndBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                self.adInfos = result[@"resultInfo"];
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
        
    
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseListAppHomeAndBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            //NSLog(@"result:%@",result);
            if (isResult.integerValue == 0) {
                self.serviceInfos = result[@"resultInfo"];
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

- (void)initUI{
    
    [super initUI];
    
//    UIButton *nearSchoolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [nearSchoolBtn setFrame:CGRectMake(10, 17, 60, 30)];
//    [nearSchoolBtn setTitle:@"附近校区" forState:UIControlStateNormal];
//    [nearSchoolBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [nearSchoolBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [nearSchoolBtn addTarget:self action:@selector(nearSchoolBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *nearSchoolBarBtn = [[UIBarButtonItem alloc] initWithCustomView:nearSchoolBtn];
//    self.navigationItem.leftBarButtonItem = nearSchoolBarBtn;
    
//    UIButton *servicePhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [servicePhoneBtn setFrame:CGRectMake(kScreenWidth-40, 17, 30, 30)];
//    [servicePhoneBtn setImage:[UIImage imageNamed:@"s_phone.png"] forState:UIControlStateNormal];
//    [servicePhoneBtn addTarget:self action:@selector(servicePhoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *servicePhoneBarBtn = [[UIBarButtonItem alloc] initWithCustomView:servicePhoneBtn];
//    self.navigationItem.rightBarButtonItem = servicePhoneBarBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - MyAction
//
//- (void)servicePhoneBtnClicked{
//    
//    //呼叫
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4000999027"]];
//}
//
//- (void)nearSchoolBtnClicked{
//    
//    NearSchoolVC *vc = [[NearSchoolVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return (_serviceInfos.count+1)/2;
    }
    else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"HomeAdCell_Identifier";
    static NSString *CellIdentifier2 = @"HomeBntCell_Identifier";
    
    UITableViewCell *cell = nil;

    
    if (indexPath.section == 0) {//ad
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[HomeAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        ((HomeAdCell *)cell).adArray = _adInfos;
        
        return cell;
        
        
    }
    else if (indexPath.section == 1){//bnt
        HomeBtnCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if(cell2 == nil){
            cell2 = [[HomeBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        cell2.delegate = self;
        cell2.serviceDic1 = [_serviceInfos objectAtIndex:2*(indexPath.row)];
        
        if ( (2*(indexPath.row)+1) < _serviceInfos.count) {
            cell2.serviceDic2 = [_serviceInfos objectAtIndex:2*(indexPath.row)+1];
        }
        else{
            cell2.serviceDic2 = nil;
        }

        return cell2;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        return cell;
    }
    
    
}
#pragma mark - UITableView Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return 160;
    }
    else if (indexPath.section == 1){
        return 140;
    }
    else{
        return 44;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 120.0f;
    }else{
        return 1.0f;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView *viewBackground =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        viewBackground.backgroundColor = [UIColor clearColor];
        
        UIView *viewWhite = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        viewWhite.backgroundColor = [UIColor whiteColor];
        [viewBackground addSubview:viewWhite];
        //妈妈帮Btn
        HomeDetailButton *mamaBangBtn = [HomeDetailButton buttonWithType:UIButtonTypeCustom];
        [mamaBangBtn setFrame:CGRectMake(20, 0, 70, 70)];
        mamaBangBtn.tag = 10;
        [mamaBangBtn setTitle:@"妈妈帮" forState:UIControlStateNormal];
        [mamaBangBtn setImage:[UIImage imageNamed:@"image_loading.png" ]forState:UIControlStateNormal];
        [mamaBangBtn addTarget:self action:@selector(HomeDetailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [viewWhite addSubview:mamaBangBtn];
        //近期活动Btn
        HomeDetailButton *nearActivityBtn = [HomeDetailButton buttonWithType:UIButtonTypeCustom];
        [nearActivityBtn setFrame:CGRectMake(20+(kScreenWidth/3), 0, 70, 70)];
        nearActivityBtn.tag = 11;
        [nearActivityBtn setTitle:@"近期活动" forState:UIControlStateNormal];
        [nearActivityBtn setImage:[UIImage imageNamed:@"image_loading.png" ]forState:UIControlStateNormal];
        [nearActivityBtn addTarget:self action:@selector(HomeDetailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [viewWhite addSubview:nearActivityBtn];
        //附近校区Btn
        HomeDetailButton *nearSchoolBtn = [HomeDetailButton buttonWithType:UIButtonTypeCustom];
        [nearSchoolBtn setFrame:CGRectMake(20+2*(kScreenWidth/3), 0, 70, 70)];
        nearSchoolBtn.tag = 12;
        [nearSchoolBtn setTitle:@"附近校区" forState:UIControlStateNormal];
        [nearSchoolBtn setImage:[UIImage imageNamed:@"image_loading.png" ]forState:UIControlStateNormal];
        [nearSchoolBtn addTarget:self action:@selector(HomeDetailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [viewWhite addSubview:nearSchoolBtn];
        //课程列表Label
        UILabel *courseListLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 160, 30)];
        courseListLabel.text = @"课程列表";
        courseListLabel.textColor = [UIColor blackColor];
        courseListLabel.font = [UIFont systemFontOfSize:14];
        [viewBackground addSubview:courseListLabel];
        
        //所有课程Label
        UILabel *allCourseLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-160, 90, 130, 30)];
        allCourseLabel.text = @"所有课程";
        allCourseLabel.textColor = [UIColor lightGrayColor];
        allCourseLabel.textAlignment = NSTextAlignmentRight;
        allCourseLabel.font = [UIFont systemFontOfSize:12];
        [viewBackground addSubview:allCourseLabel];
        //箭头图标
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20, 95, 8, 15)];
        arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray.png"];
        [viewBackground addSubview:arrowImageView];
        
        UIButton *allCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [allCourseBtn setFrame:CGRectMake(0, 80, kScreenWidth, 40)];
        [allCourseBtn addTarget:self action:@selector(allCourseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [viewBackground addSubview:allCourseBtn];
        
        return viewBackground;
    }
    else{
        UIView *viewBackground =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        viewBackground.backgroundColor = [UIColor clearColor];
        
        return viewBackground;
    }
    
}
#pragma mark - HomeDetailButton action
- (void)HomeDetailButtonPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    //妈妈帮Btn
    if (button.tag == 10) {
        
    }
    //近期活动Btn
    else if(button.tag == 11){
        ActivityVC *vc = [[ActivityVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //附近校区Btn
    else if(button.tag == 12){
        NearSchoolVC *vc = [[NearSchoolVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
    }
    
}
#pragma mark - allCourseBtn action
- (void)allCourseBtnPressed{
    AllCoursesVC *vc = [[AllCoursesVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"所有课程";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - HomeBtnCell delegate
- (void)HomeBtnCellButtonPressed:(id)sender andServiceInfo:(NSDictionary *)serviceDic{
    
    //UIButton *button = (UIButton *)sender;
    //NSLog(@"button.tag:%li",(long)button.tag);
    //NSLog(@"serviceDic:%@",serviceDic);
    
    NSString *courseIdStr = [NSString stringWithFormat:@"%@",serviceDic[@"course_id"]];
//    if([courseIdStr isEqualToString:@"0"]){
//        AllCoursesVC *vc = [[AllCoursesVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.title = [serviceDic objectForKey:@"title"];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else{
//        SingleCourseVC *vc = [[SingleCourseVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.title = [serviceDic objectForKey:@"title"];
//        vc.courseId = courseIdStr;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    SingleCourseVC *vc = [[SingleCourseVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = [serviceDic objectForKey:@"title"];
    vc.courseId = courseIdStr;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
