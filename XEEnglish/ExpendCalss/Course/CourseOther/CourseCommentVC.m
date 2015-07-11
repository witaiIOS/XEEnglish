//
//  CourseCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseCommentVC.h"
#import "CourseCommentCell.h"

@interface CourseCommentVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UILabel *courseNameLabel;
@property (nonatomic, strong) NSMutableArray *commentArray;//评论数组


@end

@implementation CourseCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评论";
}

- (void)initUI{
    
    [super initUI];
    //设置页面的头和尾
    [self setHeadViewAndFootView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, kScreenWidth, kScreenHeight-64-30-30) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)setHeadViewAndFootView{
    //页面上端课名
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
    headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headView];
    
    UILabel *courseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, kScreenWidth-20, 24)];
    courseNameLabel.text = self.courseLeaveInfoDic[@"title"];
    courseNameLabel.font = [UIFont systemFontOfSize:14];
    courseNameLabel.textAlignment = NSTextAlignmentCenter;
    courseNameLabel.textColor = [UIColor lightGrayColor];
    courseNameLabel.backgroundColor = [UIColor whiteColor];
    
    [headView addSubview:courseNameLabel];
    
    //页面下端评论按钮
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 30)];
    footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footView];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commentBtn setFrame:CGRectMake(10, 3, kScreenWidth-20, 24)];
    [commentBtn setTitle:@"评论点什么吧" forState:UIControlStateNormal];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [commentBtn setBackgroundColor:[UIColor whiteColor]];
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:commentBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commentBtnClicked{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"CourseCommentVCCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"CourseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    
    CourseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    cell.cellEdge = 10;
    
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
