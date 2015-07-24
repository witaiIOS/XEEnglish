//
//  CourseOutlineVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseOutlineVC.h"
#import "CourseCommentCell.h"

#import "ListeningCourseVC.h"
#import "BuyCourseVC.h"
#import "SingleCourseVC.h"

#import "XeeService.h"

@interface CourseOutlineVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;//评价数组；
@property (nonatomic, strong) NSDictionary *courseInfo;//课程信息

@property (nonatomic, strong) UIButton *listenBtn;//试听按键

@end

@implementation CourseOutlineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程概要";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    //初始化评价数组
    self.commentArray = [NSMutableArray array];
    
    [self getCourseDetailAndTopCommentListByCourseIdWithWeb];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-60) style:UITableViewStyleGrouped];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.tableHeaderView = [self headView];
    [self.view addSubview:self.tableView];
    //显示页面尾，显示试听和购买按钮
    [self footView];
}

- (UIView *)headView{
    //课程图片
    UIImageView *courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    [courseImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.courseInfo[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
//-----------------------------------------------------------------
    //课程名
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, kScreenWidth-20, 30)];
    titleLabel.text = self.courseInfo[@"title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];

    //分割线
    UILabel *titleLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 169, kScreenWidth-20, 1)];
    titleLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    //购买方式
    UILabel *buyMethedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 70, 30)];
    buyMethedLabel.text = @"购买方式";
    buyMethedLabel.textColor = [UIColor grayColor];
    buyMethedLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *buyMethedValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 170, 70, 30)];
    //buyMethedValueLabel.text = @"";
    buyMethedValueLabel.textColor = [UIColor grayColor];
    buyMethedValueLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 70, 30)];
    //priceLabel.text = @"";
    priceLabel.textColor = [UIColor grayColor];
    priceLabel.font = [UIFont systemFontOfSize:14];

    //分割线
    UILabel *buyMethedLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 199, kScreenWidth-20, 1)];
    buyMethedLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    //适合人群
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 70, 30)];
    ageLabel.text = @"适合人群";
    ageLabel.textColor = [UIColor grayColor];
    ageLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *ageValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 150, 30)];
    ageValueLabel.text = [NSString stringWithFormat:@"%@ ~ %@岁",self.courseInfo[@"min_age"],self.courseInfo[@"max_age"]];
    ageValueLabel.textColor = [UIColor grayColor];
    ageValueLabel.font = [UIFont systemFontOfSize:14];

    //分割线
    UILabel *ageLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 229, kScreenWidth-20, 1)];
    ageLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------    
    //课程目标
    UILabel *targetStudentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 70, 30)];
    targetStudentLabel.text = @"课程目标";
    targetStudentLabel.textColor = [UIColor grayColor];
    targetStudentLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *targetStudentValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 230, 150, 30)];
    targetStudentValueLabel.text = [NSString stringWithFormat:@"%@",self.courseInfo[@"target_student"]];
    targetStudentValueLabel.textColor = [UIColor grayColor];
    targetStudentValueLabel.font = [UIFont systemFontOfSize:14];
    
//    //分割线
//    UILabel *targetStudentLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, kScreenWidth, 10)];
//    targetStudentLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    //第一分区视图
    UIView *firstView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 230+targetStudentValueLabel.frame.size.height)];
    firstView.backgroundColor = [UIColor whiteColor];
    
    [firstView addSubview:courseImageView];
    
    [firstView addSubview:titleLabel];
    [firstView addSubview:titleLabelLine];
    
    [firstView addSubview:buyMethedLabel];
    [firstView addSubview:buyMethedValueLabel];
    [firstView addSubview:priceLabel];
    [firstView addSubview:buyMethedLabelLine];
    
    [firstView addSubview:ageLabel];
    [firstView addSubview:ageValueLabel];
    [firstView addSubview:ageLabelLine];
    
    [firstView addSubview:targetStudentLabel];
    [firstView addSubview:targetStudentValueLabel];
//    [firstView addSubview:targetStudentLabelLine];
    
