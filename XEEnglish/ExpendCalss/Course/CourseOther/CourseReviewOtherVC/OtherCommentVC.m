//
//  OtherCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OtherCommentVC.h"

#import "OtherCommentVCCell.h"
#import "XeeService.h"
@interface OtherCommentVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;

@end

@implementation OtherCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程评论";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化数组
    self.commentArray = [NSMutableArray array];
    
    //网络请求评论数据
    [self getCourseScheduleSignParentCommentWithWeb];
    
    //定义tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
  
}

#pragma mark - Web
- (void)getCourseScheduleSignParentCommentWithWeb {
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [self showHudWithMsg:@"加载中..."];
    [[XeeService sharedInstance] getCourseScheduleSignParentCommentWithParentId:userInfoDic[uUserId] andCourseScheduleId:self.courseInfoDic[@"course_schedule_id"] andPageSize:10 andPageIndex:1 andSignonId:@"" andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                //查询这节课老师和家长的评论，传值signon_id课表签到id，course_schedule_id不传值。
                NSDictionary *commentDic = result[@"resultInfo"];
                self.commentArray = commentDic[@"data"];
                //NSLog(@"array:%@",self.myCommentArray);
                [self.tableView reloadData];
            }else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.commentArray count];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"OtherCommentVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"OtherCommentVCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    OtherCommentVCCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    cell.cellEdge = 10;
    cell.commentInfoDic = self.commentArray[indexPath.section];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
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
