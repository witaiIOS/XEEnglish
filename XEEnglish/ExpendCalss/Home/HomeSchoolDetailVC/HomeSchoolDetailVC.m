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

#import "ServiceButton.h"

#import "DepositServiceVC.h"
#import "PayListeningVC.h"

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
        return 105.0f;
    }
    else{
        return 44.0f;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize size = [self.schoolInfoDic[@"history"] sizeWithFont:font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        
        return 10+20+size.height+10 +50+20+10+10+40;
    }
    else{
        return 0.5f;
    }
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 140.0f;
    }
    else{
        return 3.0f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        //校区名
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, kScreenWidth-20, 20)];
        titleLabel.text = self.schoolInfoDic[@"department"];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor orangeColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //历史介绍
        UILabel *historyLabel =  [[UILabel alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth-40, 60)];
        historyLabel.text = self.schoolInfoDic[@"history"];
        historyLabel.numberOfLines = 0;
        historyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        historyLabel.font = [UIFont systemFontOfSize:14];
        //NSLog(@"width:%li",(long)historyLabel.frame.size.width);
        //CGSize historySize = [historyLabel sizeThatFits:CGSizeMake(historyLabel.frame.size.width, MAXFLOAT)];
        CGSize historySize = [self.schoolInfoDic[@"history"] sizeWithFont:historyLabel.font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        historyLabel.frame =CGRectMake(20, 20, kScreenWidth-40, historySize.height);
        
        
        //分割线
        UILabel *historyLine = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+5, kScreenWidth-20, 1)];
        historyLine.backgroundColor = [UIColor lightGrayColor];
        
        //地址
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10, kScreenWidth-20, 50)];
        addressLabel.text = [NSString stringWithFormat:@"地址：%@",self.schoolInfoDic[@"addr"]];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.font = [UIFont systemFontOfSize:14];
        //addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.numberOfLines = 0;
        addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        //电话
        UILabel *phoneTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10 +50, 45, 20)];
        phoneTipLabel.text = @"电话：";
        phoneTipLabel.textColor = [UIColor blackColor];
        phoneTipLabel.font = [UIFont systemFontOfSize:14];
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, historyLabel.frame.origin.y+historySize.height+10 +50, kScreenWidth-55, 20)];
        phoneLabel.text = [NSString stringWithFormat:@"%@",self.schoolInfoDic[@"mobile"]];
        phoneLabel.textColor = [UIColor orangeColor];
        phoneLabel.font = [UIFont systemFontOfSize:14];
        //phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [phoneBtn setFrame:CGRectMake(55, historyLabel.frame.origin.y+historySize.height+10 +50, kScreenWidth-55, 20)];
        [phoneBtn addTarget:self action:@selector(TakePhoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
//        //分割线
//        UILabel *phoneLine = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10 +50+20+5, kScreenWidth-20, 1)];
//        phoneLine.backgroundColor = [UIColor lightGrayColor];
        
        //头视图
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, historyLabel.frame.origin.y+historySize.height+10 +50+20+10)];
        headView.backgroundColor = [UIColor whiteColor];
        //label都加入headView
        [headView addSubview:titleLabel];
        [headView addSubview:historyLabel];
        [headView addSubview:historyLine];
        [headView addSubview:addressLabel];
        [headView addSubview:phoneTipLabel];
        [headView addSubview:phoneLabel];
        [headView addSubview:phoneBtn];
        //[headView addSubview:phoneLine];
//---------------------------------------section头视图---------------------------
        //NSLog(@"height:%.f",historyLabel.frame.origin.y+historySize.height+10 +50+20+10+10);
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, historyLabel.frame.origin.y+historySize.height+10 +50+20+10+10,kScreenWidth,40)];
        sectionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        sectionLabel.text = @"早教课程";
        sectionLabel.font = [UIFont systemFontOfSize:14];
        sectionLabel.textColor = [UIColor blackColor];
        
        [sectionView addSubview:sectionLabel];
        
//------------------------------------------背景视图-------------------------------
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,historyLabel.frame.origin.y+historySize.height+10 +50+20+10+10+40)];
        sectionView.backgroundColor = [UIColor clearColor];
        
        [backGroundView addSubview:headView];
        [backGroundView addSubview:sectionView];
        
        return backGroundView;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *serviceView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 120)];
        serviceView.backgroundColor = [UIColor whiteColor];
        
        UILabel *serviceTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        serviceTipLabel.text = @"服务";
        serviceTipLabel.textColor = [UIColor blackColor];
        serviceTipLabel.font = [UIFont systemFontOfSize:14];
        [serviceView addSubview:serviceTipLabel];
        
        UILabel *serviceTipLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 39, kScreenWidth-20, 1)];
        serviceTipLine.backgroundColor = [UIColor lightGrayColor];
        [serviceView addSubview:serviceTipLine];
        //托管服务Btn
        ServiceButton *depositServiceBtn = [[ServiceButton alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth/2-1, 70)];
        depositServiceBtn.tag = 10;
        [depositServiceBtn setImage:[UIImage imageNamed:@"school_course_service_trust.png"] forState:UIControlStateNormal];
        [depositServiceBtn setTitle:@"托管" forState:UIControlStateNormal];
        [depositServiceBtn addTarget:self action:@selector(ServiceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [serviceView addSubview:depositServiceBtn];
        
        UILabel *serviceMiddleLine = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-1, 40, 1, 80)];
        serviceMiddleLine.backgroundColor = [UIColor lightGrayColor];
        [serviceView addSubview:serviceMiddleLine];
        
        //托管服务Btn
        ServiceButton *visitCourseServiceBtn = [[ServiceButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 40, kScreenWidth/2, 70)];
        visitCourseServiceBtn.tag = 11;
        [visitCourseServiceBtn setImage:[UIImage imageNamed:@"school_course_service_visit.png"] forState:UIControlStateNormal];
        [visitCourseServiceBtn setTitle:@"上门送课" forState:UIControlStateNormal];
        [visitCourseServiceBtn addTarget:self action:@selector(ServiceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [serviceView addSubview:visitCourseServiceBtn];
//------------------------------------------------------------------------------------
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
        backGroundView.backgroundColor = [UIColor clearColor];
        
        [backGroundView addSubview:serviceView];
        
        return backGroundView;
        
        
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    }
}

#pragma mark - ServiceBtn
- (void)ServiceBtnClicked:(id)sender{
    
    ServiceButton *selectBtn = (ServiceButton *)sender;
    if (selectBtn.tag == 10) {
        DepositServiceVC *vc = [[DepositServiceVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (selectBtn.tag == 11){
        PayListeningVC *vc = [[PayListeningVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - TakePhoneBtnClicked
- (void)TakePhoneBtnClicked{
    
    //呼叫
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.schoolInfoDic[@"mobile"]]]];
}

@end
