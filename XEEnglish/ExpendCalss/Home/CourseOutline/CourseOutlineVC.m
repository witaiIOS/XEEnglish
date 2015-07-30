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
#import "SingleCourseCommentVC.h"

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
    
    //
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
    UIImageView *courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 140)];
    [courseImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.courseInfo[@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
//-----------------------------------------------------------------
    //课程名
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, kScreenWidth-40, 30)];
    titleLabel.text = self.courseInfo[@"title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];

    //分割线
    UILabel *titleLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 169, kScreenWidth-40, 1)];
    titleLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    //购买方式
    UILabel *buyMethedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 70, 30)];
    buyMethedLabel.text = @"付费方式";
    buyMethedLabel.textColor = [UIColor blackColor];
    buyMethedLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *buyMethedValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 170, kScreenWidth-80-20, 30)];
    //buyMethedValueLabel.text = @"";
    buyMethedValueLabel.textColor = [UIColor grayColor];
    buyMethedValueLabel.font = [UIFont systemFontOfSize:14];
    NSString *payType = [NSString stringWithFormat:@"%@",self.courseInfo[@"pay_type"]];
    if ([payType intValue] == 1) {
        buyMethedValueLabel.text = [NSString stringWithFormat:@"课时购买。  课时单价：%@元／时 ",self.courseInfo[@"price"]];
    }else if ([payType intValue] == 2){
        buyMethedValueLabel.text = [NSString stringWithFormat:@"整套购买。  整套价：%@元／套 ",self.courseInfo[@"total_price"]];
    }
    
//    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 70, 30)];
//    //priceLabel.text = @"";
//    priceLabel.textColor = [UIColor grayColor];
//    priceLabel.font = [UIFont systemFontOfSize:14];

    //分割线
    UILabel *buyMethedLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 199, kScreenWidth-40, 1)];
    buyMethedLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    //适合人群
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 70, 30)];
    ageLabel.text = @"适合人群";
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *ageValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 150, 30)];
    ageValueLabel.text = [NSString stringWithFormat:@"%@ ~ %@岁",self.courseInfo[@"min_age"],self.courseInfo[@"max_age"]];
    ageValueLabel.textColor = [UIColor grayColor];
    ageValueLabel.font = [UIFont systemFontOfSize:14];

    //分割线
    UILabel *ageLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 229, kScreenWidth-40, 1)];
    ageLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------    
    //课程目标
    UILabel *targetStudentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 70, 30)];
    targetStudentLabel.text = @"课程目标";
    targetStudentLabel.textColor = [UIColor blackColor];
    targetStudentLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *targetStudentValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 230, kScreenWidth-80-20, 30)];
    targetStudentValueLabel.text = [NSString stringWithFormat:@"%@",self.courseInfo[@"target_student"]];
    targetStudentValueLabel.textColor = [UIColor grayColor];
    
    targetStudentValueLabel.numberOfLines = 0;
    targetStudentValueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize targetStudentValueSize = [targetStudentValueLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(targetStudentValueLabel.frame.size.width, 2000.0) lineBreakMode:NSLineBreakByWordWrapping];
    if (targetStudentValueSize.height > 30) {
        targetStudentValueLabel.frame = CGRectMake(80, 230, kScreenWidth-80-20, targetStudentValueSize.height);
    }else{
        targetStudentValueLabel.frame = CGRectMake(80, 230, kScreenWidth-80-20, 30);
    }

    
//    CGSize targetStudentValueSize = [targetStudentValueLabel sizeThatFits:CGSizeMake(targetStudentValueLabel.frame.size.width, MAXFLOAT)];
//    if (targetStudentValueSize.height > 30) {
//        targetStudentValueLabel.frame = CGRectMake(80, 230, kScreenWidth-80-20, targetStudentValueSize.height);
//    }else{
//        targetStudentValueLabel.frame = CGRectMake(80, 230, kScreenWidth-80-20, 30);
//    }
    targetStudentValueLabel.font = [UIFont systemFontOfSize:14];
    
//    //重置课程目标的label
//    targetStudentLabel.frame = CGRectMake(10, 230, 70, targetStudentValueSize.height);
    