//-------------------------第二部分视图-----------------------------------------------------------

    CGFloat orignalSecondHeight = firstView.frame.size.height+10;
    //课程简介
    UILabel *courseIntroductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 30)];
    courseIntroductionLabel.text = @"课程简介";
    courseIntroductionLabel.textColor = [UIColor blackColor];
    courseIntroductionLabel.font = [UIFont systemFontOfSize:14];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20, 8, 8, 15)];
    arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray.png"];
    
    UIButton *singleCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [singleCourseBtn setFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [singleCourseBtn addTarget:self action:@selector(singleCourseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    UILabel *courseIntroductionLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-20, 1)];
    courseIntroductionLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    UILabel *courseIntroductionValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-20, 30)];
    courseIntroductionValueLabel.text = self.courseInfo[@"des"];
    courseIntroductionValueLabel.textColor = [UIColor blackColor];
    //自动换行，自适应高度
    courseIntroductionValueLabel.numberOfLines = 0;
    courseIntroductionValueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize courseIntroductionValueSize = [courseIntroductionValueLabel sizeThatFits:CGSizeMake(courseIntroductionValueLabel.frame.size.width, MAXFLOAT)];
    courseIntroductionValueLabel.frame = CGRectMake(10, 30, kScreenWidth-20, courseIntroductionValueSize.height-30);
    courseIntroductionValueLabel.font = [UIFont systemFontOfSize:12];
//-----------------------------------------------------------------
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, orignalSecondHeight, kScreenWidth, 30+courseIntroductionValueLabel.frame.size.height)];
    secondView.backgroundColor = [UIColor whiteColor];
    
    [secondView addSubview:courseIntroductionLabel];
    [secondView addSubview:arrowImageView];
    [secondView addSubview:singleCourseBtn];
    [secondView addSubview:courseIntroductionLabelLine];
    [secondView addSubview:courseIntroductionValueLabel];
    
//----------------------------------------------------------------------------------
    CGFloat backgroundViewHeight = orignalSecondHeight + secondView.frame.size.height+10;
    
    UIView *backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor clearColor];
    //将视图1和视图2加入
    [backgroundView addSubview:firstView];
    [backgroundView addSubview:secondView];

    return backgroundView;
}


//显示页面尾，显示试听和购买按钮
- (void)footView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    self.listenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.listenBtn setFrame:CGRectMake(20, 10, kScreenWidth/2-40, 40)];
    [self.listenBtn setTitle:@"试听" forState:UIControlStateNormal];
    [self.listenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.listenBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.listenBtn setBackgroundColor:[UIColor greenColor]];
    self.listenBtn.layer.cornerRadius = 4.0f;
    [self.listenBtn addTarget:self action:@selector(listenBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:self.listenBtn];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(kScreenWidth/2+20, 10, kScreenWidth/2-40, 40)];
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [buyBtn setBackgroundColor:[UIColor orangeColor]];
    buyBtn.layer.cornerRadius = 4.0f;
    [buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:buyBtn];
}


#pragma mark - My Action

- (void)listenBtnClicked{
    if ([[UserInfo sharedUser] isLogin]) {
        ListeningCourseVC *vc = [[ListeningCourseVC alloc] init];
        vc.courseName = self.title;
        vc.parentCourseId = self.courseId;
        vc.parentCourseInfo = self.courseInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [UIFactory showAlert:@"请先登录"];
        //[self showHudOnlyMsg:@"请先登录"];
        //        LoginVC *vc = [[LoginVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)buyBtnClicked{
    if ([[UserInfo sharedUser] isLogin]) {
        BuyCourseVC *vc = [[BuyCourseVC alloc] init];
        vc.courseName = self.title;
        vc.parentCourseId = self.courseId;
        //vc.payMethodNumber = self.payMethodNum;
        //vc.superPayMethodNumber = self.payMethodNum;
        vc.courseInfoDic = self.courseInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [UIFactory showAlert:@"请先登录"];
        //[self showHudOnlyMsg:@"请先登录"];
        //        LoginVC *vc = [[LoginVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)singleCourseBtnPressed{
    SingleCourseVC *vc = [[SingleCourseVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = self.courseInfo[@"title"];
    vc.courseId = [NSString stringWithFormat:@"%@",self.courseInfo[@"course_id"]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Web
- (void)getCourseDetailAndTopCommentListByCourseIdWithWeb{
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getCourseDetailAndTopCommentListByCourseId:self.courseId andPageSize:10 andPageIndex:1 andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.courseInfo = result[@"resultInfo"];
                self.commentArray = self.courseInfo[@"listRelation"];
                
                self.tableView.dataSource = self;
                self.tableView.delegate = self;
                self.tableView.tableHeaderView = [self headView];
                
                [self.tableView reloadData];
            }else{
                [UIFactory showAlert:@"未知错误"];
            }
        }
        else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.commentArray count];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CourseCommentVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"CourseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    CourseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    //    if (cell == nil) {
    //        cell = [[CourseCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    //    }
    
    cell.cellEdge = 10;
    cell.commentInfoDic = self.commentArray[indexPath.section];
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
}





@end