//    //分割线
//    UILabel *targetStudentLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, kScreenWidth, 10)];
//    targetStudentLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    //第一分区视图
//    CGFloat firstViewHeight = 0;
//    if (targetStudentValueLabel.frame.size.height > 30) {
//        firstViewHeight = 230+targetStudentValueLabel.frame.size.height;
//    }else{
//        firstViewHeight = 230+30;
//    }
    CGFloat firstViewHeight = 230 +targetStudentValueLabel.frame.size.height;
    UIView *firstView =[[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, firstViewHeight)];
    firstView.backgroundColor = [UIColor whiteColor];
    
    [firstView addSubview:courseImageView];
    
    [firstView addSubview:titleLabel];
    [firstView addSubview:titleLabelLine];
    
    [firstView addSubview:buyMethedLabel];
    [firstView addSubview:buyMethedValueLabel];
    //[firstView addSubview:priceLabel];
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
    UILabel *courseFeatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 30)];
    courseFeatureLabel.text = @"课程特色";
    courseFeatureLabel.textColor = [UIColor blackColor];
    courseFeatureLabel.font = [UIFont systemFontOfSize:14];
    
    //分割线
    UILabel *courseFeatureLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-40, 1)];
    courseFeatureLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    UILabel *courseFeatureValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-40, 30)];
    courseFeatureValueLabel.text = self.courseInfo[@"feature"];
    courseFeatureValueLabel.textColor = [UIColor blackColor];
    //自动换行，自适应高度
    courseFeatureValueLabel.numberOfLines = 0;
    courseFeatureValueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize courseFeatureValueSize = [courseFeatureValueLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(courseFeatureValueLabel.frame.size.width, 2000.0) lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize courseFeatureValueSize = [courseFeatureValueLabel sizeThatFits:CGSizeMake(courseFeatureValueLabel.frame.size.width, MAXFLOAT)];
    if (courseFeatureValueSize.height > 30) {
        courseFeatureValueLabel.frame = CGRectMake(10, 30, kScreenWidth-40, courseFeatureValueSize.height);
    }else{
        courseFeatureValueLabel.frame = CGRectMake(10, 30, kScreenWidth-40,30);
    }
    
    courseFeatureValueLabel.font = [UIFont systemFontOfSize:12];
    
//-----------------------------------------------------------------
    CGFloat secondViewHeight = 30+courseFeatureValueLabel.frame.size.height;
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(10, orignalSecondHeight, kScreenWidth-20, secondViewHeight)];
    secondView.backgroundColor = [UIColor whiteColor];
    
    [secondView addSubview:courseFeatureLabel];
    [secondView addSubview:courseFeatureLabelLine];
    [secondView addSubview:courseFeatureValueLabel];

    
//-------------------------第三部分视图-----------------------------------------------------------

    CGFloat orignalThirdHeight = orignalSecondHeight + secondView.frame.size.height+10;
    //课程简介
    UILabel *courseIntroductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 30)];
    courseIntroductionLabel.text = @"课程简介";
    courseIntroductionLabel.textColor = [UIColor blackColor];
    courseIntroductionLabel.font = [UIFont systemFontOfSize:14];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-40, 8, 8, 15)];
    arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray.png"];
    
    UIButton *singleCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [singleCourseBtn setFrame:CGRectMake(10, 0, kScreenWidth-40, 30)];
    [singleCourseBtn addTarget:self action:@selector(singleCourseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    UILabel *courseIntroductionLabelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-40, 1)];
    courseIntroductionLabelLine.backgroundColor = [UIColor lightGrayColor];
//-----------------------------------------------------------------
    UILabel *courseIntroductionValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-40, 30)];
    courseIntroductionValueLabel.text = self.courseInfo[@"des"];
    courseIntroductionValueLabel.textColor = [UIColor blackColor];
    //自动换行，自适应高度
    courseIntroductionValueLabel.numberOfLines = 0;
    courseIntroductionValueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize courseIntroductionValueSize = [courseIntroductionValueLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(courseIntroductionValueLabel.frame.size.width, 2000.0) lineBreakMode:NSLineBreakByWordWrapping];
    courseIntroductionValueLabel.frame = CGRectMake(10, 30, kScreenWidth-40, courseIntroductionValueSize.height);
//    CGSize courseIntroductionValueSize = [courseIntroductionValueLabel sizeThatFits:CGSizeMake(courseIntroductionValueLabel.frame.size.width, MAXFLOAT)];
    
    //[courseIntroductionValueLabel sizeToFit];
    if (courseIntroductionValueSize.height > 30) {
        courseIntroductionValueLabel.frame = CGRectMake(10, 30, kScreenWidth-40, courseIntroductionValueSize.height);
    }else{
        courseIntroductionValueLabel.frame = CGRectMake(10, 30, kScreenWidth-40,30);
    }
    
    courseIntroductionValueLabel.font = [UIFont systemFontOfSize:12];
//-----------------------------------------------------------------
//    CGFloat secondViewHeight = 0;
//    if (courseIntroductionValueLabel.frame.size.height > 30) {
//        secondViewHeight = 230+targetStudentValueLabel.frame.size.height;
//    }else{
//        secondViewHeight = 230+30;
//    }
    CGFloat thirdViewHeight = 30+courseIntroductionValueLabel.frame.size.height;
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(10, orignalThirdHeight, kScreenWidth-20, thirdViewHeight)];
    thirdView.backgroundColor = [UIColor whiteColor];
    
    [thirdView addSubview:courseIntroductionLabel];
    [thirdView addSubview:arrowImageView];
    [thirdView addSubview:singleCourseBtn];
    [thirdView addSubview:courseIntroductionLabelLine];
    [thirdView addSubview:courseIntroductionValueLabel];
    
//------------------------------第四个视图----------------------------------------------------
    CGFloat orignalFourthHeight = orignalThirdHeight + thirdView.frame.size.height+10;
    
    UIView *fourthView = [[UIView alloc] initWithFrame:CGRectMake(10, orignalFourthHeight, kScreenWidth-20, 30)];
    fourthView.backgroundColor = [UIColor whiteColor];
    
    UILabel *courseCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
    courseCommentLabel.text = @"课程评价";
    courseCommentLabel.textColor = [UIColor blackColor];
    courseCommentLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *allCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-40-80, 0, 80, 30)];
    allCommentLabel.text = @"全部评价";
    allCommentLabel.textColor = [UIColor blackColor];
    allCommentLabel.textAlignment = NSTextAlignmentRight;
    allCommentLabel.font = [UIFont systemFontOfSize:12];
    
    UIImageView *arrowAllCommentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-35, 8, 8, 15)];
    arrowAllCommentImageView.image = [UIImage imageNamed:@"arrow_right_gray.png"];
    
    UIButton *singleCourseCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [singleCourseCommentBtn setFrame:CGRectMake(10, 0, kScreenWidth-20, 30)];
    [singleCourseCommentBtn addTarget:self action:@selector(singleCourseCommentBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [fourthView addSubview:courseCommentLabel];
    [fourthView addSubview:allCommentLabel];
    [fourthView addSubview:arrowAllCommentImageView];
    [fourthView addSubview:singleCourseCommentBtn];
    
    
//----------------------------------------------------------------------------------
    CGFloat backgroundViewHeight = orignalFourthHeight + fourthView.frame.size.height;
    
    UIView *backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor clearColor];
    //将视图1和视图2加入
    [backgroundView addSubview:firstView];
    [backgroundView addSubview:secondView];
    [backgroundView addSubview:thirdView];
    [backgroundView addSubview:fourthView];

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
        NSString *payMethod = self.courseInfo[@"pay_type"];
        vc.payMethodNumber = [payMethod intValue];
        vc.superPayMethodNumber = [payMethod intValue];
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

- (void)singleCourseCommentBtnPressed{
    SingleCourseCommentVC *vc = [[SingleCourseCommentVC alloc] init];
    vc.courseInfoDic = self.courseInfo;
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
                
                //判断是否支持试听功能，不能就置灰，不能用
                [self setListenBtnEnabled:self.courseInfo];
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
        return 1.0f;
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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
//    sectionHeadView.backgroundColor = [UIColor clearColor];
//    
//    if (section == 0) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 4, kScreenWidth-20, 30)];
//        view.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *courseCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
//        courseCommentLabel.text = @"课程评价";
//        courseCommentLabel.textColor = [UIColor blackColor];
//        courseCommentLabel.font = [UIFont systemFontOfSize:14];
//        
//        [view addSubview:courseCommentLabel];
//        
//        UILabel *allCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-20-80, 0, 80, 30)];
//        allCommentLabel.text = @"全部评价";
//        allCommentLabel.textColor = [UIColor blackColor];
//        allCommentLabel.textAlignment = NSTextAlignmentRight;
//        allCommentLabel.font = [UIFont systemFontOfSize:12];
//        
//        [view addSubview:allCommentLabel];
//        
//        [sectionHeadView addSubview:view];
//        
//        
//    }
//    return sectionHeadView;
//}

//根据courseInfo[@"is_pay_listen"]字段，判断是否能试听
//is_pay_listen 取值 0不能试听 1免费试听 2有偿服务 3免费&有偿。
- (void)setListenBtnEnabled:(NSDictionary *)courseInfo{
    
    NSNumber *isPayListen = courseInfo[@"is_pay_listen"];
    if (isPayListen.integerValue == 0) {
        [self.listenBtn setBackgroundColor:[UIColor grayColor]];
        self.listenBtn.enabled = NO;
    }
    else{
        
    }
}


@end
